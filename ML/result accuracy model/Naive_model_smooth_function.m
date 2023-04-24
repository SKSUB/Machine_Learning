function [prob_class_smooth, prob_attributes_class_smooth] = Naive_model_smooth_function(trainset,testset,classes,levels)
    % Inputs of the function are dataset(training dataset,result(training dataset result),classes and levels of attributes
    % Outputs are prob_class_smooth and prob_attr_class_smooth to the main program
    
    [Observation, attributes] = size(trainset);
    maxlevels=max(levels); 
    a=1; 
    %smoothing factor
    
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
    prob_class_smooth = zeros(classes, 1);
    
  
    for c = 1:classes
        prob_class_smooth(c) = N_c(c) / Observation;
    end
    
    % finding p_attributes_class by applying smoothing 
    prob_attributes_class_smooth = zeros(attributes, maxlevels, classes);

    
    for c = 1:classes 
        for j = 1:attributes 
            for l = 1:maxlevels
                prob_attributes_class_smooth(j, l, c) = (N_f_c(j, l, c)+a) / ( N_c(c)+a*levels(j));
            end
        end
    end    
    
    