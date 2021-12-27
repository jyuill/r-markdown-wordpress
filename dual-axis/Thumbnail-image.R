## Thumbnail for blog post - customized variation on charts in post

library(tidyverse)
library(scales)

## get data
## import crypto data
crypto_data <- read_csv(here('dual-axis','input','btc-ada-price.csv'))

## create chart then top menu: Plots > Save as image
transfm <- median(crypto_data$BTC_CAD)/median(crypto_data$ADA_CAD)
col_left <- 'darkgoldenrod3'
col_right <- 'blue'
ch_title <- paste0('BTC vs ADA')
crypto_data %>% ggplot(aes(x=date)) +
  geom_line(aes(y=BTC_CAD), color=col_left)+
  geom_line(aes(y=ADA_CAD*transfm), color=col_right)+
  # Custom the Y scales:
  scale_y_continuous(
    # Features of the first axis
    name = "", labels=dollar_format(),
    # Add a second axis and specify its features
    sec.axis = sec_axis(~./transfm, name="")
  )+labs(title=ch_title, x="")