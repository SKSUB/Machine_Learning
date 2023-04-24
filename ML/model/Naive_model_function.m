function [prob_class, prob_attributes_class] = Naive_model_function(trainset,testset,classes,levels)
    % Inputs of the function are dataset(training dataset,result(training dataset result),classes and levels of attributes
    % Outputs are P_class and p_attributes_class to the main program
    
    [Observation, attributes] = size(trainset);
    maxlevels=max(levels); 
    
    % number of instances of classes
    N_c = zeros(classes, 1); 
    
    % number of instances of attributes for classes
    N_f_c = zeros(attributes, maxlevels, classes);  
    
    % dataset analysis
    for i = 1:Observation 
        c=testset(i); 
        N_c(c)=N_c(c)+1;
        for j = 1:attributes 
            for k = 1:levels(j) 
                if trainset(i,j)==k
                    N_f_c(j,k,c)= N_f_c(j,k,c)+1; 
                end
            end
        end
    end
    
    % Finding P_class
    prob_class = zeros(classes, 1);
    
  
    for c = 1:classes
        prob_class(c) = N_c(c) / Observation;
    end
    
    % finding p_attributes_class
    prob_attributes_class = zeros(attributes, maxlevels, classes);

    for c = 1:classes 
        for j = 1:attributes 
            for l = 1:maxlevels
                prob_attributes_class(j, l, c) = (N_f_c(j, l, c)) / ( N_c(c));
            end
        end
    end    
    
    % Checking the probability
    for j=1:attributes
        for c=1:classes
            if sum(prob_attributes_class(j,:,c))>=1.001 || sum(prob_attributes_class(j,:,c))<0.999
                disp('error in probability');
            end
        end
    end

