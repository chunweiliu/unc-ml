function d = dsigmoid(z)
%DSIGMOID computes first derivative of sigmoid function at z
d = exp(-z)/(1+exp(-z))^2;
end