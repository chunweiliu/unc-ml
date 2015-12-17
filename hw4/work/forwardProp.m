function os = forwardProp(data,layerwiseParams,architecture)
L = length(architecture);

os = cell(L,1);
os{1} = data;
N = size(data,2);
% relu propagation
for l=2:L-1
    W = layerwiseParams(l).w;
    b = layerwiseParams(l).b;
    a = W*os{l-1} + repmat(b,[1 N]);
    os{l} = max(0, a); % implement activation function of for
                       % rectified linear unit
end

% softmax
softmaxW = layerwiseParams(L).w;
C = architecture(L).size; % number of classes
o = softmaxW * os{L-1};
o = o - repmat(max(o,[],1),[C 1]);
o = exp(o);
o = o./repmat(sum(o),[C 1]);
os{L} = o;