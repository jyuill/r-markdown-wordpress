library(devtools)
install_github(repo="jyuill/rmdTemplates") ## fail with ERROR: failed to lock directory
install_github(repo="kbroman/broman") ## succes 

devtools::install("../rmdTemplates") ## starts but same issue

install_github(repo='jyuill/rmdTemplates')
install.packages("../rmdTemplates", INSTALL_opts = '--no-lock')


devtools::install("../templateRmd")

library(templateRmd)

install_github(repo="jyuill/templateRmd")
