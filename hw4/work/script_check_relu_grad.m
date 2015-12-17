d = 3;
nametag = date;
trainData = normalizeData(randn(d^2,21));
trainLabels = [ones(1,4) 2*ones(1,4) 3*ones(1,4) 4*ones(1,4) 5*ones(1,5)];

arch(1) = struct('size',d^2,'hasb',0,'hasw',0);
%first relu layer
arch(2) = struct('size',3,'hasb',1,'hasw',1);
%second relu layer
arch(3) = struct('size',4,'hasb',1,'hasw',1);
%softmax layer -- no bias, 10 indicator variables one for each digit
arch(4) = struct('size',5,'hasb',0,'hasw',1);
% lambda = 0.001;
lambda = 0;
params = initLayerwiseParams(arch);
f = @(p) deepReluSoftMaxCost(p,arch,trainData, trainLabels,lambda);
checkGradient(f,packParams(params))