#!/usr/bin/env Rscript
#Source is Ryan Thompson via Stack Overflow:
#https://gist.github.com/DarwinAwardWinner/ed75d6d845975a577c8533ac060d6d34

suppressPackageStartupMessages({
  library(globals)
  library(readr)
  library(stringr)
  library(rex)
  library(magrittr)
  library(rlang)
  library(knitr)
  library(assertthat)
  library(withr)
  library(glue)
  library(BiocParallel)
  register(MulticoreParam())
})

match_identical <- function(x, table, nomatch=NA_integer_) {
  assert_that(is_list(table))
  for (i in seq_along(table)) {
    if (identical(x, table[[i]])) {
      return(i)
    }
  }
  return(nomatch)
}

get_Rmd_source <- function(fname) {
  with_tempfile("temp", {
    purl(fname, output=temp, quiet=TRUE)
    read_file(temp)
  })
}

analyze_pkg_usage <- function(fname) {
  if (str_detect(fname, regex(rex(".Rmd", end), ignore_case=TRUE))) {
    ## Rmd file
    file_text <- get_Rmd_source(fname)
  } else {
    # R file
    file_text <- read_file(fname)
  }
  lib_regex <- rex(
    "library",
    zero_or_more(space),
    "(",
    zero_or_more(space),
    capture(one_or_more(any, type="lazy")),
    zero_or_more(space),
    one_of(",", ")"))
  loaded_pkgs <- unique(do.call(rbind, str_match_all(file_text, lib_regex))[,2])
  missing_pkgs <- character(0)
  for (pkg in loaded_pkgs) {
    if (!suppressMessages(suppressWarnings(
      library(package=pkg, character.only=TRUE, logical.return = TRUE)))) {
      missing_pkgs <- c(missing_pkgs, pkg)
    }
  }
  loaded_pkgs %<>% setdiff(missing_pkgs)
  package_envs <- loaded_pkgs %>% set_names %>%
    lapply(. %>% str_c("package:", .) %>% as.environment)
  package_namespaces <- loaded_pkgs %>% set_names %>% lapply(asNamespace)
  
  file_exprs <- parse(text=file_text)
  expr_globals <- lapply(file_exprs, globalsOf, mustExist=FALSE)
  used_envs <- unique(do.call(c, lapply(expr_globals, attr, "where")))
  used_pkgs <- character(0)
  for (env in used_envs) {
    for (envlist in list(package_envs, package_namespaces)) {
      found <- match_identical(env, envlist)
      if (!is.na(found)) {
        used_pkgs <- c(used_pkgs, names(envlist)[found])
        break()
      }
    }
  }
  
  pkg_usage <- list(Used = used_pkgs,
                    Unused = setdiff(loaded_pkgs, used_pkgs))
  if (length(missing_pkgs) > 0) {
    pkg_usage$Missing <- missing_pkgs
  }
  pkg_usage
}

fnames <- commandArgs(TRUE)

pkg_usage <- bplapply(set_names(fnames), function(fname) {
  message("Analyzing ", deparse(fname))
  try(analyze_pkg_usage(fname))
})

message("Package usage:")
print(pkg_usage)
saveRDS(pkg_usage, "pkg_usage.RDS")