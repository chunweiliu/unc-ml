function y = logsum(x)
x = x(:);
m = max(x);
y = log(sum(exp(x-m))) + m;