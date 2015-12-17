function z1i = updatez1i(wi, u1i, lambda, rho)
z1i = shrinkThreshold(wi - u1i/rho,lambda/rho);