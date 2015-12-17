function path = backtrace(m_f, paths)
path = zeros(size(m_f,2),1);
[~, idx] = max(m_f(:,end));

path(end) = idx;
for i = 1:length(path)-1
    path(end-i) = paths(path(end-i+1),end-i+1);
end
