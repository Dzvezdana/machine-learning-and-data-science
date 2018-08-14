clc; clear all; close all

%Set direction
myFolder = ’C:/Users/dd/images';
filePattern = fullfile (myFolder, ’ ∗.png’ );
pngFiles = dir(filePattern);

% New 3D matrix to store images
imageMatrix = cell(1, numel(pngFiles));

%Load the images
for k = 1: length(pngFiles)
	baseFileName = pngFiles(k).name;
	fullFileName = fullfile(myFolder, baseFileName);
	fprintf(1, ’Now reading %s \n’, fullFileName);
	imageArrayNew = imread(fullFileName);

	imageMatrix{k} = imageArrayNew;

	% Find and plot the average image
	avImg = zeros(112, 378);
	imageMatrix {k} = im2single(imageMatrix{k});
	avImg = avImg + (1/7)∗imageMatrix{k};
	figure(1) , imshow (avImg); title (’Average image’)
end

%Subtract the average image
for k = 1:7
	imageMatrix{k} = imageMatrix{k} − avImg;
end
%Calculate covariance matrix
A = zeros(378*112, 7);
for k = 1:7
	A(:, k) = imageMatrix{k}(:);
end

C = A’∗A;

%Calculate the eigenvector and the eigen values
[Veigvec , Deigval] = eig(C);

Vlarge = A∗Veigvec;

%Reshape
eigenimages = [];
for k = 1:7
	c = Vlarge(:, k);
	eigenimages{k} = reshape(c, 112, 378);
end

x = diag(Deigval);
%Sort
[xc , xci] = sort(x, ’descend’);
%Plot the eigen images
z = [eigenimages{xci(1)} eigenimages{xci(2)}; eigenimages{xci(3)} eigenimages {xci(4)}];
figure (5), imshow (z, ’Initial magnification’, ’fit’); title(’Eigen Images’)

%Compute and plot the variances
variances = sqrt(diag(x).∗diag(x));
figure;
bar(variances(1:30))
title(’Eigenvalues’ , ’FontSize’ , 15);
xlabel(’Order’ , ’FontSize’, 15); ylabel(’Eigenvalue’ , ’FontSize’, 15);
