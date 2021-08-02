## Packages needed to post R markdown on Wordpress Blog

## References:
## http://tabvizexplorer.com/how-to-upload-r-markdown-directly-to-wordpress/

## Get required packages
if (!require('knitr')) {install.packages("knitr")}
if (!require('devtools')) {install.packages("devtools")}
if (!require('RWordPress')) {devtools::install_github(c("duncantl/XMLRPC", "duncantl/RWordPress"))}

# options(WordpressLogin = c(user = 'PASSWORD'),
#         WordpressURL = 'http://YOURWEBSITE.com/xmlrpc.php')
# 
# knit2wp('post.RmD',
#         title = 'YOUR TITLE',
#         publish = FALSE,
#         action = "newPost")
