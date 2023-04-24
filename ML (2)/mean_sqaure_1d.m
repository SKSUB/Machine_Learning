function objective = mean_sqaure_1d(x,t,w1,w0)
%inputs are x(data),t(target),w1(slope),w0(intercept)
%outputs are objective function
N = length(x);
y = w1*x + w0; 
objective = (1/N)*sum((t-y).^2);
end