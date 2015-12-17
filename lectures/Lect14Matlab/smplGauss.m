function smplGauss
z = randn(2,1000);
mu = [5 5]';
L = [3 1; -2  1];
x=L*z + repmat(mu,[1 1000]);
Sigma = L*L';

%%
clear all
clf
subplot(2,1,1)
hold on
plot(x(1,:),x(2,:),'.')
xlabel('x','FontSize',12)
ylabel('y','FontSize',12)
mx = max(z,[],2);
mn = min(z,[],2);
xlim([mn(1) mx(1)])
ylim([mn(2) mx(2)])

ys = [10 8 6 2 0 -1]; colors = {'c','r','g','b','k','y'};

for i=1:length(ys)
    line([mn(1) mx(1)],ys(i)*[1 1],'Color',colors{i},'LineWidth',2);
    strs{i} = ['y = ' num2str(ys(i))];
end
legend({'Samples',strs{:}},'FontSize',12)
set(gca,'FontSize',12)
hold off
subplot(2,1,2)
%%
A = Sigma(1,1);
C = Sigma(1,2);
B = Sigma(2,2);
a = mu(1); b = mu(2);

for i=1:length(ys)
    % mean of x2 conditional on a given x1 value
    y = ys(i);
    mux = a + C'*inv(B)*(y - b);
    varx = A - C*inv(B)*C';
    plotGaussianDensity(mux,varx,colors{i});
    hold on
end

%%
xlabel('x','FontSize',12)
ylabel('p(x|y)','FontSize',12)
xlim([mn(1) mx(1)])
legend(strs,'FontSize',12)
set(gca,'FontSize',12)
%saveFig('../conditional',gcf,'pdf')


function plotGaussianDensity(m,v,color)
s = sqrt(v);
x=linspace(m-4*s,m+4*s,100);
pdfx=1/sqrt(2*pi)/s*exp(-(x-m).^2/(2*s^2));
plot(x,pdfx,color,'LineWidth',2);