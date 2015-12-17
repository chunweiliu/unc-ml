function w = updatew(X,z0,z1,z2,u0,u1,u2,D,rho)
A = sqrt(rho)*[X;eye(length(z1));D];
b = sqrt(rho)*[z0+u0/rho;z1+u1/rho;z2+u2/rho];
w = A\b;