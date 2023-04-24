function [w3,w4] = lin_reg_1D_intercept(x,t)
%inputs for the function are x(input or data) and t(target data)
%Outputs of the function is w3 and w4 slope and intercept repectively. 
x_mean = mean (x);
t_mean = mean (t);
x = x-x_mean;
t = t-t_mean;
w3 = sum (x.*t) / sum (x.^2);
w4 = t_mean-w3*x_mean;
end

