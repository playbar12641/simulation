function Qw=s_line_plot(saturation,time_days,numerical)

if min(size(saturation))==1
    saturation=vectortomatrix(saturation,numerical);    
end

Mask=zeros(numerical.Nx,numerical.Ny);
block_frac=2;
Mask(block_frac+1:numerical.Nx-block_frac,:)=1;
block_V=Mask.*numerical.V*0.22;
Qw=sum(sum(saturation.*block_V))*28316.8;



plot_title=sprintf('Water Saturation Distribution at %d days', time_days); 

xmax=max(numerical.gridcenter_x)+0.5*max(max(numerical.dx));
%ymax=max(numerical.gridcenter_y)+0.5*max(max(numerical.dy));
ymid=ceil(numerical.Ny/2)+2;
s_line=saturation(:,ymid);

figure
run IEEEfigure.m
plot(numerical.gridcenter_x(:)*30.48,s_line(:))
xlim([0,xmax]*30.48);
ylim([0,1]);

title(plot_title);
xlabel('Reservoir Length in x-axis, cm')
ylabel('Saturation, mL/mL')      
set(gca,'linewidth',2);