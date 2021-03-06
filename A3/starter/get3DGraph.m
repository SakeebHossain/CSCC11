function [LowDim_data,V,mu,c]=get3DGraph()

data=load("BBC_classification.mat");
trainData=data.TrainData;
trainClasses=data.TrainClasses;
[LowDim_data,V,mu]=datasetPCA(data.TrainData,3);
x = LowDim_data(:,1);
y = LowDim_data(:,2);
z = LowDim_data(:,3);
% c= repmat(1, size(trainClasses, 1), 3) ./ (trainClasses + 1);
% scatter3(x,y,z,10,c);
% legend('1','2','3','4','5');

%        TrainData: [1113×9635 double]
%     TrainClasses: [1113×1 double]
%         TestData: [1112×9635 double]
%      TestClasses: [1112×1 double]

c0 = LowDim_data(trainClasses == 0, :);
c1 = LowDim_data(trainClasses == 1, :);
c2 = LowDim_data(trainClasses == 2, :);
c3 = LowDim_data(trainClasses == 3, :);
c4 = LowDim_data(trainClasses == 4, :);

hold on;
grid on;

scatter3(c0(:,1), c0(:,2), c0(:,3), 5, 'r');
scatter3(c1(:,1), c1(:,2), c1(:,3), 5, 'g');
scatter3(c2(:,1), c2(:,2), c2(:,3), 5, 'b');
scatter3(c3(:,1), c3(:,2), c3(:,3), 5, 'y');
scatter3(c4(:,1), c4(:,2), c4(:,3), 5, 'k');
legend('1','2','3','4','5');