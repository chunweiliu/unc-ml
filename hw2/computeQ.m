function qzi = computeQ(xi,etas,pis)
for c = 1:2
    qzi(c) = log(1/factorial(xi)*exp(etas(c)*xi-exp(etas(c)))) + log(pis(c));
end
qzi = exp(qzi - logsum(qzi));
qzi(1) = qzi(1) > 0.5;
qzi(2) = qzi(2) > 0.5;