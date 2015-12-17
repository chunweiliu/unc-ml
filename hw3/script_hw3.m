load('hw3.mat')

m_f = fw(seq, x, 0.005, 0.005, 0.99);
logProb = logsum(m_f(:,end));

%%
% m_f = fw(seq,x,0.005,0.005,0.99);
% m_b = bw(seq,x,0.005,0.005,0.99);
% mm = m_f + m_b;
% logsum(mm(:,1))
% logsum(mm(:,end))

%%
% ts = tic; m_f = fw(seq,x,0.005,0.005,0.99); t_fw = toc(ts);
% ts = tic; m_f_v = Viterbi_fw(seq,x,0.005,0.005,0.99); t_vfw = toc(ts);
% ratio = t_fw/t_vfw

%%
[m_f, paths] = Viterbi_fw(seq,x,0.005,0.005,0.99);
path = backtrace(m_f, paths);