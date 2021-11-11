### Synthetic data generation ####


# generate 1000 points with a mean of 0.5 and a standard deviation of 0.7
set.seed(1)
X = sapply(1:3, function(d) {
  rnorm(n=1000, mean=0.5, sd=0.7)
})

# Normalise all distances (radii) to 1
radii = apply(X, 1, function(s) {
  sqrt(sum(s ^ 2))
})

X_s = X / radii

# sample 1000 radii with an exponential distribution
new_radii = runif(n=1000) ^ (1 / 3)
X_i_random = X_s * new_radii

# make a matrix containing coordinates and new radii (distances from center)
random = cbind(X_i_random, new_radii)
colnames(random) = c("x", "y", "z", "distance_from_zero")

# save the matrix ("random") as a .csv file 
write.csv(random, "/path/to/directory/random.csv", row.names = TRUE)

# in order to colour the points according to their distance from the centre of the cluster
# calculate the arithmetic mean of the 3 sets of coordinates
a = mean(random$x)
b = mean(random$y)
c = mean(random$z)

# calculate the Euclidean distances between the points and the mean
distances = sqrt((a - random$x)^2 + (b - random$y)^2 + (c - random$z)^2)

# add vector to matrix
random = cbind(random, distances)

# generate a (different) continuous color palette
rbPal_2 = colorRampPalette(c("#A80068","#EBD510"))
random$col2 = rbPal_2(10)[as.numeric(cut(random$distances, breaks = 10))]
