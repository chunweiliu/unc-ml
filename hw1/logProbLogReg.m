function logP = logProbLogReg(y, X, beta0, beta)
logP = log(sigmoid(y*(beta0+beta*X)));