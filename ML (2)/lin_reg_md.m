function W = lin_reg_md(x,t)
%inputs of the function are all x(car data column except mpg)and t(mpg)
%output of the function is w
W=pinv(x'*x)*x'*t;
end