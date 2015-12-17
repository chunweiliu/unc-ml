function patches = normalizeData(patches) 
patches = bsxfun(@minus,patches,mean(patches));
patches = patches/(3*std(patches(:)));
patches = sign(patches).*min(abs(patches),1);
patches = (patches+1)*0.4+0.1;
