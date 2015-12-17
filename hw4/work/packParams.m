function params = packParams(layerwiseParams)
params = [];
for i=2:length(layerwiseParams)
    params = [params;layerwiseParams(i).w(:)];
    params = [params;layerwiseParams(i).b(:)];      
end