function K=spprec(S,lambda)
n = size(S,1);
assert(size(S,2) == n);
if length(lambda)==1
    W = lambda*eye(n);
else
    W = diag(diag(lambda));
end
dg = [1:n+1:n*n];
tic
tol = 1e-6;
for it=1:10000
    G = inv(S + W);
    G(dg) = 0;
    G(find(W == lambda & G>0)) = 0;
    G(find(W == -lambda & G<0)) = 0;
    W = lineSearch(S,W,G,lambda); 
    K = inv(S + W);
    gap = trace(S/(S+W)) + sum(sum(lambda.*abs(K))) - n;
    if gap < tol
        break;
    end
    t = toc;
    if mod(it,10) == 0
        fprintf('time: %2.2g,it:%d \t gap:%6d\n',t,it,gap);        
    end
end


function pr = lineSearch(S,W,G,lambda)
f0 = log(det(S + W));
iswg = (S + W)\G;
t = trace(iswg)/(trace(iswg*iswg));
assert(isfinite(t))
pr = W;
it = 0; MAXIT = 20;
while it<MAXIT;
    pr = projB(W + t*G,lambda);
    val = log(det(S + pr));
    if val>f0
        break;
    end
    t = t/2;
    it = it+1;
end
    
function pr = projB(W,lambda)
pr = min(abs(W),lambda).*sign(W);

    

    