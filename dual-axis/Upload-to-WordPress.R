## Upload R Markdown Blog Post to Wordpress Blog
## reference: https://catbirdanalytics.wordpress.com/2021/08/02/publish-r-markdown-to-wordpress-site-yes-you-can/
## This file will work from within any repo/folder - as long as the KEY VARIABLES are adjusted accordingly.
## However: it is recommended that the blog post .Rmd file be copied into a dedicated folder in the 
## r-markdown-wordpress repo for better organization, etc.

library(RWordPress)
library(knitr)
library(here)

## KEY VARIABLES #############################################################
## usually only changes needed; check knit2wp function
## -- FOLDER: specify folder that blog post is in
blogfldr <- "dual-axis"
## -- RMARKDOWN file to publish
blogfile <- paste0(blogfldr,"/Dual-Axis-Temptation.Rmd")
## -- BLOG TITLE
blogtitle <- "The Temptation of Dual-Axis Charts"
## --  PUBLISH or DRAFT?
pub <- FALSE ## TRUE to publish; FALSE for draft
## -- NEW OR EDIT? 
blogaction <- "newPost" ## "newPost", "editPost", "newPage"
## -- ID: needed for EDIT -> need to **UNCOMMENT postid** in knit2wp function
blogpostid <- "" ## needed with editPost - can get from WP interface, click on post to edit, check URL
## -- CATEGORY - needs to be added previously in WP
blogcat <- c('R Stats', 'R Markdown', 'Dataviz')
## -- THUMBNAIL: specific plot; plots are stored in the top-level 'figure' folder
blogthumbnail <- paste0(blogfldr,"/images/btc-ada-thumbnail.png") 
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

## FEATURE IMAGE: Upload featured image / post thumbnail: option: wp_post_thumbnail=postThumbnail$id
postThumbnail <- RWordPress::uploadFile(blogthumbnail,overwrite = TRUE)

## UPLOAD TO WORDPRESS - will create plot images in figure folder
knit2wp(input=blogfile, 
        title = blogtitle, 
        publish = pub, ## FALSE for draft; TRUE to publish
        action = blogaction, # "newPost" or "editPost"; also "newPage"
        #postid=blogpostid, ## needed with editPost - get from WP interface
        shortcode= FALSE, ## affects how source code is displayed; default is FALSE
        categories=blogcat,
        wp_post_thumbnail=postThumbnail$id)

