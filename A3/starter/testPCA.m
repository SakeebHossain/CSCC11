function [imPCa,v,mu]=testPCA(image_name);

% % clean data?? (zero mean, feature selection...)
% % Normalize image
% im=input_data; %%%%%%%%%%%%%%
% 
% im=double(im);
% im=im-min(im(:));
% im=im/max(im(:));
% imS=size(im);
% figure(1);clf;image(im);axis image;title('Input Image');
% 
% % Now, reshape the image into an array of (m * n, 3), where each row has
% % the RGB values for one image pixel
% im=reshape(im,[imS(1)*imS(2) 3]);
% 

% input_data = im; %%%%%%%%%%%%%%%
im=double(imread(image_name));   % Choose your test image here

% Normalize image range
im=im-min(im(:));
im=im/max(im(:));

% Reshape the image so we can treat it as a collection of
% 3-element vectors
im3=reshape(im,[size(im,1)*size(im,2) 3]);

[imPCa,v,mu]=datasetPCA(im3, 2);


% Now let's try to reconstruct an image using only the
% first 2 eigenvectors!
imR=zeros(size(im3));
for i=1:size(imR,1)
 imR(i,:)=((imPCa(i,1)*v(:,1))+(imPCa(i,2)*v(:,2)))';
end

% Don't forget to add back the mean!
imR=imR+repmat(mu,[size(imR,1) 1]);

% And normalize to make sure we don't get values out
% of range because of the fact we're tossing away one
% eigenvector's contribution
imR=imR-min(imR(:));
imR=imR/max(imR(:));
imR=reshape(imR,[size(im,1) size(im,2) 3]);

% Let's see what the reconstructed image looks like,
% and compare it with the original.
figure(3);clf;
subplot(1,2,1)
image(imR);axis image;axis off;
title('Reconstruction from first 2 PCA components');

subplot(1,2,2)
imagesc(im);axis image;axis off;

plo

