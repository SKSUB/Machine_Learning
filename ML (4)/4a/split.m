function [x_set,num_sets] = split(x,k)
% Iris dataset and functions are input
% Set and number of sets are output

% Split dataset 
[rows,~]=size(x);
rand_idx=randperm(rows);
x=x(rand_idx,:);
    
% splitting based on four conditions
if k==2    
   training_portion=[1:round(rows/2)];
   testing_portion=[(round(rows/2)+1):rows];
   x_set.train{1} = x(training_portion,1:(end-1));
   x_set.test{1} = x(testing_portion,1:(end-1));
   x_set.trainlab{1} = x(training_portion,end);
   x_set.testlab{1} = x(testing_portion,end);
   num_sets=1;
    
elseif k==rows
    for i=1:rows
        x_temp=x;
        x_temp(i,:)=[];
        x_set.train{i}=x_temp(:,1:(end-1));
        x_set.test{i}=x(i,1:(end-1));
        x_set.trainlab{i}=x_temp(:,end);
        x_set.testlab{i}=x(i,end);
    end
     num_sets=rows;
        
elseif k>2 && k<rows 
       x2=[x; x];
     for i=1:rows
            training_portion=[1:rows/k];
            testing_portion=[rows/k + 1 : rows];
            x_set.train{i}=x2(training_portion,1:(end-1));
            x_set.test{i}=x2(testing_portion,1:(end-1));
            x_set.trainlab{i}=x2(training_portion,end);
            x_set.testlab{i}=x2(testing_portion,end);
      end
num_sets=k;
    
elseif k<2 && k>rows
       disp('Error'); 
end
    
end