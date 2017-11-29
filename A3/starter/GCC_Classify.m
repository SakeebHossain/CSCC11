%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSC C11 - Assignment 3 - Classification by Gaussian Class Conditionals
%
% This function uses a trained GCC model to classify an input dataset
%
% Inputs:
%
% input_data   -  The training data set  (one input sample per row)
% centers      -  Centers of the Gaussians in the GCC model
% covs         -  Covariances for the Gaussians in the GCC model
% ais          -  Mixture proportions
%
% Returns:
%
% labels       - Output labels for input data samples. Each entry is a
%                value in [1,K] for a GCC model with K components.
%
% F.J.E. Nov, 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [labels]=GCC_Classify(input_data,centers,covs,ais);

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TO DO: Complete the function to classify the input dataset using
%        the model provided. The classification rule should be
%        familiar to you from your GMMs
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% go through each point and compute the probability with each gaussian.
% choose the one that gives the highest probability.

N=size(input_data, 1);  % number of data points
D=size(input_data, 2);  % number of dimensions in data
K=size(centers, 1);  % number of labels

% a matrix that tells us how much the Nth data point is represented by the Kth matrix
probs = zeros(N, K);  

for i=1:N
  for j=1:K
    constant = ais(j)*1/sqrt(det(covariances(:,:,j))*(2*pi)^D); 
    exponent = (-1/2)*(data(i,:)-centers(j,:))*inv(covariances(:,:,i))*(data(i,:)-centers(j,:))';
    prob(i,j) = constant^exponent; 
end



% for each row in probs, select the row with the highest probability.
labels = zeros(N,1);

for i=1:N
  row = probs(i,:);
  [~, idx] = max(row);  % choose the gaussian which i contributes to the most
  labels(i) = idx;
end