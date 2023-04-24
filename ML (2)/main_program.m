%% Subramani ML lab 2
clear
clc
close all

% Loading the two data
stock_data=importdata('turkish-se-SP500vsMSCI.csv');
car_data=readtable('mtcarsdata-4features.csv');

% One-dimensional problem without intercept on the Turkish stock exchange data
stock_var=stock_data(:,1);
stock_target=stock_data(:,2);
% One dimensional linear regression function without intercept
w1=lin_reg_1D(stock_var,stock_target);
y1=stock_var*w1;
% Plotting the function
figure; 
plot(stock_var,stock_target,'*')
hold on;
plot(stock_var,y1,'r')
title('One-dimensional problem without intercept on the Turkish stock exchange data')
xlabel('x (input or data)'); 
ylabel('t (target)'); 
legend('Data','Model of dataset');

% Compare graphically the solution obtained on different random subsets (10%) of the whole data set
figure; 
plot(stock_var,stock_target,'*')
hold on;
plot(stock_var,y1,'r')
title('One-dimensional problem without intercept on the Turkish stock exchange data and comparing it with 10% of the random subset')
xlabel('x (input or date)'); 
ylabel('t (target)');
for i=1:10
idx = randperm(length(stock_var));
subSet = stock_data(idx(1:round(length(stock_var)/10)),:);
x2=subSet(:,1);
t2=subSet(:,2);
w2=lin_reg_1D(x2,t2);
y2=w2*x2;
hold on;
plot(x2,y2,'b')
legend('Data','Model of dataset', 'Model of subsets');
end

% One-dimensional problem with intercept on the Motor Trends car data, using columns mpg and weight
car_mpg = car_data{:,2};
car_weight = car_data{:,5};
% One dimensional linear regression function with intercept
[w3,w4] = lin_reg_1D_intercept(car_mpg,car_weight);
y3 = w3*car_mpg+w4;
% Plotting the function
figure; 
plot(car_mpg,car_weight,'*')
hold on;
plot(car_mpg,y3,'r')
title('One-dimensional problem with intercept on the Motor Trends car data, using columns mpg and weight')
xlabel('car mpg'); 
ylabel('car weight'); 

% Multi-dimensional problem on the complete MTcars data, using all four columns (predict mpg with the other three columns)
car_all=car_data{:,3:5};
car_mpg = car_data{:,2};
car_all_norm=zeros(size(car_all));
%Normalizing
for i=1:size(car_all,2) 
    for j=1:size(car_all,1) 
        car_all_norm(j,i)=(car_all(j,i)-mean(car_all(:,i)))/std(car_all(:,i));
    end
end
car_mpg_norm=zeros(size(car_mpg));
for k=1:size(car_mpg,1)
    car_mpg_norm(k)=(car_mpg(k)-mean(car_mpg(:)))/std(car_mpg(:));
end

% multi dimensional linear regression function
w5=lin_reg_md(car_all_norm,car_mpg_norm);
y4_norm=car_all_norm*w5;
y4=zeros(size(y4_norm));
for i=1:size(y4_norm,1)
    y4(i)=(y4_norm(i)*std(car_mpg(:)))+mean(car_mpg(:));
end


Table = table(car_mpg, y4);
figure
uitable('Data',Table{:,:},'ColumnName', {'Target MPG' 'Predicted Target'},...
        'Units','centimeters','Position',[1, 1, 10, 10]);
 
 
% Re running the task 1,3 and 4 from task2 for 10 times 
% Computing the objective (mean square error) on the 5% of the data(training data set) 

train_set = zeros (10:3);
%10 loops and 3 models

