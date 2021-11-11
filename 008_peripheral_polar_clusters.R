### Synthetic data generation ####


# generate 1000 points from normal distributed (pseudorandom) coordinates
set.seed(1)
X = sapply(1:3, function(d) {
  rnorm(n=1000)
})

# multiply one set of the coordinates (x, y or z) by a number > 1 to let the points cluster at the poles
# for x-coordinates: 
X_1 = X[,1] * 5
X_2 = X[,-1]
X_pp = cbind(X_1, X_2)

# for y-coordinates: 
# X_3 = X[,2] * 5
# X_4 = X[,-2]
# X_pp = cbind(X_3, X_4)

# for z-coordinates: 
# X_5 = X[,3] * 5
# X_6 = X[,-3]
# X_pp = cbind(X_5, X_6)

## Normalise all distances (radii) to 1
radii = apply(X_pp, 1, function(s) {
  sqrt(sum(s ^ 2))
})

X_s = X_pp / radii

# multiply the exponent (1/3) by a number < 1 to let the points cluster in the periphery
new_radii = runif(n=1000, min = 0, max = 1) ^ ((1 / 3)*0.3)
X_i_pp = X_s * new_radii 

# make a matrix containing coordinates and new radii (distances from center)
pp = cbind(X_i_pp, new_radii)
colnames(pp) = c("x", "y", "z", "distance_from_zero")

# save the matrix ("pp") as a .csv file 
write.csv(pp, "/path/to/directory/pp.csv", row.names = TRUE)
