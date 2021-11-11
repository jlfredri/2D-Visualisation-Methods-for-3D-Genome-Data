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

# sample 1000 radii with an exponential distribution
new_radii = runif(n=1000, min = 0, max = 1) ^ (1 / 3)
X_i_uniform = X_s * new_radii 

# create a matrix containing coordinates and new radii (distances from the center)
uniform = cbind(X_i_uniform, new_radii)
colnames(uniform) = c("x", "y", "z", "distance_from_zero")

# save the matrix ("uniform") as a .csv file 
write.csv(uniform, "/path/to/directory/uniform.csv", row.names = TRUE)
