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

% clean data?? (zero mean, feature selection...)

% sum up all data vectors. This is our average (needed for creation
% of covariance matrix.
N=size(data,1);
D=size(data,2);
b=sum(data)./N;

% create covariance matrix
cov = zeros([D D N]);
for i=1:N
    cov = cov + (data(i,:) - b)*(data(i,:) - b)';
end

cov = cov ./N;


% compute eigenvectors and eigenvalues
[V D] = eig(cov);  % V is eigenvectors, D is eigenvalues


% map eigenvalues to eigenvalues; see Rody -> https://stackoverflow.com/questions/13704384/does-matlab-eig-always-returns-sorted-values
[D,I] = sort(diag(D));
V = V(:, I);

% sort eigenvalues (done above) and select first k of them (do we take rows
% or columns??)


% use selected k eigenvalues to get corresponding eigenvectors


% create matrix using above eigenvectors. This is eigenvector transform matrix. 
W = V(:, 1:k);

% transform all data points using eigenvecotr transformation matrix.
for i=1:N
    current_y = y(i, :);
    new_y = W' * (current_y - b);
    LowDim_data = [LowDim_data, new_y]; 
end



