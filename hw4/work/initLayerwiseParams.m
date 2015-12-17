function layerwiseParams = initLayerwiseParams(arch)
L = length(arch);
paramStruct = struct('w',{},'b',{});
layerwiseParams = repmat(paramStruct,[L 1]);
for i=2:L
    inSize = arch(i-1).size;
    outSize = arch(i).size;
    r = sqrt(6)/sqrt(inSize+outSize+1);  
    params = [];
    if arch(i).hasw
        params.w = rand(outSize,inSize)*2*r - r;
    else
        params.b = [];
    end
    if arch(i).hasb
        params.b = zeros(outSize,1);
    else
        params.b = [];
    end
    layerwiseParams(i) = params;
end

