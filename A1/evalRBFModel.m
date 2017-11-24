% CSC C11 - Machine Learning, Fall 2017, Assignment 1, 
% F. Estrada, festrada@utsc.utoronto.ca
%
% A 2D - Radial Basis Function
% 
% [z]=evalRBFModel(w,P,C,sigma)
%
% Evaluates the trained RBF model with weights w at
% the specified points.
%
% w - weights for the RBFs in the model as estimated by
%     TrainRBFRegression.m
%
% P - a 2-row array containing the coordinates of the points
%     where we want the model to be evaluated, i.e.
%
%     P=[x_1   x_2    ....    x_n
%        y_1   y_2    ....    y_n]
%
% C - RBF center locations, i.e.
%
%     C=[cx_1  cx_2   ....    cx_n
%        cy_1  cy_2   ....    cy_n]
%
% sigma - width of the RBFs
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TO DO: Complete this function so that it evaluates the trained
%        RBF model on the given input points
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLETE THIS TEXT BOX:
%
% 1) Student Name: Ahnaf Sakeeb Hossain
% 2) Student Name:		
%
% 1) Student number: 1001537483
% 2) Student number:
% 
% 1) UtorID: hossa171
% 2) UtorID
% 
% We hereby certify that the work contained here is our own
% Ahnaf Sakeeb Hossain
% ____________________             _____________________
% (sign with your name)            (sign with your name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% COMPLETE THIS TEXT BOX:
%
% Code written by:
%
% 1) Student Name: Anhaf Sakeeb Hossain		Student number: 1001537483			UtorID: hossa171
% 2) Student Name:		Student number:			UtorID:
%
% We hereby certify that the work contained here is our own
%
% Ahnaf Sakeeb Hossain
% ____________________             _____________________
% (sign with your name)            (sign with your name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [z]=evalRBFModel(w,P,C,sigma)

  X = []  % initialize empty matrix for input
  
  % iterate through each centre and retrieve the RBF point
  for centre = C,
     [y] = rbf2d(P, centre, sigma);
     X = [X y];
  end
  
  % Add column of ones for bias term
  X = [X ones(size(X,1),1)]
  
  % retrieve the weights
  z = w'*X'
  
  