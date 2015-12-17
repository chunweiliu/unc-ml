N = 10; p = 5; C = 3;
y = randi(C,1,N);
X = randn(p,N);
W0 = randn(C,p);
lambda = 0;
checkGradient(@(W) softmaxLoss(y,W(:),X,lambda,C), W0(:))
lambda = 0.2;
checkGradient(@(W) softmaxLoss(y,W(:),X,lambda,C), W0(:))