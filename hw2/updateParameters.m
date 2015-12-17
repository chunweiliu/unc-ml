function [etas,pis] = updateParameters(q,x)
pis = zeros(2,1);
for i=1:length(x)
    for c=1:2
        pis(c) = pis(c) + q(c,i);
    end
end
pis = pis/sum(pis);

etas = zeros(2,1);
for c=1:2
    for i=1:length(x)        
        etas(c) = etas(c) + q(c,i)*x(i);
    end
end
etas = log(etas./sum(q,2));