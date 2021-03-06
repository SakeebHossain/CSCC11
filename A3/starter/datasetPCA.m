%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSC C11 - Assignment 3 - Dimensionality reduction by PCA
%
% In this function you will apply PCA to an input dataset to
% return a low-dimensional representation for the input data.
%
% Inputs:
% 
% input_data    -   Input dataset, one sample PER ROW
% k             -   Number of dimensions for the low-dimensional data
%
% Return values:
%
% LodWim_data   -   The low-dimensional representation of the dataset
%                   one sample per row
% V             -   The matrix with the PCA directions (one per column)
% mu            -   The mean of the input data (needed for reconstruction)
% 
% F.J.E. Nov, 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [LowDim_data,V,mu]=datasetPCA(input_data, k);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLETE THIS TEXT BOX:
%
% 1) Student Name: Ahnaf Sakeeb Hossain
% 2) Student Name:		
%
% 1) Student number: 1001537483
% 2) Student number:
% 
% 1) UtorID hossa171
% 2) UtorID
% 
% We hereby certify that the work contained here is our own
% Ahnaf Sakeeb Hossain
% ____________________             _____________________
% (sign with your name)            (sign with your name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TO DO: Complete the code below to find the PCA directions.
%        
%        Note: Use the eigs() function for computing the 
%              eigenvalues and eigenvectors.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sum up all data vectors. This is our average (needed for creation
% of covariance matrix.
N=size(input_data,1);
D=size(input_data,2);
mu=sum(input_data)/N;

% create covariance matrix
K = cov(input_data - mu);

% compute eigenvectors and eigenvalues
[V,~] = eigs(K, k);  % V is eigenvectors, 
LowDim_data = (V'*(input_data-mu)')';

%-------------------------------

% % PCA step 1 - compute the mean of the data, and subtract
% % the mean from all input vectors
% im3=input_data;
% mu=mean(im3);
% im3=im3-repmat(mu,[size(im3,1) 1]);
% 
% % PCA step 2 - Compute the covariance matrix - have a look 
% % at it! the off-diagonal entries are fairly large, indicating
% % a significant correlation between R, G, and B
% cv=cov(im3);
% 
% % PCA step 3 - Compute the eigenvectors and eigenvalues of 
% % the covariance matrix. Sort them by decreasing magnitude of
% % the eigenvalue. Take a look at the eigenvectors and think
% % about what they tell you in terms of what directions 
% % contain the most information in the image.
% [v,e]=eig(cv);
% e=diag(e);
% [~,ii]=sort(-e);
% v=v(:,ii);
% e=e(ii);
% 
% % PCA step 4 - Obtain PCA coefficients for each pixel by 
% % projecting onto the matrix whose columns are the sorted
% % eigenvectors of the covariance matrix.
% imPCa=(v'*im3')';
% 
% LowDim_data=imPCa;
% V=v;
% 

