K-means clustering is an unsupervised algorithm that works iteratively to assign each data point to one of K groups based on the features that are provided. Data points are clustered based on feature similarity (in this case Euclidean distance). The algorithm consists of two steps:  
	1. Each data point is assigned to its nearest centroid, based on the squared Euclidean distance.  
	2. Calculate the new means to be the centroids of the observations in the new clusters.  
  
The algorithm iterates between steps one and two until a stopping criteria is met (i.e., no data points change clusters, the sum of the distances is minimized, or some maximum number of iterations is reached).  
  
The results of the K-means clustering algorithm are:  
	1. The centroids of the K clusters, which can be used to label new data.
	2. Labels for the training data (each data point is assigned to a single cluster).
  
The following image shows how the centers change with each iteration:  
<p align="center">
	<img src="https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/k-means_clustering/cluster_update.jpg">  
</p>
  
Groups:  
<p align="center">
	<img src="https://raw.githubusercontent.com/Dzvezdana/machine-learning-and-data-science/master/k-means_clustering/clusters.jpg">  
</p>