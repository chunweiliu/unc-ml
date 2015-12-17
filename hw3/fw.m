function m_f = fw(s,x,pins,pdel,pcopy)
N = length(s);
L = length(x)/2;
m_f = -realmax*ones(N,2*L);

logpins = log(pins);
logpdel = log(pdel);
logpcopy = log(pcopy);
logmut = zeros(4,4);
for a=1:4
    for b=1:4
        logmut(a,b) = log(0.99)*(a==b) + log(0.01/3)*(a~=b);
    end
end

m_f(1:N,1) = -log(N) + logmut(s,x(1));
for i=2:2*L
    for prev=1:N
        if i~=L+1
            % insert
            vala = m_f(prev,i);  % variable for accumulated sum up             
            % curr state + next state + transition prob to next state            
            valb = m_f(prev,i-1) + logmut(s(prev),x(i)) + logpins;
            m_f(prev,i) = logsum([vala valb]);
            if prev<=N-2
                % delete
                vala = m_f(prev+2,i);
                valb = m_f(prev,i-1) + logmut(s(prev+2),x(i)) + logpdel;
                m_f(prev+2,i) = logsum([vala valb]);
            end
            if prev<=N-1
                % copy
                vala = m_f(prev+1,i);
                valb = m_f(prev,i-1) + logmut(s(prev+1),x(i)) + logpcopy;
                m_f(prev+1,i) = logsum([vala valb]);
            end
        else
            % trauncated poisson
            if prev+90<=N
                for next=prev+90:min(prev+110,N)
                    vala = m_f(next,i);
                    valb = m_f(prev,i-1) + logmut(s(next),x(i)) + logProbTruncPoiss(next-prev,100);
                    m_f(next,i) = logsum([vala valb]);
                end
            end
        end
    end
end