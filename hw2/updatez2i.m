function z2i = updatez2i(Di, w, u2i, mu, rho)
z2i = shrinkThreshold(Di'*w - u2i/rho,mu/rho);