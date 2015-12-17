function x = shrinkThreshold(x,lambda)
x = sign(x).*max(abs(x) - lambda,0);