function [val,d,dd] = logRegGaussPrior(z,y,a,gamma)
val = log(1 + exp(-y*z)) + gamma*(z-a)^2;
if nargout > 1 % caller asked for derivatives
    d = 2*gamma*z - 2*gamma*a - y/(exp(y*z) + 1); % first derivative
    dd = (exp(-y*z)/(exp(-y*z) + 1) - exp(-2*y*z)/(exp(-y*z) + 1)^2)*y^2 ...
       + 2*gamma; % second derivative
end