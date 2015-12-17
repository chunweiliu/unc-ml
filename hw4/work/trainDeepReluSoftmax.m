function bestParams = trainDeepReluSoftmax(architecture,data,labels,initParams,lambda)
assert(architecture(1).size == size(data,1));


options.MaxIter = 200;
options.MaxFunEvals = 200;
options.Method = 'csd';
options.display = 'on';
options.outputFcn = [];
options.TolX = 1e-10;

options.outputFcn = @(x,infoStruct,state) displayState(x,architecture,data);
f = @(p)deepReluSoftMaxCost(p, architecture,data,labels,lambda);
optParams =  minFunc(f,packParams(initParams),options);
bestParams = unpackParams(optParams,architecture);

function displayState(x,architecture,data)
params = unpackParams(x,architecture);
L = length(architecture);
mapper = data;
 
for i=2:L-1
    insize = architecture(i-1).size;
    outsize = architecture(i).size;
    subplot(L-2,1,i-1);
    W = params(i).w;
    b = params(i).b;
    vis = zeros(size(data,1),outsize);    
    cross = W*mapper + repmat(b,[1 size(mapper,2)]);   
    for j=1:outsize
        lst = find(cross(j,:)>prctile(cross(j,:),95));
        if length(lst)
            vis(:,j)=sum(data(:,lst),2);
             vis(:,j) = vis(:,j)/max(abs(vis(:,j)));
        end        
    end
    mapper = cross;
    cross = max(cross,0);
    display_network(vis);
end


