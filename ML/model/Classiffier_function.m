function prob_classes = Classiffier_function(testset, p_c, p_feature_class, classes)
    % Inputs are test set, P_class , p_attributes_class and classes
    % Outputs is prob_classes to the main function    
    % finding prob_classes
    test=size(testset,1);
    prob_classes = zeros(test, classes); 
    [test, attributes] = size(testset);
  
    product=ones(test,classes);

    for i = 1:test 
      for j= 1:attributes 
          k = testset(i,j); % level taken from data set
          for c=1:classes
            product(i,c) = product(i,c) * p_feature_class(j,k,c); 
          end
      end

      for c = 1:classes
         prob_classes(i, c) = product(i,c) * p_c(c); 
      end
      
    end        
  
end