function new_z0i = updatez0i(z0i, xi, yi, w, u0i, rho)
z = z0i;
y = yi; 
a = xi'*w - u0i/rho; 
gamma = rho/2;

f = @(z) logRegGaussPrior(z,y,a,gamma);
new_z0i = newtonWolfeBacktrack(f,z);