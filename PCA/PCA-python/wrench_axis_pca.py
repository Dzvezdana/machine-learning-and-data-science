#!/usr/bin/env python

import numpy as np
import cv2
import matplotlib.pyplot as plt
import scipy.misc
import math

tool_img = cv2.imread('wrench.jpg',0) #Load the image, convert it to grayscale
ret, thresh = cv2.threshold(tool_img, 127, 255, cv2.THRESH_BINARY_INV) #Threshold it
img = cv2.Laplacian(thresh, cv2.CV_64F) #Find the edges using Laplacian

y , x = np.nonzero(img) #Get the white pixels indexes to find the major and minor axes

x = x - np.mean(x) #Compute and subtract the mean
y = y - np.mean(y)
coords = np.vstack([x, y])

cov = np.cov(coords) #Compute the covariance matrix
evals, evecs = np.linalg.eig(cov) #Find the eigendecomposition of the covariance matix

sort_indices = np.argsort(evals)[:: -1] #Sort the eigenvalues in decreasing order
x_v1, y_v1 = evecs[:, sort_indices[0]] #Eigenvector corresponding to the largest eigenvalue
x_v2, y_v2 = evecs[:, sort_indices[1]]

#Plot the eigenvectors(the largest eigenvector is red)
scale = 300
plt.plot([x_v1*-scale*2, x_v1*scale*2],
		 [y_v1*-scale*2, y_v1*scale*2], color = 'red')
plt.plot([x_v2*-scale, x_v2*scale],
		 [y_v2*-scale, y_v2*scale], color = 'blue')
plt.plot(x, y, 'k.')
plt.axis('equal')
plt.gca().invert_yaxis()

plt.show()

#Find the angle from the first PC to the horizontal axis
theta = np.arctan((y_v1)/(x_v1))
theta_deg = math.degrees(theta) #Convert to degrees
print("Radians: " + repr(theta) + " Degrees: " + repr(theta_deg))
#We can realign the wrench using the rotation matrix
rotation_mat = np.matrix([[np.cos(theta), -np.sin(theta)], [np.sin(theta), np.cos(theta)]])
transformed_mat = rotation_mat * coords
x_tr, y_tr = transformed_mat.A #Plot the realigned wrench
plt.plot(x_tr, y_tr, 'b.')
plt.show()
