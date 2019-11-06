function p_line_plot(pressure,time_days,numerical)

if min(size(pressure))==1
    pressure=vectortomatrix(pressure,numerical);    
end


plot_title=sprintf('Pressure Distribution (psi) at %d days', time_days); 

xmax=max(numerical.gridcenter_x)+0.5*max(max(numerical.dx));
%ymax=max(numerical.gridcenter_y)+0.5*max(max(numerical.dy));
ymid=ceil(numerical.Ny/2)+2;
p_line=pressure(:,ymid);

figure
run IEEEfigure.m
plot(numerical.gridcenter_x(:)*30.48,p_line(:))
xlim([0,xmax]*30.48);
ylim([615,650]);

title(plot_title);
xlabel('Reservoir Length in x-axis, cm')
ylabel('Pressure, psi')    
set(gca,'linewidth',2);