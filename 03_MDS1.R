### MDS1 ####


# prepare the data set for MDS / calculating the distance matrix
GENOMIC_DATASET_matrix = cbind(GENOMIC_DATASET$x, GENOMIC_DATASET$y, GENOMIC_DATASET$z)

# calculate the distance matrix using Euclidean distances
M1 = dist(scale(GENOMIC_DATASET_matrix, center=TRUE, scale=FALSE), method="euclidean")

# perform MDS 
mds1_calculation = cmdscale(M1, eig=TRUE, x.ret=TRUE)

# determine the percentage of variation each MDS axis accounts for 
mds1_percentage = round(mds1_calculation$eig/sum(mds1_calculation$eig)*100, 1)

# prepare the data for plotting; 0000 is the number of points of the data set
mds1_points = mds1_calculation$points
rownames(mds1_points) = paste("p", 1:0000, sep="")
mds1_data = data.frame(Sample=rownames(mds1_points), X=mds1_points[,1], Y=mds1_points[,2])

# generate the MDS1 plot
ggplot(data=mds1_data, aes(x=X, y=Y, label=Sample, col = GENOMIC_DATASET$col2)) + geom_point(size = 2.5) + theme_bw() + scale_colour_identity() + coord_fixed(ratio = 1) + xlab(paste("MDSv1 - ", mds1_percentage[1], "%", sep="")) + ylab(paste("MDSv2 - ", mds1_percentage[2], "%", sep="")) + ggtitle("MDS1 Plot: GENOMIC DATA SET")
