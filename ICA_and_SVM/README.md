# Problem description
Create a car recognition system using ICA and SVM to detect if a car is or is not present in an
image.
  
# Solution
  
The training part of the system consists of the following steps:  
1. In a training set, 500 car and non-car images are labeled as 1 or 0 respectively. The car images
include various types of cars and non car images usually represent some outdoor scenery.
2. An ICA algorithm is applied to learn the independent image basis and generate the training
ICA features.
3. Using the ICA features, SVM with quadratic kernel is trained for classification.  
  
ICA is performed using the fastica function in Matlab. This function outputs the estimated
separating matrix W and the corresponding mixing matrix A.  

[icasig, A, W] = fastica(X);  

For a given input data matrix Training Set (in our case the training images which are 500 x
4000 matrix, i.e. each row is an observation) unmixing can be done using:  

icasig = W*TrainingSet(TrainingSet is separated on independent ’sources’ icasig),  
  
and mixing can be done using: TrainingSet = A*icasig.  
  
A stores the independent components extracted from TrainingSet.  
icasig stores the sources or the projections of TrainingSet on the independent components or the projection of the input data
on the ICs.  
W separates the sources or independent components from the mixtures.  
  
icasig then is used to train SVM with quadratic kernel. Then a classification is made after the test data is projected in the same space as the training data.