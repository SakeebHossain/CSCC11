%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSC C11 - Assignment 3 - Naive Bayes classification
%
% This function classifies the input dataset using a trained NB
% classifier
%
% Inputs:
% 
% input_data       -  Input data set, one sample PER ROW
% NB_probs         -  A kxD array whose rows are the probabilities
%                     for input features being = 1 for each class
% NB_ais           -  A kx1 array with p(L=i)
% 
% Return values:
%
% labels           - Labels for input samples in [1,K]
%
% F.J.E. Nov, 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [labels]=NB_Classify(input_data, NB_probs, NB_ais)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLETE THIS TEXT BOX:
%
% 1) Student Name:		
% 2) Student Name:		
%
% 1) Student number:
% 2) Student number:
% 
% 1) UtorID
% 2) UtorID
% 
% We hereby certify that the work contained here is our own
%
% ____________________             _____________________
% (sign with your name)            (sign with your name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TO DO: Complete this function to perform NB classification
%
%        NOTE: You will be multiplying lots of tiny numbers. That
%              will quickly run you into trouble. You should do
%              everything in the log domain instead.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for each point, calculate the probability it is a member of each class.
% choose the one that is the highest!

probs = zeros(N, K);  % stores the probability that data point K belongs to class K

% iterate through each point and calculate its probability
for i=1:N
  data_point = input_data(i,:);  % will be computing the probability of this point for each cluster
  for j=1:K
    included_probs = data_point .* NB_prob(j, :);  % find the row in NB_prob; this tells us the probs each attribute belong the kth class
    prob = 1;
    for k=1:size(included_probs, 1)
      if data_point(k) != 0
        prob = prob * included_probs(k);
      end
    end
    probs(i,j) = prob * NB_ais(j);
  end 
end