function [beta0,beta,vals] = fitLogReg(trainY,trainX)
% random initialize beta0 and beta, and use gradient decent for updating
s = 1e-4;
max_iterations = 2000;

beta0 = randn(1,1);
beta = randn(1,size(trainX,1));

vals = zeros(1,max_iterations);
for i = 1:max_iterations
    % implement gradient assent
    [dbeta0, dbeta] = dLogLikLogReg(trainY,trainX,beta0,beta);
    beta0 = beta0 + s * dbeta0;
    beta = beta + s * dbeta;
    
    vals(i) = LogLikLogReg(trainY,trainX,beta0,beta);
end