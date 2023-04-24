function[classification, error] = knn(Train_set, Test_set, k, Test_label)
% Input of the function are training set, testing set, k and test label
% Output of the funciton is classfication and error in the classifier


[row_train,col_train] = size(Train_set);
[row_test,col_test] = size(Test_set);

%checking
% Arguments checking
if nargin <3
   disp('Inputs are not enough to run');
   return
end
    
%column checking
if col_test+1 ~= col_train
   disp('Column size error');
   return
end
    
% k>0 and k<=cardinality of the training set checking
if k < 0 || k > row_train
   disp('k>0 and k<=cardinality of the training set error');
   return
end
    
%computing knn
[~ , train] = pdist2(Train_set(:,1:col_test), Test_set, 'euclidean', 'Smallest', k); 
    
% computing labels
label = zeros(size(train)); 
for i=1:size((train),1)
    for j=1:size((train),2)
        label(i,j) = Train_set(train(i,j),end); 
    end
end

% It's a classification problem: return the mode of the K labels
classification=zeros(size(train,2), 1);
for i=1:size((train),2)
    classification(i,1)=mode(label(:,i));
end

% Compute the error rate
    if nargin > 3
        error = (sum(classification ~= Test_label))/row_test;
    end
end
 

