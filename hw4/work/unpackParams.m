function [layerwiseParams] = unpackParams(params,arch)
L = length(arch);
paramStruct = struct('w',[],'b',[]);
layerwiseParams = repmat(paramStruct,[L 1]);
ct = 0;
for i=2:L
    insize = arch(i-1).size;
    outsize = arch(i).size;
    if arch(i).hasw
        layerwiseParams(i).w = reshape(params(ct+1:ct+insize*outsize),[outsize insize]);
        ct = ct+insize*outsize;
    end    
    if arch(i).hasb
        layerwiseParams(i).b = params(ct+1:ct+outsize);
        ct = ct+outsize;
    end       
end