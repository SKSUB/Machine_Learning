function [confus_matrix,w]=adaline(x_total,eta,num_sets)
% Set, number of sets and eta are input
% confusion matrix and weight 


%matrix creation
matrix_confusion=zeros(2,2,num_sets);

%computing (for loop for the training and test set)
for sets=1:num_sets
x=x_total.train{sets};
t=x_total.trainlab{sets};
w = rand(size(x_total.train{1},2),1);
xl = 1;

for var=1:10000
    
%compute eroor and output      
r =  x(xl,:) * w; 
delta = 0.5 * ( t(xl) - r );

% w and x1 final 
w = w + eta * delta * x(xl,:)' * (1/size(x_total.train{1},1));
xl=xl+1;
if xl>=size(x_total.train{1},1)
   xl=1;
end
            
end
        
%test set
xtest=x_total.test{sets};
xtestlab=x_total.testlab{sets};
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
    
%matrix tranfomeed 
matrix_confusion=(matrix_confusion/size(x_total.test{1},1))*100; 
    
%final matrix
for i=1:4
    confus_matrix(1,1)=mean(matrix_confusion(1,1,:));
    confus_matrix(1,2)=mean(matrix_confusion(1,2,:));
    confus_matrix(2,1)=mean(matrix_confusion(2,1,:));
    confus_matrix(2,2)=mean(matrix_confusion(2,2,:));
end
    
end