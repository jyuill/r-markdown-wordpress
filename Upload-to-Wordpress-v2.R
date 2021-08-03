## Upload Blog Post and R Markdown to Wordpress Blog

library(RWordPress)
library(knitr)

## set up values needed
source('credite.R')
blogthumbnail <- "figure/temperature-plot-1.png"
blogfile <- "R-Markdown-WordPress.Rmd"
blogtitle <- "Publish R Markdown to WordPress site? Yes You Can!"
blogaction <- "newPost" ## "newPost", "editPost", "newPage"
blogpostid <- ""
blogcat <- c('R Stats', 'R Markdown')

options(WordpressLogin= c(johnyuill=wp_p),
       WordpressURL=paste0('https://',wp_blog,'.wordpress.com/xmlrpc.php'))

# Include toc (comment out if not needed)
## this works but uses ALL headings - don't know how to limit
#library(markdown)
#options(markdown.HTML.options = c(markdownHTMLOptions(default = T),"toc"))

# Upload plots: set knitr options
## - saves files in a folder in WordPress
## can be found in Media section by date; will be named: <name of code chunk>-1.png
## - can edit caption, alt text, description, get URL
opts_knit$set(upload.fun = function(file){library(RWordPress);uploadFile(file)$url;})

# Upload featured image / post thumbnail: option: wp_post_thumbnail=postThumbnail$id
postThumbnail <- RWordPress::uploadFile(blogthumbnail,overwrite = TRUE)

knit2wp(blogfile, ## markdown file to publish 
        title = blogtitle, ## title for the post in WordPress 
        publish = FALSE, ## FALSE to add as draft; TRUE to go direct to publish
        action = blogaction, # "newPost" for new post; alternatives: "editPost", "newPage"
        #postid=blogpostid, ## needed with editPost - get from WP interface
        shortcode= FALSE, ## affects how source code is displayed; default is FALSE
        categories=blogcat, ## categories for blog post (need to be added first)
        wp_post_thumbnail=postThumbnail$id) 
