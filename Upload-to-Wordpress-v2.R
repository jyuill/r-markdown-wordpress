## Upload Blog Post and R Markdown to Wordpress Blog

library(RWordPress)
library(knitr)

source('credite.R')

options(WordpressLogin= c(johnyuill=wp_p),
       WordpressURL=paste0('https://',wp_blog,'.wordpress.com/xmlrpc.php'))

# Upload plots: set knitr options
## this works but:
## - saves files in a folder in WordPress
## http://catbirdanalytics.files.wordpress.com/YYYY/MM/<name of code chunk>-1.png
## throws Warnings about deprecated functions :(
opts_knit$set(upload.fun = function(file){library(RWordPress);uploadFile(file)$url;})

knit2wp('R-Markdown-WordPress-v4.Rmd', ## markdown file to publish 
        title = "R Markdown to WP? Yes You Can!", ## title for the post in WordPress 
        publish = FALSE, ## FALSE to add as draft; TRUE to go direct to publish
        action = "editPost", # "newPost", ## for new post; alternatives: "editPost", "newPage"
        postid='816', ## needed with editPost - get from WP interface
        shortcode= FALSE, ## affects how source code is displayed; default is FALSE
        categories=c('R Stats','R Markdown')) ## associate with categories (need to be added first)

## alternative approach to figures: [DOESN'T WORK!]
## 1. use ggsave to save charts with desired name/location locally (at least for ggplot2)
## 2. use googledrive to upload file to GDrive
## 3. embed link to GDrive location
