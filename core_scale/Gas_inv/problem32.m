

Grid.ymin=0;
Grid.ymax=1200;
Grid.Ny=3; 

Grid.xmin=0;
Grid.xmax=1200;
Grid.Nx=3;

[Grid]=build_grid(Grid);

[D,G,I]=build_ops(Grid);

spy(D*G);