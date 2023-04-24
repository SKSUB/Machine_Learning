function w = lin_reg_1D(x,t)
%inputs for the function are x(input or data) and t(target data)
%Output of the function is w

 w = sum(x.*t) / sum(x.^2);
end