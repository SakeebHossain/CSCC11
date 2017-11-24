% CSC C11 - Machine Learning, Fall 2017, Assignment 1, 
% F. Estrada, festrada@utsc.utoronto.ca
%
% Third test driver for RBF regression assignment.
%
% [im, im_rec]=RBF_image_denoising(image_name,spacing,sigma,lambda)
% 
% This script loads an image that is corrupted by Gaussian noise.
%  It will use your RBF regression code to generate a reduced-noise
%  reconstruction of the original. It uses *regularized* RBF 
%  models to estimate the reduced-noise pixel values.
%
% spacing - Spacing between RBF centers along X and Y (in [1, 9])
% sigma   - Width of the RBFs in [.5, 2*spacing]
% lambda  - Regularization parameter in [0 5.0]
%
% The script returns the original image and its reduced-noise version
%
% You DO NOT need to modify this script. Use it to run the
%  tests described in the A1 handout once you have 
%  completed your regression code.
%

function [im, im_rec]=RBF_image_denoising(image_name,spacing,sigma,lambda)

im=[];
im_rec=[];

if (spacing<1 | spacing>9)
 fprintf(2,'Spacing must be in [1 9]\n');
 return;
end;
if (sigma<.5 | sigma>(2*spacing))
 fprintf(2,'sigma must be in [.5  2*spacing]\n');
 return;
end;
if (lambda<0 | lambda>5)
 fprintf(2,'lambda must be in [0  5]\n');
 return;
end;

% Close all previous figures.
close all;

CENTER_SPACING=spacing;
PATCH_SIZE=25;
SIGMA=sigma;

% Load image and convert to floating point
im=double(imread(image_name))/255;
im_rec=im;
figure(1);clf;image(im);axis image

for i=CENTER_SPACING+1:PATCH_SIZE:size(im,2)-(PATCH_SIZE+CENTER_SPACING)
 for j=CENTER_SPACING+1:PATCH_SIZE:size(im,1)-(PATCH_SIZE+CENTER_SPACING)

   % Splat RBFs over this image patch
  [XX,YY]=meshgrid([i-CENTER_SPACING:CENTER_SPACING:i+PATCH_SIZE+CENTER_SPACING],[j-CENTER_SPACING:CENTER_SPACING:j+PATCH_SIZE+CENTER_SPACING]);
  C=[XX(:) YY(:)]';

  % Grid of pixel coordinates for fill-in pixels and corresponding patch with fill-in indices
  [XX YY]=meshgrid([i:i+PATCH_SIZE-1],[j:j+PATCH_SIZE-1]);
  Pfill=[XX(:) YY(:)]';
  patch_fill=im(j:j+PATCH_SIZE-1,i:i+PATCH_SIZE-1,:);
    
  % Grid of pixel coordinates for fitting data and corresponding image patch with valid data indices
  [XX YY]=meshgrid([i-CENTER_SPACING:i+PATCH_SIZE+CENTER_SPACING],[j-CENTER_SPACING:j+PATCH_SIZE+CENTER_SPACING]);
  P=[XX(:) YY(:)]';
  patch=im(j-CENTER_SPACING:j+PATCH_SIZE+CENTER_SPACING,i-CENTER_SPACING:i+PATCH_SIZE+CENTER_SPACING,:);
   
  % Patch contains the reference fill-in colour, use RBFs to fill-in
  fprintf(2,'Denoising patch at %d,%d\n',i,j);
        
  % Reconstruct each colour layer using a separate RBF model
  % Red channel
  patch_R=patch(:,:,1);
  z_R=patch_R(:);
  % Solve for the weights of the RBF model
  [w_R]=TrainRBFRegression_regularized(z_R,P,C,SIGMA,lambda);
    
  % Green channel
  patch_G=patch(:,:,2);
  z_G=patch_G(:);
  % Solve for the weights of the RBF model
  [w_G]=TrainRBFRegression_regularized(z_G,P,C,SIGMA,lambda);

  % Blue channel
  patch_B=patch(:,:,3);
  z_B=patch_B(:);
  % Solve for the weights of the RBF model
  [w_B]=TrainRBFRegression_regularized(z_B,P,C,SIGMA,lambda);
        
  % Reconstruct pixel values using RBF model
  [est_R]=evalRBFModel(w_R,Pfill,C,SIGMA);
  [est_G]=evalRBFModel(w_G,Pfill,C,SIGMA);
  [est_B]=evalRBFModel(w_B,Pfill,C,SIGMA);
    
  % Assemble reconstructed patch
  patch_rec=patch_fill;
  patch_rec(:,:,1)=reshape(est_R,[PATCH_SIZE PATCH_SIZE]);
  patch_rec(:,:,2)=reshape(est_G,[PATCH_SIZE PATCH_SIZE]);
  patch_rec(:,:,3)=reshape(est_B,[PATCH_SIZE PATCH_SIZE]);

  im_rec(j:j+PATCH_SIZE-1,i:i+PATCH_SIZE-1,:)=patch_rec;

  figure(1);clf;subplot(1,2,1);image(patch_fill);axis image;
  subplot(1,2,2);image(patch_rec);axis image;
  
 end;
end;

figure(2);clf;subplot(1,2,1);image(im);axis image;title('Input image');
subplot(1,2,2);image(im_rec);axis image;title('Denoised with RBF');

return;

