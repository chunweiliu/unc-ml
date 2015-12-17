function [dbeta0, dbeta] = dLogLikLogReg(y, X, beta0, beta)
p = sigmoid(y.*(beta0+beta*X));
dbeta0 = sum((1-p).*y);
dbeta = zeros(1, length(beta));
for i = 1:length(beta)
    dbeta(i) = sum((1-p).*y.*X(i,:));
end