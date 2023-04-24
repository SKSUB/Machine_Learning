function [confus_matrix,w]=perceptron(x_set,eta,num_sets)
% Set, number of sets and eta are input
% confusion matrix and weight 

%matrix creation
matrix_confusion=zeros(2,2,num_sets);

%computing (for loop for the training and test set)
for sets=1:num_sets
x=x_set.train{sets};
t=x_set.trainlab{sets};
w = rand(size(x_set.train{1},2),1);
xl = 1;

for var=1:10000
%computing error and outputs
r =  x(xl,:) * w;

a = sign(r);       
 
delta = 0.5 * ( t(xl) - a );
            

%w and x1 final
w = w + eta * delta * x(xl,:)';

xl=xl+1;
if xl>=size(x_set.train{1},1)
   xl=1;
end

end
        
%test set
xtest=x_set.test{sets};
xtestlab=x_set.testlab{sets};
myPrediction=sign(xtest*w);
        
%confusion matrix 
for i=1:size(xtest,1)
     if myPrediction(i)==1 && xtestlab(i)==1
        matrix_confusion(1,1,sets)=matrix_confusion(1,1,sets)+1;
     elseif myPrediction(i)==(-1) && xtestlab(i)==1
            matrix_confusion(1,2,sets)=matrix_confusion(1,2,sets)+1;
     elseif myPrediction(i)==1 && xtestlab(i)==(-1)
            matrix_confusion(2,1,sets)=matrix_confusion(2,1,sets)+1;
     elseif myPrediction(i)==(-1) && xtestlab(i)==(-1)
            matrix_confusion(2,2,sets)=matrix_confusion(2,2,sets)+1;
     end
end
        
end

% Transformed matrix 
matrix_confusion=(matrix_confusion/size(x_set.test{1},1))*100; 
    
% Final matrix
for i=1:4
    confus_matrix(1,1)=mean(matrix_confusion(1,1,:));
    confus_matrix(1,2)=mean(matrix_confusion(1,2,:));
    confus_matrix(2,1)=mean(matrix_confusion(2,1,:));
    confus_matrix(2,2)=mean(matrix_confusion(2,2,:));
end
    