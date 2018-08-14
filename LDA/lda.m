clc; close all; clear all;
X1 = [2,3; 3,6; 4,4; 4,2; 2,4];
X2 = [6,8 ; 9,5 ; 9,10; 8,7 ; 10,8];
X3 = [23,14; 15,8 ; 17,12; 19,10; 22,9];

Mu1 = mean(X1)’;
Mu2 = mean(X2)’;
Mu3 = mean(X3)’;

%Overall mean
Mu = (Mu1+Mu2+Mu3)./3;

S1 = cov(X1);
S2 = cov(X2);
S3 = cov(X3);

%within class scatter matrix
Sw = S1 + S2 + S3;

%number of samples of each class
N1 = size(X1, 2);
N2 = size(X2, 2);
N3 = size(X3, 2);

%between−class scatter matrix
Sb1 = N1.∗(Mu1−Mu)∗(Mu1−Mu)’;
Sb2 = N2.∗(Mu2−Mu)∗(Mu2−Mu)’;
Sb3 = N3.∗(Mu3−Mu)∗(Mu3−Mu)’;

Sb = Sb1 + Sb2 + Sb3;

%LDA projection
SwSb = inv(Sw)∗Sb;

%projection vector
% D diagonal matrix contins eigen values, V’s columns are eigen vectors
[V,D]= eig(SwSb);

%sort according to eigen values
eigen_val = diag(D);
[eigen_val_sorted, index] = sort(eigen_val, ’descend’);

W1 = V(: , index);

%project data samples along the projection axes
new_X1 = X1∗W1;
new_X2 = X2∗W1;
new_X3 = X3∗W1;
%get back the original data
old_X1 = new_X1∗W1’;
old_X2 = new_X2∗W1’;
old_X3 = new_X3∗W1’;

figure
plot(X1(:,1), X1(:, 2), ’r∗’)
hold on
plot(Mu1(1) ,Mu1(2), ’co’, ’MarkerSize’ ,8 , ’MarkerEdgeColor’, ’c’, ’Color’, ’c’, ’LineWidth’, 2, ’MarkerFaceColor’, ’c’);
hold on
plot(X2 (:, 1), X2(:, 2), ’b∗’)
hold on
plot(Mu2(1) ,Mu2(2), ’mo’, ’MarkerSize’ ,8 , ’MarkerEdgeColor’ , ’m’ , ’Color’ , ’m’ , ’LineWidth’, 2 , ’MarkerFaceColor’, ’m’);
hold on
plot(X3 (:,1), X3 (:,2), ’g∗’)
hold on
plot(Mu3(1), Mu3(2), ’yo’ , ’MarkerSize’,8 ,  MarkerEdgeColor’, ’y’,’Color’, ’y’ ,’LineWidth’ ,2 , ’MarkerFaceColor’, ’y’);

figure
plot(new_X1 (:, 1), new_X1(:, 2), ’r∗’)
hold on
plot(new_X2(:, 1), new_X2(:, 2), ’b∗’)
hold on
plot(new_X3(:, 1), new_X3(:, 2), ’g∗’)

%reduce dimension
figure
plot(new_X1(:, 1), 0 , ’r∗’)
hold on
plot(new_X2(:, 1), 0 , ’b∗’)
hold on
plot(new_X3(:, 1), 0 , ’g∗’)
figure

plot(old_X1(:, 1), old_X1(:, 2), ’r∗’)
hold on
plot(old_X2(:, 1), old_X2(:, 2), ’b∗’)
hold on
plot(old_X3(:, 1), old_X3(:, 2), ’g∗’)

W11 = V(:, 1);
t = −10:25; Line_x1 = t .∗ W11(1); Line_y1 = t .∗ W11(1);
plot(Line_x1, Line_y1, ’k− ’, ’LineWidth’, 3); hold on; grid on