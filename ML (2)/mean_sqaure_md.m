function objective = mean_sqaure_md(x,t,w)
%inputs are x(data),t(target),w1(slope)
%outputs are objective function
y = x*w; 
objective = immse(t,y);
end