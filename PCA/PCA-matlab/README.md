# Problem description
Using PCA find four features (eigen images) that best represent the 2005-2013 Ford Mustang series.

# Solution
Each image is unfolded in a column vector and stacked in a matrix. The average image is subtracted and then the covariance matrix is computed. Then the eigendecomposition of the covariance matrix is found and the largest 4 eigenvectors that preserve most of the variance are plotted.
The results are shown in the following images:
![Average image](https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/PCA/PCA-matlab/average_image.jpg)
![Eigen images](https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/PCA/PCA-matlab/eigen_images.jpg)
![Sorted eigen values](https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/PCA/PCA-matlab/eigen_values.jpg)