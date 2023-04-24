function accuracy = accuracy (prob_classes,test_result)

test = size(test_result, 1);
assumed = zeros(test, 2); 
counter = 0;
    
for e = 1 : test
[assumed(e, 1), assumed(e, 2)] = max(prob_classes(e, :));  
    if assumed(e, 2) == test_result(e) 
            counter = counter + 1;
    end
end
    
accuracy = counter / test * 100;
    
end