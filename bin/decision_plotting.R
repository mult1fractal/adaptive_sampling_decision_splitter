#!/usr/bin/env Rscript


library(ggplot2)
library(viridis)



#setwd ("/input")
df <- read.csv(file = 'decision_plot.csv')


p <- ggplot(data=df, aes(x=bin, y=cnt, fill=state)) + 
    geom_bar(stat='identity', position='fill') + 
    theme_minimal() + 
    scale_fill_brewer(palette='Set2') +
    xlab('read length') +
    ylab('fraction')
svg("decision_plot.svg", width = 20, height = 20)
print(p)
dev.off()






# docker run --rm -it -v $PWD:/input nanozoo/r_ggpubr:0.2.5--4b52011

# install.packages("gridExtra")

# library(ggplot2)
# library(viridis)
# library(gridExtra) #arrangeGrob()

# setwd ("/input")
# df <- read.csv(file = 'decision_plot.csv')
# df2 <- read.csv(file = 'decision_plot_single_control_depletion.csv')
# df3 <- read.csv(file = 'decision_plot_single_control_enrich.csv')
# df4 <- read.csv(file = 'decision_plot_batch1.csv')
# df5 <- read.csv(file = 'decision_plot_batch2.csv')



 #plots
 ## theme for all
#  uniformtheme <- theme_classic() +
#  		 theme(legend.position="top", legend.direction="vertical", legend.title = element_blank()) +
#    		 theme(axis.title.x=element_blank(),
#          		axis.text.x=element_blank(),
#          		axis.ticks.x=element_blank())
#  this_base = "decision_collection"


# p <- ggplot(data=df, aes(x=bin, y=cnt, fill=state)) + 
#     geom_bar(stat='identity', position='fill') + 
#     theme_minimal() + 
#     scale_fill_brewer(palette='Set2') +
#     ggtitle("control_plot") +
#     xlab('read length') +
#     ylab('fraction')
# svg("decision_plot.svg", width = 20, height = 20)
# print(p)
# dev.off()

# p2 <- ggplot(data=df2, aes(x=bin, y=cnt, fill=state)) + 
#     geom_bar(stat='identity', position='fill') + 
#     theme_minimal() + 
#     scale_fill_brewer(palette='Set2') +
#     ggtitle("single_control_depletion") +
#     xlab('read length') +
#     ylab('fraction')
# svg("decision_plot.svg", width = 20, height = 20)
# print(p2)
# dev.off()

# p3 <- ggplot(data=df3, aes(x=bin, y=cnt, fill=state)) + 
#     geom_bar(stat='identity', position='fill') + 
#     theme_minimal() + 
#     scale_fill_brewer(palette='Set2') +
#     ggtitle("single_control_enrich") +
#     xlab('read length') +
#     ylab('fraction')
# svg("decision_plot.svg", width = 20, height = 20)
# print(p3)
# dev.off()

# p4 <- ggplot(data=df4, aes(x=bin, y=cnt, fill=state)) + 
#     geom_bar(stat='identity', position='fill') + 
#     theme_minimal() + 
#     scale_fill_brewer(palette='Set2') +
#     ggtitle("batch1") +
#     xlab('read length') +
#     ylab('fraction')
# svg("decision_plot.svg", width = 20, height = 20)
# print(p4)
# dev.off()

# p5 <- ggplot(data=df5, aes(x=bin, y=cnt, fill=state)) + 
#     geom_bar(stat='identity', position='fill') + 
#     theme_minimal() + 
#     scale_fill_brewer(palette='Set2') +
#     ggtitle("batch2") +
#     xlab('read length') +
#     ylab('fraction')
# svg("decision_plot.svg", width = 20, height = 20)
# print(p5)
# dev.off()

# multi <- arrangeGrob(p, p2, p3, p4, p5, ncol = 3)
# ggsave(paste0(this_base, ".png"), multi, width = 12, height = 6) 

# print("Done")
