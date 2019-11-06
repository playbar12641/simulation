function pressureplot(pressure,time_days,numerical,type)

if min(size(pressure))==1
    pressure=vectortomatrix(pressure,numerical);    

end

if strcmp(type,'water')
plot_title=sprintf('Water Pressure Distribution (psi) at %d days', time_days); 
elseif strcmp(type,'oil')
plot_title=sprintf('Oil Pressure Distribution (psi) at %d days', time_days); 
else
fprintf('\nError in pressureplot.m\n');
end

xmax=max(numerical.gridcenter_x)+0.5*max(max(numerical.dx));
ymax=max(numerical.gridcenter_y)+0.5*max(max(numerical.dy));

figure
run IEEEfigure.m 
surface(numerical.gridcenter_x,numerical.gridcenter_y,transpose(pressure))
colormap('jet');
xlim([0,xmax]);
ylim([0,ymax]);
colorbar3 = colorbar('YLim',[min(min(pressure)) max(max(pressure))]);
set(get(colorbar3,'Title'),'string','Unit: psi');
title(plot_title);
xlabel('Reservoir Length in x-axis, ft')
ylabel('Reservoir Length in y-axis, ft')       