clc;clear all;close all

myFolder = 'C:\Users\dd\CarData\Train';
filePattern = fullfile(myFolder, '*.pgm');
jpegFiles = dir(filePattern);

%// New - 3D matrix to store images
imageMatrix = cell(1,numel(jpegFiles));

for k = 1:length(jpegFiles)
    baseFileName = jpegFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    imageArray50x50 = imread(fullFileName);

    imageMatrix{k} = double(imageArray50x50);

end

myFolder1 = 'C:\Users\dd\CarData\Test';
filePattern1 = fullfile(myFolder1, '*.pgm');
jpegFiles1 = dir(filePattern1);

%// New - 3D matrix to store images
imageMatrix1 = cell(1,numel(jpegFiles1));

for j = 1:length(jpegFiles1)
    baseFileName1 = jpegFiles1(j).name;
    fullFileName1 = fullfile(myFolder1, baseFileName1);
    fprintf(1, 'Now reading %s\n', fullFileName1);
    imageArray50x501 = imread(fullFileName1);
    imageArray50x50New1 = imresize(imageArray50x501, [100 40]);

    imageMatrix1{j} = double(imageArray50x50New1);
    
end

train_label= zeros(size(500,1),1);
train_label(1:250,1)   = 0;         % % 0 = Not a car
train_label(251:500,1)  = 1;         % 1 = Car


% Prepare numeric matrix for svmtrain
Training_Set=[];
for m=1:length(imageMatrix)
    Training_Set_tmp   = reshape(imageMatrix{m}, 1, 100*40);
    Training_Set=[Training_Set;Training_Set_tmp];
end

Test_Set=[];
for n=1:length(imageMatrix1)
    Test_set_tmp   = reshape(imageMatrix1{n}, 1, 100*40);
    Test_Set=[Test_Set;Test_set_tmp];
end

[icasig,A,W] = fastica(Training_Set, 'lastEig', 500, 'numOfIC', 100);            
%Reduce dimension to 10, and estimate only 3 independent components.

for n=250:500
icasig(n,:) = 0;
end

[icasig, A, W] = fastica(Training_Set);

for iter=1:10,
 C{iter}=reshape(icasig(iter,:),[100 40]);
end;
figure(3);
set(gcf,'Name','ICA results');
subplot(2,3,1); imagesc(C{1});
subplot(2,3,2); imagesc(C{2});
subplot(2,3,3); imagesc(C{3});
subplot(2,3,4); plot(squeeze(W(1,:)));
subplot(2,3,5); plot(squeeze(W(2,:)));
subplot(2,3,6); plot(squeeze(W(3,:)));  

A_test = icasig' \ Test_Set';
A_Test = A_test' * icasig;

% Perform first run of svm
SVMStruct = svmtrain(A' , train_label, 'kernel_function', 'quadratic') %'BoxConstraint',Inf

Group = svmclassify(SVMStruct,A_Test)
acc = sum(train_label == Group) / numel(train_label)
