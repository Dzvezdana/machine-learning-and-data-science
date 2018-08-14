# Problem description
Using PCA find four features (eigen images) that best represent the 2005-2013 Ford Mustang series.

# Solution
Each image is unfolded in a column vector and stacked in a matrix. The average image is subtracted and then the covariance matrix is computed. Then the eigendecomposition of the covariance matrix is found and the largest 4 eigenvectors that preserve most of the variance are plotted.
The results are shown in the following images:
Average image:  
<p align="center">
	<img src="https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/PCA/PCA-matlab/average_image.jpg">  
</p>
    
Eigen images:  
<p align="center">
	<img src="https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/PCA/PCA-matlab/eigen_images.jpg">  
</p>
  
Sorted eigen values:  
<p align="center">
	<img src="https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/PCA/PCA-matlab/eigen_values.jpg" width="460" height="300">  
</p>
