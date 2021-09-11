## Upload R Markdown Blog Post to Wordpress Blog
## reference: https://catbirdanalytics.wordpress.com/2021/08/02/publish-r-markdown-to-wordpress-site-yes-you-can/

library(RWordPress)
library(knitr)

## KEY VARIABLES #############################################################
## usually only changes needed; check knit2wp function
## -- FOLDER: specify folder that blog post is in
blogfldr <- "google-trends"
## -- RMARKDOWN file to publish
blogfile <- paste0(blogfldr,"/google-trends-01.Rmd")
## -- BLOG TITLE
blogtitle <- "Google Trends + R: Leverage gtrendsR Package for More Powerful Analytics"
## -- NEW OR EDIT? 
blogaction <- "newPost" ## "newPost", "editPost", "newPage"
## -- ID: needed for EDIT -> need to **UNCOMMENT postid** in knit2wp function
blogpostid <- "" ## needed with editPost
## -- CATEGORY - needs to be added previously in WP
blogcat <- c('R Stats', 'R Markdown')
## -- THUMBNAIL: specific plot; plots are stored in the top-level 'figure' folder
blogthumbnail <- "figure/search-interest-over-time-1.png" 
##############################################################################

## CREDENTIALS: set up initial credentials & values needed
source('credite.R')
options(WordpressLogin= c(johnyuill=wp_p),
        WordpressURL=paste0('https://',wp_blog,'.wordpress.com/xmlrpc.php'))

## PLOTS: Set up Upload plots: set knitr options
## - saves files in WordPress: Media section by date; name: <code chunk name>-1.png
opts_knit$set(upload.fun = function(file){library(RWordPress);uploadFile(file)$url;})

# Include toc (comment out if not needed - if used, then abandoned, need to restart R session)
## this works but uses ALL headings - don't know how to limit
#library(markdown)
#options(markdown.HTML.options = c(markdownHTMLOptions(default = T),"toc"))

## UPLOAD TO WORDPRESS - will create plot images in figure folder
knit2wp(input=blogfile, 
        title = blogtitle, 
        publish = FALSE, ## FALSE for draft; TRUE to publish
        action = blogaction, # "newPost" or "editPost"; also "newPage"
        #postid=blogpostid, ## needed with editPost - get from WP interface
        shortcode= FALSE, ## affects how source code is displayed; default is FALSE
        categories=blogcat,
        wp_post_thumbnail=postThumbnail$id)

## FEATURE IMAGE: Upload featured image / post thumbnail: option: wp_post_thumbnail=postThumbnail$id
postThumbnail <- RWordPress::uploadFile(blogthumbnail,overwrite = TRUE)
