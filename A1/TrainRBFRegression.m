% CSC C11 - Machine Learning, Fall 2017, Assignment 1
% F. Estrada, festrada@utsc.utoronto.ca
%
% [w]=TrainRBFRegression(z,P,C,sig)
%
% This function computes the weights for RBF
%  regression on a set of pixel values from an image
%  patch. The goal is to fit a model to the pattern
%  of image brightness in the patch so we can use it
%  for inpainting and denoising
%
%  The RBF model is
%
%  z_i = sum_k  w_k * RBF_k(p_i)
%
%  Where z_i is an observed pixel value at location p_i=[x_i 
%                                                        y_i]
%
%  Each RBF has a center c_k=[x_k  and width 'sig'
%                             y_k]
%
% z - One-column vector with pixel values at each of the
%     sampled points in P
%
% P - 2-row array in which each column gives the coordinates
%     of a pixel in the patch, i.e.
%
%     P=[x_1   x_2  ....    x_n
%        y_1   y_2  ....    y_n]
%
% C - 2-row array in which each column gives the center for
%     one of the RBFs, i.e.
%
%     C=[cx_1  cx_2 ....   cx_k
%        cy_1  cy_2 ....   cy_k]
%
% sig - width of the RBFs (all have the same width)
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TO DO: Complete this function to set up the regression
%        problem and solve for the weights w that correspond
%        to the least-squares estimate that fits the observed
%        data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

function [w]=TrainRBFRegression(z,P,C,sig)
  
  X = []  % initialize empty matrix for input
  
  % iterate through each centre and retrieve the RBF point
  for centre = C,
     [y] = rbf2d(P, centre, sig);
     X = [X y];
  end
  
  % Add column of ones for bias term
  X = [X ones(size(X,1),1)]
  
  % retrieve the weights
  w = X\z
  
  

return
