## Thumbnail for blog post - customized variation on charts in post

library(tidyverse)
library(scales)
library(here)

## get data
## uses data frame created during Dual-Axis-Alternatives.Rmd

## set filename and path for saving
fname <- 'btc-ada-pc-chg-bars.png'
pname <- here('dual-axis','images')
  
## create chart - ggsave will save
## side-by-side bar plot
crypto_data_pc_wk_lg %>% ggplot(aes(x=date, y=pc_chg, fill=currency))+
  geom_col(position = position_dodge2())+
  geom_hline(yintercept=0, size=0.5, color='gray')+
  scale_y_continuous(labels=percent_format())+
  labs(x="", y='')+
  theme(legend.position = 'none',
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.line.y = element_line(size=0.5, color='gray'),
        axis.ticks.y = element_line(color='gray'))
## SAVE plot at desired size and location
ggsave(filename=fname, path=pname, scale=1, height=1.5, width=8)
