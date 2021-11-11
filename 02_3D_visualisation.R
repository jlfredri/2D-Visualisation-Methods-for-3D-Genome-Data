### load required packages ####
library(ggplot2)
library(laGP)
library(rgl)
library(plotrix)
library(MASS)
library(Metrics)
library(viridis)


### 3D visualisation ####


# import the file; specify if necessary: head = FALSE, sep = "", fill = TRUE
GENOMIC_DATASET = read.csv("/path/to/file.filetype")

# depending on the file, add names to the columns in the dataset
colnames(GENOMIC_DATASET) = c("aaa", "bbb", "ccc", "ddd", "Chromosome", "x", "y", "z", "dfz", "bead_radius", "Specification")

# colour the points according to specifications ...
GENOMIC_DATASET$col1 = ifelse(GENOMIC_DATASET$Specification == "HH", "#A80068", ifelse(GENOMIC_DATASET$ddd == "PPP", "#9F0CF5", ifelse(GENOMIC_DATASET$ddd == "AAA", "#F58627", "#66ECF5")))

# ... or according to their distance from the centre ...
rbPal = colorRampPalette(c("#9F0CF5","#66ECF5"))
GENOMIC_DATASET$col2 = rbPal(10)[as.numeric(cut(GENOMIC_DATASET$dfz, breaks = 10))]

# ... or according to subsets like individual chromosomes, etc. 
chromosome_colours = viridis_pal(option = "H")(23)
GENOMIC_DATASET$col3 = chromosome_colours[as.factor(GENOMIC_DATASET$Chromosome)]

# plot
plot3d(GENOMIC_DATASET$x, GENOMIC_DATASET$y, GENOMIC_DATASET$z, col = GENOMIC_DATASET$col2, type = "p", size = 3, radius = GENOMIC_DATASET$bead_radius, xlab = "x: Distance", ylab = "y: Distance", zlab = "z: Distance")

# add a title and a legend
bgplot3d({
  plot.new()
  color.legend(0.71, 0.35, 0.74, 0.65, rect.col=rbPal(10), legend= c(" Centre", " Periphery"), gradient="y", cex = 1.9,align = "rb", text(0.5,1, font = 2, "GENOMIC DATA SET"), text(0.78,0.74,"Approximate \ndistance from \nthe centre"))
})

# save an image
rgl.snapshot("GENOMIC_DATASET.png", fmt = 'png')

