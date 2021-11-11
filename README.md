# 2D Visualisation Methods for 3D Genome Data

The R code provided here was used to generate synthetic 3D models, create 3D visualisations of either synthetic or genomic 3D data sets and visualise the 3D data sets in 2D using either multidimensional scaling (MDS) or Sammon mapping. 

The files starting with "001" through "010" contain the code used to generate the synthetic 3D data sets. Each synthetic data set shows a different type of distribution of points inside a sphere. The code used to sample these synthetic 3D models is based on code by A. Baez-Ortega for sampling in the hypersphere, which can be found here: https://baezortega.github.io/2018/10/14/hypersphere-sampling/. 

File "02_3D_visualisation.R" contains code for generating 3D visualisations of the 3D data sets. In the code, an example data set is used that is called "GENOMIC_DATASET", however, the code works for the synthetic data sets as well, of course. In order to be able to generate the visualisations correctly, it is necessary to inspect the data set that is used in order to know which information (such as x-, y-, and z-values) is stored in which columns, and to make sure the names of the columns correspond to the names used in the code. 
Some examples for visualisation / colouring are given, however, these might also depend on the information within the actual data set. 
In the beginning of the file, the packages required for files "02" through "06" are listed. 

The files starting with "03", "04 and "05" contain the code used to generate 2D visualisations of 3D models using MDS using Euclidean distances as the distance metric (MDS1), MDS using squared Euclidean distances (MDS2) and Sammon mapping, respectively. The coordinates and colouring options again depend on the data set. The code was adapted from Josh Starmer / StatQuest: https://github.com/StatQuest/mds_and_pcoa_demo. 

File "06_RMSE" contains the code used to calculate the root mean squared error (RMSE) for the preservation of radial distances between the original 3D data set and the 2D data sets generated using MDS and Sammon mapping. 
