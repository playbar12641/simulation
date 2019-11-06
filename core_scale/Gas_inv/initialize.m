function [numerical,reservoir,well_info]=initialize()
% initialize for problem 2


relperm=default(relpermObject);

oil=seconddefault(oilpropertyObject);
water=seconddefault(waterpropertyObject);


fluid.oil=oil;
fluid.water=water;


reservoir=seconddefault(reservoirObject);
reservoir.Lx=0.886;
reservoir.Ly=0.125;

numerical=firstdefault(numericalObject,reservoir);

Nx=numerical.Nx;
Ny=numerical.Ny;

reservoir.porosity=0.22*(ones(Nx,Ny));
K_res=10; %in mD
K_frac=1e6; % fracture permeability 1000D 
frac_block=2; %the width of the fracture zone is 2 grid block
K=K_res*(ones(Nx,Ny));
K(1:frac_block,:)=K_frac;
K(Nx-frac_block+1:Nx,:)=K_frac;

%reservoir.Kx=K_res*(ones(Nx,Ny));
reservoir.Kx=K;
reservoir.Ky=reservoir.Kx;
reservoir.Kz=reservoir.Kx;

reservoir.thickness=0.0982*(ones(Nx,Ny)); %thickness in ft
numerical.V=reservoir.thickness*numerical.dx*numerical.dy;

reservoir.temp=615;
reservoir.pressure=reservoir.temp*(ones(Nx,Ny));
reservoir.Sw=0*(ones(Nx,Ny));
reservoir.So=1-reservoir.Sw;

reservoir.fluid=fluid;
%% specify boundary conditions
% first element denotes boundary type, 0 for neumann, 1 for dirichelet
% section element denotes the boundary pressure, for a neumann boundary,
% use nan

BC.top   =[0  nan];
BC.bottom=[0  nan];
BC.left  =[0  nan];
BC.right =[0  nan];

reservoir.BC=BC;

%% defining reservoir edges
edge=boundary_indexes(numerical); %obtain the single digit indexes for blocks at the left, right, top and bottom boundary
numerical.edges=edge;

reservoir.relperm=relperm;

reservoir.cf=3e-6;

%% initialize wells
well_info=initializewell(numerical,reservoir);
%well_info=wellproductivity(well_info,numerical,reservoir);

