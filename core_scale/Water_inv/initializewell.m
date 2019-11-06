function well_info=initializewell(numerical,reservoir)


%rw=0.2; %in ft, constant wellbore radius
% first add vertical wells, there are 5 vertical wells
dx=numerical.dx;
nx=numerical.Nx;
dy=numerical.dy;
ny=numerical.Ny;

rw=sqrt(dy/2*dx/2);

well_info=wellObject;
well_info.x=[dx/2 dx/2   dx/2   nx*dx-dx/2]; %a injection well at x=0, and producer well at x=reservoir length
well_info.y=[1*dy-dy/2 (ceil(ny/2)-0.5)*dy  (ny-0.5)*dy  (ceil(ny/2)-0.5)*dy];
well_info.rw=rw*ones(1,length(well_info.x));                   %wellbore radius
well_info.orientation={'V','V','V','V'};


%5.61458333
well_info.type={'CP','CR','CP','CP'};
well_info.rate=[nan 0.102/5.61 nan nan]*5.61458333; %convert bbl/day to cubic ft/day
well_info.BHP=[20 nan 20 0]+reservoir.temp;
well_info.skin=zeros(1,length(well_info.x)); 

for i=1:length(well_info.x)
     [well_info.xindex(i),well_info.yindex(i)]=wellpositionindex(well_info.x(i),well_info.y(i),numerical); 
end
% initialize productivity for vertical constant pressure well, and
% horizontal wells
well_info=wellproductivity(well_info,numerical,reservoir);