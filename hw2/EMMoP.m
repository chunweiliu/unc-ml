function [etas,pis] = EMMoP(x)
etas = log(mean(x) + 0.0001*rand(2,1));
pis = 0.5*ones(2,1);
q = 0.5*ones(2,length(x));

MAXIT = 100;
eps = 1e-3;

for it=1:MAXIT
    before = computeBound(q,x,etas,pis);
    for i=1:length(x)
        q(:,i) = computeQ(x(i),etas,pis);
    end
    after = computeBound(q,x,etas,pis);
    assert(after + eps > before);
    before = after;
    [etas,pis] = updateParameters(q,x);
    after = computeBound(q,x,etas,pis);
    assert(after + eps > before);
    bounds(it) = after;
    plot(bounds);
    drawnow;
end

function bound = computeBound(q,x,etas,pis)
bound = 0;
for i=1:length(x)
    for c=1:2
        bound = bound + q(c,i)*(etas(c)*x(i)-exp(etas(c))+log(pis(c)));
    end
end
for i=1:length(x)
    for c=1:2
        bound = bound - q(c,i)*log(q(c,i));
    end
end