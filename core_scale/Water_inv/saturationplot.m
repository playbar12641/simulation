
function saturationplot(A,time_days,numerical,type)

if min(size(A))==1
    A=vectortomatrix(A,numerical);    
end

colormin=0;
colormax=1;

if strcmp(type,'water')
plot_title=sprintf('Water Saturation Distribution at %d days', time_days); 
% temp=colormin;
% colormin=colormax;
% colormax=temp;

elseif strcmp(type,'oil')
plot_title=sprintf('Oil Saturation Distribution at %d days', time_days); 
else
fprintf('\nError in Saturationplot.m\n');
end

xmax=max(numerical.gridcenter_x)+0.5*max(max(numerical.dx));
ymax=max(numerical.gridcenter_y)+0.5*max(max(numerical.dy));

figure
run IEEEfigure.m 
surface(numerical.gridcenter_x,numerical.gridcenter_y,transpose(A))
colormap('jet');
if strcmp(type,'water')
    colormap(flipud(colormap));
end
xlim([0,xmax]);
ylim([0,ymax]);
colorbar3 = colorbar('YLim',[colormin colormax]);
set(get(colorbar3,'Title'),'string','Unit: fraction');
title(plot_title);
xlabel('Reservoir Length in x-axis, ft')
ylabel('Reservoir Length in y-axis, ft')       



