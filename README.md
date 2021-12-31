# proj-catbird-blog

Content for Catbird Analytics Blog, including complete process for publishing R Markdown to Wordpress.

My blogpost [Publish R Markdown to Wordpress? Yes you can!](https://catbirdanalytics.wordpress.com/2021/08/02/publish-r-markdown-to-wordpress-site-yes-you-can/) explains how this all works. 

## General Process

Key thing to note is that after your create your RMarkdown file, it is not simply a matter of knitting it, generating html output and then loading that html file into Wordpress. Rather, you use a separate pkg - RWordPress - to knit the Rmd file and publish it to WordPress as one process.

1. **Produce your RMarkdown** file as blog post. Can be in this repository or any repository you like.
2. **Copy RMarkdown** file to a new folder in this repo for the topic\* along with any **data or static image files** needed.
3. **Copy the Upload-to-Wordpress.R** file into same folder.
4. **Change the parameters** in the Upload-to-Wordpress-vX.R file to match your intentions. 
   - Key parameters are in the KEY VARIABLES section; usually they all must be changed.
5. **Run Upload-to-Wordpress.R** file.
6. Check on Wordpress - repeat as nec.
  
\* Alternatively, you can copy the 'Upload-to-Wordpress.R' file to your original repo and publish to Wordpress directly from there. The advantages to copying into this repo are that it is easier to keep track of what you have posted, in case you want to make changes, allows you to do a customized version of the file specifically for blogpost, etc. Just cleaner overall.

## PLOTS

In order for plots to be included:

- .png image files of plots need to be created - this will happen automatically when Upload-to-Wordpress.R is run.
- name of code chunk will determine image file names. (e.g. {r plot} code chunk will result in 'plot-1.png' file)
- the files will end up in /figure folder for the repo.

Thumbnail:

- good idea to create a simplified version of a representative plot for the thumbnail.
- can also use this as lead image at top of post for a visual.
- topic folders, such as /dual-axis have examples 'Thumbnail-image.R' files as template for creating/saving thumbnail images.
- can be stored in /image folder within topic repo and linked from Upload-to-Wordpress.R file.

