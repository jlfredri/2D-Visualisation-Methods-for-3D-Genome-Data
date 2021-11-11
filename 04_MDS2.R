### MDS2 ####


# prepare the data set for MDS / calculating the distance matrix
GENOMIC_DATASET_matrix = cbind(GENOMIC_DATASET$x, GENOMIC_DATASET$y, GENOMIC_DATASET$z)

# calculate the distance matrix M using squared Euclidean distances 
M2 = distance(GENOMIC_DATASET_matrix, X2 = NULL)

# perform MDS 
mds2_calculation = cmdscale(M2, eig=TRUE, x.ret=TRUE)

# determine the percentage of variation each MDS axis accounts for 
mds2_percentage = round(mds2_calculation$eig/sum(mds2_calculation$eig)*100, 1)

# prepare the data for plotting; 0000 is the number of points of the data set
mds2_points = mds2_calculation$points
rownames(mds2_points) = paste("p", 1:0000, sep="")
mds2_data = data.frame(Sample=rownames(mds2_points), X=mds2_points[,1], Y=mds2_points[,2])

# generate the MDS2 plot
ggplot(data=mds2_data, aes(x=X, y=Y, label=Sample, col = GENOMIC_DATASET$col2)) + geom_point(size = 2.5) + theme_bw() + scale_colour_identity() + coord_fixed(ratio = 1) + xlab(paste("MDSv1 - ", mds2_percentage[1], "%", sep="")) + ylab(paste("MDSv2 - ", mds2_percentage[2], "%", sep="")) + ggtitle("MDS2 Plot: GENOMIC DATA SET")

