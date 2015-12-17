load hw1.mat
rand('seed',1); K = 5; N = length(y);
indices = crossvalind('Kfold',N,K);
err = zeros(1,K);
for k=1:K
    testX = X(:,indices == k);
    testY = y(indices == k);
    trainX = X(:,indices ~= k);
    trainY = y(indices ~= k);
    [beta0,beta,vals] = fitLogReg(trainY,trainX);
    for i=1:length(testY)
        predY = predictY(testX(:,i),beta0,beta);
        err(k) = err(k) + abs(testY(i)-predY)/2;
    end
end
cvErr = sum(err)/length(y);