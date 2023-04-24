%% Subramani ML lab 4
clear
clc
close all
addpath('mnist')

% Loading the datasets from task 2
%iris
iris_dataset=load("iris-2class.txt");

%MNIST
[Training_set, Training_label]=loadMNIST(0); 
[Train_row,Train_col]=size(Training_set);
%let '1' be easy and '2' be hard digit to recognize
digit_1=1;
digit_2=2;
%The dataset to have only 2 digits
idx1=find(Training_label==digit_1);
idx2=find(Training_label==digit_2);
Training_set1=Training_set(idx1,:);
Training_set2=Training_set(idx2,:);
Training_set=[Training_set1;Training_set2];
Training_label1=Training_label(idx1,:);
Training_label2=Training_label(idx2,:);
Training_label=[Training_label1;Training_label2];
% Reducing the dataset to make it run
factor=1/10;
small_Trian_rows=size(Training_set,1)*factor;
idx = randperm(size(Training_set,1));
Training_set = Training_set(idx(1:small_Trian_rows),:);
Training_label=Training_label(idx(1:small_Trian_rows),:);
% Set labels to -1 or +1
for i=1:length(Training_label)
    if Training_label(i)==digit_1 
        Training_label(i)=-1;
    elseif Training_label(i)==digit_2
        Training_label(i)=1;
    end
end

%XOR
XOR_dataSet=load('XOR.txt');
% modifying the XOR dataset to make it executable
for i=1:size(XOR_dataSet,1)
    if XOR_dataSet(i,3)==0
        XOR_dataSet(i,3)=-1;
    end
end

% Declaring the scalar eta
eta=0.1;

%computing
% IRIS
k=[2,10,size(iris_dataset,1)];
% splitting the data, applying algortihms and saving the reult
for i=1:3
    [x,num_sets]=split(iris_dataset,k(i));
    [confu_iris_per,~]=perceptron(x,eta,num_sets);
    [confu_iris_ada,~]=adaline(x,eta,num_sets);
    images('Perceptron','iris',confu_iris_per,k(i))
    images('Adaline','iris',confu_iris_ada,k(i))
end

% MNIST
k2=[2,10,size(Training_set,1)];
% splitting the data, applying algortihms and saving the reult
for i=1:3
    
    [x,num_sets]=split([Training_set Training_label],k2(i));
    [confu_MNIST_per,~]=perceptron(x,eta,num_sets);
    [confu_MNIST_ada,~]=adaline(x,eta,num_sets);
    images('Perceptron','MNIST',confu_MNIST_per,k(i))
    images('Adaline','MNIST',confu_MNIST_ada,k(i))
end

% XOR
k=2;
% splitting the data, applying algortihms and saving the reult
[x,num_sets]=split(XOR_dataSet,k);
[confu_XOR_per,~]=perceptron(x,eta,num_sets);
[confu_XOR_ada,~]=adaline(x,eta,num_sets);
images('Perceptron','XOR',confu_XOR_per,k)
images('Adaline','XOR',confu_XOR_ada,k)



