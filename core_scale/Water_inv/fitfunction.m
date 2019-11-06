function [myfit,caption,xt,yt]=fitfunction(x_exp,y_exp)

x_exp=x_exp(:);
y_exp=y_exp(:);


xt=min(x_exp);
yt=max(y_exp);

ft=fittype({'x^2','x'});
myfit=fit(x_exp,y_exp,ft);
p=coeffvalues(myfit);
caption = sprintf('y = %4.3f * x^2 + %4.3f * x', p(1), p(2));

% figure
% run IEEEfigure.m
% plot(myfit,x_exp,y_exp);
% text(xt, yt, caption);
% xlabel('Invasion time (min)');
% ylabel('Amount of gas invaded (mL)');
% legend('fit','data');
% set(gca,'linewidth',2);
