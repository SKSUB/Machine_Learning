%% Subramani ML lab 1
clear
clc
close all

% loading the weaher data
data_set = importdata('Weather_data_set.txt')

% findind the values are less than one
for i=1:size(data_set,1)
    for j=1:size(data_set,2)
        if data_set(i,j) < 1 
            disp('some values are less than one');
            return;
        end
    end
end

% features and their levels
[Observation, features] = size(data_set);
attributes=features-1;
levels=zeros(1,attributes);
for i=1:attributes
    calc = unique(data_set(:,i));
    levels(i) = length(calc);        
end

% Printing the table for atttributes and their levels
attributes= (1:attributes)';
levels=levels';
Table = table(attributes,levels)

% class levels
classes = length(unique(data_set(:,end)))

%shuffling the data
idx = randperm(Observation);
data_set = data_set(idx,:);

% declaring 10 patterns after shuffling

Train=10;

%declaring training set and test set

train_set = data_set(1:Train, 1:end-1);
train_result = data_set(1:Train, end);

test_set = data_set(Train+1:end, 1:end-1);
test_result = data_set(Train+1:end, end);


%evaluationg the model from training data set
[prob_class, prob_attr_class] = Naive_model_function(train_set, train_result, classes, levels');

%testing the model with the test set
prob_classes = Classiffier_function(test_set,prob_class, prob_attr_class,classes);

%Laplace or addtive smoothing

%evaluationg the model from training data set with smoothing
[prob_class_smooth, prob_attr_class_smooth] = Naive_model_smooth_function(train_set, train_result, classes, levels');

%testing the model with the test set with smoothing
prob_classes_smooth = Classiffier_function(test_set,prob_class_smooth, prob_attr_class_smooth,classes);


% publishing the reults for both smooth and normal models

assumed=strings(Observation-Train,1);
tested=strings(Observation-Train,1);
assumed_smooth=strings(Observation-Train,1);

%model without smooth
for i = 1 : (Observation-Train)
        [unused, assumed_val] = max(prob_classes(i, :)); 
        if assumed_val==2
          assumed(i)='yes';
        else 
          assumed(i)='no';
        end
end

%smooth model

for i = 1 : (Observation-Train)
    
    [unused, assumed_val] = max(prob_classes_smooth(i, :)); 
    if assumed_val==2
      assumed_smooth(i)='yes';
    elseif assumed_val==1
      assumed_smooth(i)='no';
    end
    
    if test_result(i)==2
      tested(i)='yes';
    elseif test_result(i)==1
      tested(i)='no';
    end
    
end


% evaluate accuracy 

normal_model_accuracy = accuracy(prob_classes,test_result);

smooth_model_accuracy = accuracy(prob_classes_smooth,test_result);


if size(test_set, 2) > size(train_set, 2) - 1 

fprintf('without smoothing effect');
table(test_set,assumed,tested)
fprintf('without smoothing effect');
table(test_set,assumed_smooth,tested)


fprintf('Accuracy without smoothing effect is %d%% \n\nAccuracy with smoothing effect is %d%% \n', normal_model_accuracy,smooth_model_accuracy);

elseif size(test_set, 2) == size(train_set, 2) - 1
    
    fprintf('without smoothing effect');
    table(test_set,assumed)
    fprintf('without smoothing effect');
    table(test_set,assumed_smooth)
else
        fprintf('problem in test set');
end





