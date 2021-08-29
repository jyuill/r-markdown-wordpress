## Upload Blog Post and R Markdown to Wordpress Blog

library(RWordPress)
library(knitr)

## set up initial credentials & values needed
source('credite.R')
options(WordpressLogin= c(johnyuill=wp_p),
        WordpressURL=paste0('https://',wp_blog,'.wordpress.com/xmlrpc.php'))

# Set up Upload plots: set knitr options
## - saves files in a folder in WordPress
## can be found in Media section by date; will be named: <name of code chunk>-1.png
## - can edit caption, alt text, description, get URL
opts_knit$set(upload.fun = function(file){library(RWordPress);uploadFile(file)$url;})

# Include toc (comment out if not needed - if used, then abandoned, need to restart R session)
## this works but uses ALL headings - don't know how to limit
#library(markdown)
#options(markdown.HTML.options = c(markdownHTMLOptions(default = T),"toc"))

## KEY VARIABLES #############################################################
## info needed to run main code below
blogthumbnail <- "figure/temperature-plot-1.png"
blogfile <- "R-Markdown-WordPress.Rmd"
blogtitle <- "Publish R Markdown to WordPress site? Yes You Can!"
blogaction <- "newPost" ## "newPost", "editPost", "newPage"
blogpostid <- "" ## needed with editPost
blogcat <- c('R Stats', 'R Markdown')
##############################################################################

## run function - including saving plot images in figure folder
knit2wp(blogfile, ## markdown file to publish 
        title = blogtitle, ## title for the post in WordPress 
        publish = FALSE, ## FALSE to add as draft; TRUE to go direct to publish
        action = blogaction, # "newPost" for new post; alternatives: "editPost", "newPage"
        postid=blogpostid, ## needed with editPost - get from WP interface
        shortcode= FALSE, ## affects how source code is displayed; default is FALSE
        categories=blogcat, ## categories for blog post (need to be added first)
        wp_post_thumbnail=postThumbnail$id) 

# Upload featured image / post thumbnail: option: wp_post_thumbnail=postThumbnail$id
postThumbnail <- RWordPress::uploadFile(blogthumbnail,overwrite = TRUE)
