### Synthetic data generation ####


# generate 1000 points from normal distributed (pseudorandom) coordinates
set.seed(1)
X = sapply(1:3, function(d) {
  rnorm(n=1000)
})

## Normalise all distances (radii) to 1
radii = apply(X, 1, function(s) {
  sqrt(sum(s ^ 2))
})

X_s = X / radii

# multiply the exponent (1/3) by a number < 1 to let the points cluster in the periphery
new_radii = runif(n=1000, min = 0, max = 1) ^ ((1 / 3)*0.3)
X_i_periphery = X_s * new_radii 

# make a matrix containing coordinates and new radii (distances from center)
periphery = cbind(X_i_periphery, new_radii)
colnames(periphery) = c("x", "y", "z", "distance_from_zero")

# save the matrix ("periphery") as a .csv file 
write.csv(periphery, "/path/to/directory/periphery.csv", row.names = TRUE)
