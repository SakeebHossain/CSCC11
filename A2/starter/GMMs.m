%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSC C11 - Assignment 2 - Gaussian Mixture Models clustering
%
% In this function, you will implement Gaussian Mixture Models.
%  the mixture models can be initialized randomly, or with the
%  given initial centers.
%  Covariance matrices are initialized to identity.
%
% function [centers,covariances,labels]=GMMs(data,cent_init,k)
%
% Inputs: data - an array of input data points size n x d, with n 
%                input points (one per row), each of length d.
%         k - number of clusters
%         cent_init - either an empty array '[]', or an array of
%                     size k x d, with k initial cluster centers
%
% Outputs: centers - Final cluster centersz
%          covariances - Covariance matrices for the GMM components,
%                        this will be an array of size
%                        d x d x k, with each 'layer' of size
%                        d x d corresponding to the covariance
%                        matrix of one of the Gaussians in the model.
%          mps - An array of size k x 1, with mixture proportions
%                giving the percent of data assigned to each
%                cluster. The sum of these has to be 1.
%          labels - An array of size n x 1, with labels indicating
%                   which cluster each input point belongs to.
%                   e.g. if data point i belongs to cluster j,
%                   then labels(i)=j
%
% Starter code: F. Estrada, Sep. 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


function [centers,covariances,mps,labels]=GMMs(data,cent_init,k)

% Initialize all the arrays we will need
centers=zeros(k,size(data,2));
labels=zeros(size(data,1),1);
old_labels = labels=zeros(size(data,1),1);
mps=ones(k,1)/k;
covariances=zeros([size(data,2) size(data,2) k]); % k identity matrices
for i=1:k
 covariances(:,:,i)=eye(size(data,2),size(data,2));
end;

N = size(data, 1);
D = size(data, 2);

if (isempty(cent_init))
  % Initial centers is an empty array, choose initial centers
  % randomly

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % TO DO: Complete this part so that your code chooses k initial
  %        centers randomly. This comes down to picking random
  %        entries in your data array.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Generate rand perm of no. from 1 to n, and select the first k.
  kRandomIndices = randperm(size(data,1)); 
  
  % Select the data points at the k random indices we generated.
  centers = data( kRandomIndices(1:k), : );
    
else
  if (size(cent_init,1)~=k | size(cent_init,2)~=size(data,2))
    fprintf(2,'Initial centers array has wrong dimensions.'\n');
    return;
  end;
  centers=cent_init;
end; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TO DO: Complete the function by implementing the E-M algorithm for
%  estimating the parameters of a Gaussian Mixture Model
% 
%        As a reminder, this is a loop that:
%          * Assigns data points to the cluster that gives it maximum 
%            likelihood
%          * Updates the cluster centers, covariances, and mixture 
%            proportions
%          * Update the labels array to contain the index of the
%        n    cluster center each point is assigned to
%        Loop ends when the labels do not change from one iteration
%         to the next. 
%
%  DO NOT compute ownership probabilities for data points using
%   a for loop over data points. Doing so will cause you to wait
%   forever for this thing to converge. Your TA certainly won't
%   wait that long.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 while 1 
   
   %%%%%%% Estimation step %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   % Calculate how much "responsibility" is assigned to each point by
   % each Gaussian
   
   m = [];
   
   for i=1:k
     exponent = (-1/2)*(data-centers(i,:))*inv(covariances(:,:,i))*(data-centers(i,:))'
     constant = mps(i)*1/sqrt(det(covariances(:,:,i))*(2*pi)^D)
     b = constant.*exp(exponent)
     m = [m ; b]
   end;
   
   m = m';
   
   m_row_sums = sum(m);
   expectation = m ./ m_row_sums;
   
   
   %%%%%%% Maximization step %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   % Recalculate mps
   mps = sum(m)/N;
   
   % Recalculate centers (means)
   for i=1:k
     scalars = m(:, i);
     centers(i, :) = sum((scalars .* data')') ./ sum(m);
   end;
   
   
   % Recalculate covariance
   for i=1:k
     scalars = m(:, i);
     dist_1 = data - centers(i); % has size N x D
     dist_2 = sum(m)(i) .* dist_1; % also N x D
     covariances(:,:,i) = dist_2' * dist_1; % has size D x D
   end;
   
   % Assign labels.
   
   old_labels = labels;
   
   for i=1:N
     [min idx] = min(m(i, :));
     labels(i) = idx; % should be a value between 1 and k. 
   end;
     
   if isequal(labels, old_labels)
     break
   end
 end


