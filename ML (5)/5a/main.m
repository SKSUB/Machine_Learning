%% Subramani ML lab 5
clear
clc
close all
addpath('mnist')
addpath('Matlab code snippets-20210531')

% loading the dataset with two selexted digit
%[train_set1, train_labels1] = loadMNIST(0, 1); 
%[train_set1, train_labels1] = loadMNIST(0, 2); 
[train_set1, train_labels1] = loadMNIST(0, 5);

%[train_set2, train_labels2] = loadMNIST(0, 8); 
%[train_set2, train_labels2] = loadMNIST(0, 7);
[train_set2, train_labels2] = loadMNIST(0, 10);

% Splitting the dataset to classes
division = [1:150];

data_1 = [train_set1 train_labels1];
data_2 = [train_set2 train_labels2];
[n, ~] = size(data_1);
[m, ~] = size(data_2);
indices_1 = randperm(n);
indices_2 = randperm(m);
subset_data_1 = data_1(indices_1(division), :);
subset_data_2 = data_2(indices_2(division), :);

% Creating a training set and adapting it to new convention of the data
trainingSets = [subset_data_1(:, 1:end-1)', subset_data_2(:, 1:end-1)'];
trainingLabels = [subset_data_1(:, end)', subset_data_2(:, end)'];


% declaring nh
nh = 2; 

% training autoencodder function
myAutoencoder = trainAutoencoder(trainingSets,nh);
myEncodedData = encode(myAutoencoder,trainingSets);

% Plotting and saving funcions
f = figure('units','normalized','outerposition',[0 0 1 1], 'visible', 'off');

plotcl(myEncodedData', trainingLabels');

legend(['Class ', num2str(train_labels1(1))], ['Class ', num2str(train_labels2(1))]);
figName=sprintf('Results/Graphical_result_of_digit_one_%d_and_digit_two %d.jpg',train_labels1(1), train_labels2(1));
saveas(f, figName)