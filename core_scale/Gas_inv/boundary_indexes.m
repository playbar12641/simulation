function edges=boundary_indexes(numerical)
% this function returns the single digit index for the reservoir boundary
Nx=numerical.Nx;
Ny=numerical.Ny;

edges=boundarycondition;

%% bottom edge
j=1;
i=1:Nx;
edges.bottom=(j-1)*Nx+i;

%% top edge
j=Ny;
edges.top=(j-1)*Nx+i;


%% left edge
i=1;
j=1:Ny;
edges.left=(j-1)*Nx+i;

%% right edge
i=Nx;
j=1:Ny;
edges.right=(j-1)*Nx+i;


