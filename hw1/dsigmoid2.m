function d = dsigmoid2(z)
%DSIGMOID2 computes the second derivate of the sigmoid function
d = -(exp(z)*(exp(z) - 1))/(exp(z) + 1)^3;
end

