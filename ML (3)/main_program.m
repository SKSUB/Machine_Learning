%% Subramani ML lab 3
clear
clc
close all
addpath('mnist')


% Task 1: loading the dataset
%declaring training set and test set and their labels 
[Training_set, Training_label] = loadMNIST(0);
[Test_set, Test_label] = loadMNIST(1);
[Train_row,Train_col]=size(Training_set);
[Test_row,Test_col]=size(Test_set);

%Reducing the dataset because it ran for a long time
factor = 1/50;
small_Train_row = Train_row*factor;
small_Test_row = Test_row*factor;


% Task 2: Build a kNN classifier
%Random data processing 
idx = randperm(size(Training_set,1));
Training_set = Training_set(idx(1:small_Train_row),:);
Training_label = Training_label(idx(1:small_Train_row),:);
idx = randperm(size(Test_set,1));
Test_set = Test_set(idx(1:small_Test_row),:);
Test_label = Test_label(idx(1:small_Test_row),:);

k=[1,2,3,4,5,10,15,20,30,40,50];
accuracy=ones(size(k,2),Test_row);

figure;
for i=1:size(k,2)
    subplot(6,2,i)
    [classification, error]=knn([Training_set Training_label], Test_set, k(i), Test_label);
    plotting_func(Test_set(1,:),classification(1),k(i),0);
    accuracy(i,:)=accuracy(i,:)-error; 
end

figure;
accuracy_1=ones(1,size(k,2));
for j=1:size(k,2)
    accuracy_1(j)=mean(accuracy(j,:))*100;
end
plot(k,accuracy_1,'*')
title('Accuracy')
xlabel('k')
ylabel('Accuracy Percentage')

% Task 3: Test the kNN classifier
task=10;
k2=[1,2,3,4,5,10,15,20,30,40,50];


errors=zeros(task,size(k2,2),small_Test_row);
accuracy_1=ones(task,size(k2,2),small_Test_row);
for l=1:task % For each digit
    for m=1:size(k2,2) % For each value of k2
        [classification_1, error_1]=knn([Training_set Training_label == l], Test_set,  k2(m), Test_label == l);
        errors(l,m,:)=error_1;
        accuracy_1(l,m,:)=accuracy_1(l,m,:)-errors(l,m,:);
    end
end

figure;
accuracy_2=ones(task,size(k,2));
xlabel('k')
ylabel('Accuracy Percentage')
for n=1:task 
    for o=1:size(k2,2) 
        accuracy_2(n,o)=mean(accuracy_1(n,o,:))*100;
    end
    subplot(6,2,n)
    plot(k2,accuracy_2(n,:),'*')
    title(['Digits ', num2str(n)], 'Accuracy')
end





