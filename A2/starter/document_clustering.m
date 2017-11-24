%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CSC C11 - Assignment 2 - Document Clustering.
%
% This script is used to perform clustering on a dataset that
% contains word-frequency vectors for a couple thousand articles
% from the BBC: 
%
% http://mlg.ucd.ie/datasets/bbc.html
%
% You *do not need to* worry about the dataset. It is included
% with the starter in matlab format, so it will be imported
% here without you having to implement anything.
%
% Read this script carefully, You do *NOT* need to implement
% anything - this script calls your kmeans.m script, the one
% you implemented for RGB clustering. What you need to do for
% this part of the assignment is investigate how pre-processing
% of input data affects clustering results.
%
% Starter by: F. Estrada, Oct, 2017
%
% function [Centers,labels]=document_clustering(K, norm_flag, diffuse)
%
% Inputs: K - the number of clusters (5 for this case :) )
%         norm_flag - If 0, use the input word-frequency vectorsd
%                     as is. If 1, normalize word-frequency vectors
%                     so their total mass is 1 (effectively turning
%                     them into histograms)
%         diffuse - Number of random-walk diffusion to perform.
%                   0 - leave the vectors alone
%                   > 0 - Perform the specified number of random walk
%                         steps, implies norm_flag=1
%
% Outputs: Centers - word-frequency vectors corresponding to cluster
%                    centers.
%          Labels  - Vector containing the assignment of input data
%                    vectors to clusters. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Centers,labels]=document_clustering(K, norm_flag, diffuse)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the dataset from the BBC. This will load into memory
% the following:
%
% DocVectors - An array of size 2225 x 9635, which contains
%              word-frequency vectors for 2225 articles, over
%              a dictionary of 9635 words. Each row shows how
%              many times a given word appears in the article.
%
% terms - Cell array of size 1 x 9635 which contains the words
%         in the dictionary. That is, cell{i} contains the 
%         word corresponding to column i in the DocVectors
%         array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load BBCdata;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computing diffusion over so many document vectors is slow, so
% the code below checks whether this script has been called with
% the same value for the 'diffuse' parameter as the last call.
% If so, it loads cached document vectors already pre-processed
% during the previous call. Do not remove or change the code below.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=fopen('kmeans_cache.mat','r');
if (f>0)
 fclose(f);
 cache_exists=1;
 load kmeans_cache;
else
 cache_exists=0;
end;

if (cache_exists)
 if (flag1~=norm_flag|flag2~=diffuse) cache_exists=0; end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Either there is no cached data, or the script was called with
% different parameters - need to normalize and/or diffuse
% document vectors as per input parameters. Do not change the code
% below.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (~cache_exists)
 if (norm_flag==1|diffuse>0)
  % Pre-process document vectors to ensure they are unit mass (probability
  % distributions)
  for i=1:size(DocVectors,1)
   DocVectors(i,:)=DocVectors(i,:)/sum(DocVectors(i,:));
  end;
 end;

 if (diffuse>0)
  % Do a little bit of diffusion to obtain less-sparse vectors
  load WordTrans.mat;
  for i=1:size(DocVectors,1)
   for j=1:diffuse
    DocVectors(i,:)=(WordTrans*DocVectors(i,:)')';
   end;
  end; 
 end;

 flag1=norm_flag;
 flag2=diffuse;

save('-mat7-binary','kmeans_cache.mat','flag1','flag2','DocVectors');   % <---- Use this in Octave
% save('kmeans_cache.mat','flag1','flag2','DocVectors');		% <--- Use this in MATLAB
end;

% Call *your* kmeans clustering code to do the work!
[Centers,labels]=kmeans(DocVectors,[],K);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Take the cluster centers output by k-means and output the
% words that are frequently in those vectors, but not in the
% mean document vector (the mean of the cluster center vectors).
% This should display words that are distinctive of each cluster.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delete('centers*.txt');		% Delete results from previous runs

for i=1:K
 s=sprintf('centers_%d.txt',i);
 f=fopen(s,'w');
 v=Centers(i,:);
 v=v-mean(Centers);
 v=abs(v);
 v=v/sum(v);
 idx=find(v);
 v=round(v*500);
 for j=1:length(idx)
  for k=1:v(idx(j))
   fprintf(f,'%s',terms{idx(j)});
  end;
 end;
 fclose(f);
end;
