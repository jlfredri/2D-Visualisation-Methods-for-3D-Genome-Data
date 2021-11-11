### RMSE ####


# if not in the data set already: calculate the radii (dfz) for the 3D data set 
GENOMIC_DATASET$dfz = sqrt(GENOMIC_DATASET$x^2 + GENOMIC_DATASET$y^2 + GENOMIC_DATASET$z^2)

# calculate the radii for the 2D MDS1 data set
GENOMIC_DATASET$dfz_mds1 = sqrt(mds1_data$X^2 + mds1_data$Y^2)

# calculate the radii for the 2D MDS2 data set 
GENOMIC_DATASET$dfz_mds2 = sqrt(mds2_data$X^2 + mds2_data$Y^2)

# calculate the radii for the 2D Sammon data set 
GENOMIC_DATASET$dfz_sammon = sqrt(sammon_data$X^2 + sammon_data$Y^2)

# depending on the actual radius of the model and the desired numbers of RMSE values, subdivide the data set 
GENOMIC_DATASET_0.2 = GENOMIC_DATASET[GENOMIC_DATASET$dfz <= 0.2, ]
GENOMIC_DATASET_0.4 = GENOMIC_DATASET[GENOMIC_DATASET$dfz > 0.2 & GENOMIC_DATASET$dfz <= 0.4, ]
GENOMIC_DATASET_0.6 = GENOMIC_DATASET[GENOMIC_DATASET$dfz > 0.4 & GENOMIC_DATASET$dfz <= 0.6, ]
GENOMIC_DATASET_0.8 = GENOMIC_DATASET[GENOMIC_DATASET$dfz > 0.6 & GENOMIC_DATASET$dfz <= 0.8, ]
GENOMIC_DATASET_1.0 = GENOMIC_DATASET[GENOMIC_DATASET$dfz > 0.8 & GENOMIC_DATASET$dfz <= 1.0, ]

# MDS1: calculate the RMSE values
RMSE_MDS1 = c(rmse(GENOMIC_DATASET_0.2$dfz, GENOMIC_DATASET_0.2$dfz_mds1), 
              rmse(GENOMIC_DATASET_0.4$dfz, GENOMIC_DATASET_0.4$dfz_mds1), 
              rmse(GENOMIC_DATASET_0.6$dfz, GENOMIC_DATASET_0.6$dfz_mds1), 
              rmse(GENOMIC_DATASET_0.8$dfz, GENOMIC_DATASET_0.8$dfz_mds1), 
              rmse(GENOMIC_DATASET_1.0$dfz, GENOMIC_DATASET_1.0$dfz_mds1))

# MDS2: calculate the RMSE values
RMSE_MDS2 = c(rmse(GENOMIC_DATASET_0.2$dfz, GENOMIC_DATASET_0.2$dfz_mds2), 
              rmse(GENOMIC_DATASET_0.4$dfz, GENOMIC_DATASET_0.4$dfz_mds2), 
              rmse(GENOMIC_DATASET_0.6$dfz, GENOMIC_DATASET_0.6$dfz_mds2), 
              rmse(GENOMIC_DATASET_0.8$dfz, GENOMIC_DATASET_0.8$dfz_mds2), 
              rmse(GENOMIC_DATASET_1.0$dfz, GENOMIC_DATASET_1.0$dfz_mds2))

# Sammon mapping: calculate the RMSE values
RMSE_Sammon = c(rmse(GENOMIC_DATASET_0.2$dfz, GENOMIC_DATASET_0.2$dfz_sammon), 
                rmse(GENOMIC_DATASET_0.4$dfz, GENOMIC_DATASET_0.4$dfz_sammon), 
                rmse(GENOMIC_DATASET_0.6$dfz, GENOMIC_DATASET_0.6$dfz_sammon), 
                rmse(GENOMIC_DATASET_0.8$dfz, GENOMIC_DATASET_0.8$dfz_sammon), 
                rmse(GENOMIC_DATASET_1.0$dfz, GENOMIC_DATASET_1.0$dfz_sammon))

# create a data frame for plotting
GENOMIC_DATASET_RMSE = data.frame(RMSE_MDS1, RMSE_MDS2, RMSE_Sammon)
GENOMIC_DATASET_RMSE$breaks = c(0.2, 0.4, 0.6, 0.8, 1.0)

# plot the RMSE values
RMSE_colours = viridis_pal(option = "H")(7)
colours = c("RMSE_MDS1" = "#E4460AFF", "RMSE_MDS2" = "#7A0403FF", "RMSE_Sammon" = "#1AE4B6FF")
x_labels <- c("[0, 0.2]", "[0.2, 0.4]", "[0.4, 0.6]", "[0.6, 0.8]", "[0.8, 1.0]")

ggplot(GENOMIC_DATASET_RMSE) + 
  scale_x_continuous(breaks=GENOMIC_DATASET_RMSE$breaks, labels=x_labels, limits=c(0.01,1.1)) +
  geom_point(aes(x=dfz, y = RMSE_MDS1, color = "RMSE_MDS1"), size = 3.5) +
  geom_text(aes(x=dfz, y = RMSE_MDS1, color = "RMSE_MDS1", label = round(RMSE_MDS1, 3)), nudge_y = +0.008) + 
  geom_point(aes(x=dfz, y = RMSE_MDS2, color = "RMSE_MDS2"), size = 3.5) + 
  geom_text(aes(x=dfz, y = RMSE_MDS2, color = "RMSE_MDS2", label = round(RMSE_MDS2, 3)), nudge_y = +0.008) + 
  geom_point(aes(x=dfz, y = RMSE_Sammon, color = "RMSE_Sammon"), size = 3.5) + 
  geom_text(aes(x=dfz, y = RMSE_Sammon, color = "RMSE_Sammon", label = round(RMSE_Sammon, 3)), nudge_y = -0.008) + 
  theme_bw() + coord_fixed(ratio = 1) + ggtitle("RMSE Plot: GENOMIC DATA SET") + 
  labs(x = "Distance from the centre", y = "RMSE", color = "Legend") +
  scale_color_manual(values = colours, labels = c("MDS1", "MDS2", "Sammon \nmapping"))

