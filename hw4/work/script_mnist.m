
addpath ./minFunc/

mnistData   = loadMNISTImages('train-images.idx3-ubyte');
mnistLabels = loadMNISTLabels('train-labels.idx1-ubyte');

labeledSet   = find(mnistLabels >= 0 & mnistLabels <= 9);

numTrain = round(numel(labeledSet)/2);
trainSet = labeledSet(1:numTrain);
testSet  = labeledSet(numTrain+1:end);


trainData   = normalizeData(mnistData(:, trainSet));
trainLabels = mnistLabels(trainSet)' +1;

testData   = normalizeData(mnistData(:, testSet));
testLabels = mnistLabels(testSet)' +1;


clear arch
%input layer, digit image 28*28, no params
arch(1) = struct('size',28*28,'hasb',0,'hasw',0);
%first relu layer
arch(2) = struct('size',64,'hasb',1,'hasw',1);
%second relu layer
arch(3) = struct('size',64,'hasb',1,'hasw',1);
%softmax layer -- no bias, 10 indicator variables one for each digit
arch(4) = struct('size',10,'hasb',0,'hasw',1);

L = length(arch);
params0 = initLayerwiseParams(arch);
optParams = trainDeepReluSoftmax(arch,trainData,trainLabels,params0,0.0001);


os0 = forwardProp(testData,params0,arch);
[~,pred0] = max(os0{L},[],1);
err0 = sum(pred0 ~= testLabels)/length(testLabels);

os1 = forwardProp(testData,optParams,arch);
[~,pred1] = max(os1{L},[],1);
err1 = sum(pred1 ~= testLabels)/length(testLabels);

fprintf('Error before training: %d\n Error after training: %d\n', err0,err1);
