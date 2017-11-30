function [a]=testModels()
a = 1;
data=load("BBC_classification.mat");
trainData=data.TrainData;
trainClasses=data.TrainClasses;
GCC_Train(trainData, trainClasses, 3);