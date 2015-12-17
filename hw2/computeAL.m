function val = computeAL(y,X,D,lambda,mu,rho,w,z0,z1,z2,u0,u1,u2)
val = sum(log(1+exp(-y.*z0))) + lambda*norm(z1,1) + mu*norm(z2,1)... % data term
    + u0'*(z0-X*w) + u1'*(z1-w) + u2'*(z2-D*w)...  % penalty
    + 0.5*rho*(norm(z0-X*w)^2 + norm(z1-w)^2 + norm(z2-D*w)^2);  % lagrangian