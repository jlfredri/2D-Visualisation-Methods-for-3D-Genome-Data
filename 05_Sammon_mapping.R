### Sammon Mapping ####


# prepare the data set 
GENOMIC_DATASET_matrix = cbind(GENOMIC_DATASET$x, GENOMIC_DATASET$y, GENOMIC_DATASET$z)

# calculate the distance matrix using Euclidean distances 
M = dist(scale(GENOMIC_DATASET_matrix, center=TRUE, scale=FALSE), method="euclidean")

# perform Sammon mapping calculations
S = sammon(M)

# prepare the data for plotting; 0000 is the number of points of the data set
sammon_points = S$points
rownames(sammon_points) = paste("p", 1:0000, sep="")
sammon_data = data.frame(Sample=rownames(sammon_points), X=sammon_points[,1], Y=sammon_points[,2])

# generate the Sammon projection
ggplot(data=sammon_data, aes(x=X, y=Y, label=Sample, col = GENOMIC_DATASET$col2)) + geom_point(size = 2.5) + theme_bw() + scale_colour_identity() + coord_fixed(ratio = 1) + ggtitle("Sammon Mapping: GENOMIC DATA SET")
