# Template for a Workshop Website

This serves as a template for others to use for a website. It is a simple, Rmarkdown, static website that can be used by others to start their website.

Best of luck!

## Getting Started

- `Fork` this website using the fork button in the upper right hand corner of the github page. This will copy the website to your own username.

- Or copy this website by downloading the files and then loading them into a *new* repository of your own naming.

- Change the `_site.yml` file to your information

- Change the `footer.html` to your name

- Verify the contents in the `_setup.Rmd` as these will be run on every Rmd file

- Add your references to the `library.bib` file (or dump your Mendely or Zotero BibTex references into this file)

Start writing!

## Use Github Pages

Right now everything is being written to `docs` folder which makes using Github pages easier. You can compile your website using `rmarkdown::render_site()` in the console. 

Push your files to your github repository.

Go to the settings for the project on Github and under the "Github pages"" options change the Sources option change this to master branch docs folder.

You should be able to find your new repo!
