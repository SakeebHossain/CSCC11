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

