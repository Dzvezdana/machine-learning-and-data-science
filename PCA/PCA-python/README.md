# Problem description
Find the approximate location and angle of the wrench using elements from PCA.

# Solution
The code opens an image, finds the orientation of the detected object of interest and then visualizes the result by drawing the contours of the detected object of interest, the x and the y axis regarding the extracted orientation.

Additionally the object can be vertically aligned on the major axis by using an anticlockwise rotation transformation matrix.

The location of the wrench is given by the principal components and that the principal components can be interpreted as the semiaxes of an ellipse in 2D. Before applying PCA, it is necessary to do some preprocessing like thresholding and finding the edges.
The results are shown in the following images:  
  
Original image:  
<p align="center">
	<img src="https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/PCA/PCA-python/wrench.jpg" width="400" height="240">  
</p>
  
Principal components:
<p align="center">  
	<img src="https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/PCA/PCA-python/wrench_PC.jpg" width="460" height="300">  
</p>
  
Rotation:  
<p align="center">
	<img src="https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/PCA/PCA-python/rotated_wrench.jpg" width="460" height="300">  
</p>
  
# Execution
```shell
chmod +x wrench_axis_pca.py
./wrench_axis_pca.py
```