for i=1:10
    % Turkish stock data
    idx = randperm(size(stock_data,1));
    temp= round(size(stock_data,1)/20);
    stock_train = stock_data(idx(1:temp),:);
    
    % Car data
    idx = randperm(size(car_data,1));
    temp2= round(size(car_data,1)/20);
    car_train = car_data{idx(1:temp2),2:end};
    
    % 1 from task 2
    stock_var1=stock_train(:,1);
    stock_target1=stock_train(:,2);
    w1_1=lin_reg_1D(stock_var1,stock_target1);
    train_set(i,1) = mean_sqaure_1d(stock_var1,stock_target1,w1_1,0);
    % 3 from task 2
    car_mpg1 = car_train(:,1);
    car_weight1 = car_train(:,4);
    [w2_1,w3_1] = lin_reg_1D_intercept(car_mpg1,car_weight1);
    train_set(i,2) = mean_sqaure_1d(car_mpg1,car_weight1,w2_1,w3_1);
    % 4 from task 2
    car_all1 = car_train(:,2:4);
    car_all_norm1=zeros(size(car_all1));
    %Normalizing
    for j=1:size(car_all1,2) 
    for k=1:size(car_all1,1) 
        car_all_norm1(k,j)=(car_all1(k,j)-mean(car_all1(:,j)))/std(car_all1(:,j));
    end
    end
    car_mpg1 = car_train(:,1);
    car_mpg_norm1=zeros(size(car_mpg1));
    for l=1:size(car_mpg1,1)
    car_mpg_norm1(l)=(car_mpg1(l)-mean(car_mpg1(:)))/std(car_mpg1(:));
    end
    w4_1=lin_reg_md(car_all_norm1,car_mpg_norm1);
    train_set(i,3) = mean_sqaure_md(car_all_norm1,car_mpg_norm1,w4_1);
end

% Re running the 1,3 and 4 from task2 for 10 times 
% Computing the objective (mean square error) on the 95% of data (test data set) 

test_set = zeros (10:3);
%10 loops and 3 models

for i=1:10
    %Turkish stock data
    idx = randperm(size(stock_data,1));
    temp= round(size(stock_data,1)/20);
    stock_test = stock_data(idx(temp:end),:);
    
    %Car data
    idx = randperm(size(car_data,1));
    temp2= round(size(car_data,1)/20);
    car_test = car_data{idx(temp2:end),2:end};
    
    %1 from task 2
    stock_var1_1=stock_test(:,1);
    stock_target1_1=stock_test(:,2);
    test_set(i,1) = mean_sqaure_1d(stock_var1_1,stock_target1_1,w1_1,0);
    % 3 from task 2
    car_mpg1_1 = car_test(:,1);
    car_weight1_1 = car_test(:,4);
    test_set(i,2) = mean_sqaure_1d(car_mpg1_1,car_weight1_1,w2_1,w3_1);
    % 4 from task 2
    car_all1_1 = car_test(:,2:4);
    car_all_norm1_1=zeros(size(car_all1_1));
    %Normalizing
    for j=1:size(car_all1_1,2) 
    for k=1:size(car_all1_1,1) 
        car_all_norm1_1(k,j)=(car_all1_1(k,j)-mean(car_all1_1(:,j)))/std(car_all1_1(:,j));
    end
    end
    car_mpg1_1 = car_test(:,1);
    car_mpg_norm1_1=zeros(size(car_mpg1_1));
    for l=1:size(car_mpg1_1,1)
    car_mpg_norm1_1(l)=(car_mpg1_1(l)-mean(car_mpg1_1(:)))/std(car_mpg1_1(:));
    end
    test_set(i,3) = mean_sqaure_md(car_all_norm1_1,car_mpg_norm1_1,w4_1);
end

% Average training and test set objective function

avg_obj_train=zeros(3,1);
avg_obj_test=zeros(3,1);

for i=1:3
    avg_obj_train(i)=mean(train_set(i));
    avg_obj_test(i)=mean(test_set(i));
end

final = table(avg_obj_train,avg_obj_test);
figure
uitable('Data',final{:,:},...
        'RowName',{'one Dim' 'one Dim with Intercept' 'multi Dim'},...
        'ColumnName', {'Training set' 'Test set'},...
        'Units','centimeters','Position',[1, 1, 10, 10]);
