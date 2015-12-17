function [ cost, grad ] = deepReluSoftMaxCost(params, architecture,...
                                              data,labels,lambda)
L = length(architecture);
[layerwiseParams] = unpackParams(params,architecture);
paramStruct = struct('w',[],'b',[]);
layerwiseParamsGrad = repmat(paramStruct,[L 1]);
for l = 2:L
    % random initialization is better
    layerwiseParamsGrad(l).w = randn(size(layerwiseParams(l).w));
    layerwiseParamsGrad(l).b = randn(size(layerwiseParams(l).b));
end
cost = 0;
T = size(data, 2);
groundTruth = full(sparse(labels, 1:T, 1));

% forward propagation
os = forwardProp(data,layerwiseParams,architecture);
cost = cost -1/T*groundTruth(:)'*log(os{L}(:)) + lambda/2*sum(layerwiseParams(L).w(:).^2);

% backward 
labelMatrix = full(sparse(labels,1:length(labels),1)); % class indicator matrix
delta{L} = -(labelMatrix-os{L});  % negative log likelihood

assert(size(delta{L},1) == architecture(L).size);

for l=L-1:-1:2
    delta{l} = (layerwiseParams(l+1).w)'*delta{l+1} .* double(os{l} > 0);  % check os
    assert(size(delta{l},1) == architecture(l).size);
    cost = cost + lambda/2*sum(layerwiseParams(l).w(:).^2);
end

% need to average over sample size
for l=L:-1:2
    layerwiseParamsGrad(l).w = (delta{l}*os{l-1}')./T ...
        + (lambda*layerwiseParamsGrad(l).w)./T;
    if size(layerwiseParamsGrad(l).b)
        layerwiseParamsGrad(l).b = mean(delta{l},2);
    end
end

for l=1:L
    assert(all(size(layerwiseParamsGrad(l).w) == size(layerwiseParams(l).w)))
    assert(all(size(layerwiseParamsGrad(l).b) == size(layerwiseParams(l).b)))
end
grad = packParams(layerwiseParamsGrad);