%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSC C11 - Assignment 2 - Clustering in RGB
%
% You will use this script to implement colour image clustering using k-means
%  and GMMs. 
%
% You do *not need to* implement anything in this script. But you need to read
%  and understand what it's doing in order to implement your work.
%
% function [labels,clusters,bnd]=RGB_clustering(im,k,method);
%
% Inputs - im - a colour image
%          k - the number of clusters for k-means
%          method - 0 -> k-means, 1 -> GMMs
%
% Returns - 'labels' indicates the cluster assignments for pixels in the
%             input image
%           'clusters' is a colour image where pixels are coloured according
%                   to the colour of the cluster center they are assigned
%                   to.
%           'bnd' an image where boundaries between clusters are marked
%              showing the segmentation of the image according to kmeans
%
% Starter: F.J. Estrada, Sep. 2017
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [labels,clusters,bnd]=RGB_clustering(im,k,method);

if (method<0|method>1)
 fprintf(2,'Method not supported\n');
 labels=[];
 clusters=[];
 bnd=[];
 return;
end;

% Normalize image
im=double(im);
im=im-min(im(:));
im=im/max(im(:));
imS=size(im);
figure(1);clf;image(im);axis image;title('Input Image');

% Now, reshape the image into an array of (m * n, 3), where each row has
% the RGB values for one image pixel
im=reshape(im,[imS(1)*imS(2) 3]);

% Make empty arrays for cluster image and segmentation results
clusters=zeros(size(im));
bnd=zeros(size(im));

% Call the requested clustering method
if (method==0)
 [centers,labels]=kmeans(im,[],k);
else
 [centers,covariances,mps,labels]=GMMs(im,[],k);
end;

% Generate cluster and boundary images
for i=1:k
 clusters(find(labels==i),:)=repmat(centers(i,:),[length(find(labels==i)) 1]);
end;

clusters=reshape(clusters,[imS(1) imS(2) 3]);
dx=[-1 1];
bnd=conv2(sum(clusters,3),dx,'same')+conv2(sum(clusters,3),dx','same');
bnd(find(bnd~=0))=1.0;

labels=reshape(labels,[imS(1) imS(2)]);

figure(2);clf;imagesc(labels);axis image;colormap(jet);title('Labels');
figure(3);clf;image(clusters);axis image;title('Clusters');
figure(4);clf;imagesc(bnd);colormap(gray);axis image;title('Segmentation');
