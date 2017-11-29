%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSC C11 - Assignment 3 - Naive Bayes classifier training
%
% This function computes the parameters of a Naive Bayes classifier 
% for the given training dataset
%
% Inputs:
% 
% training_data    -  The training data set, one sample PER ROW
% training_labels  -  Labels for the training dataset
% K                -  Number of classes
% 
% Return values:
%
% NB_probs         -  A kxD array whose rows are the probabilities
%                     for input features being = 1 for each class
% NB_ais           -  A kx1 array with p(L=i)
%
% F.J.E. Nov, 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [NB_probs, NB_ais]=NB_Train(training_data, training_labels, K)

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TO DO: Complete this function to estimate the parameters of the NB
%        classifier.
%
%        NOTE: For this classifier you will assume features are
%              binary - that is, a word is either present in the
%              document or it is not. The training dataset provided
%              is *not* binary, you have to binarize your training
%              data here.
%             
%              Second note: You should *not* allow any probabilities
%                to become zero, even if no document for a given
%                class contains a particular word, we should not 
%                assume this word is *never* found in documents
%                for the class. Therefore, once you have your
%                probability vectors for each class, replace 
%                any zeros with a tiny value such as 1e-9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate class priors by counting up how many times a specific
% label shows up divided by total no. of labelled data points.
% as a reminder, this is asking: what is the probability of being a banana?

N = size(training_data, 1)  % no. training_data points
D = size(training_data, 2)  % no. dimensions of in a data point

% identify unique members of training_labels. These are our labels.
labels = unique(training_data); 

% this vector will store no. instance of each label we see in training data.
label_counts = zeros(K,1);

  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate late evidence probabilities. Count up the number of times 
% an attribute shows up divided by total number of data points. This is 
% just asking, what is the liklihood of being sweet?


% m = kxd matrix counting how many times dth dim shows up for class k
m = zeros(K, D);

for i=1:N
  
  % grab the current data point and its label.
  label = training_label(i);
  data_point = training_data(i);
  
  % increase the count of occurance of that label.
  index_label = find(labels == label)
  label_counts(index_label) += 1
 
  % increase the count of occurance of each feature for that label.
  for index_dimension=1:D
    m[index_label][index_dimension] += 1
  end
  
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate conditional probabilities by couting up for each label/class,
% how many times an attribute shows up for a specific label divided by
% the total no. of occurances of that label. As a reminder, this is asking: 
%given you are a banana, what is the probabilty it is sweet? 

%%%%%%%% outputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NB_probs: this is essentially the conditional probabilities in a matrix form.
% let's break it down. It is a kxD matrix, where k represents a class/label and
% D represents an attribute/feature. so NB_probs[k][D] must contain a single
% number telling us the probability P(having feature D | being class k).
NB_probs = m ./ label_counts;

% NB_ais: kx1, tells us P(L=i)... that's what the description says. What
% this is essentially just the prior probabilities for each class.
NB_ais = label_counts ./ N; 