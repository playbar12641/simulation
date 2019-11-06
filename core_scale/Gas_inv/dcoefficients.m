function [d11,d12,d21,d22]=dcoefficients(i,j,numerical,reservoir)

l=index(i,j,numerical);
Pcprime=0; %neglect capillary pressure for now
dt=numerical.dt;
Bw=reservoir.fluid.water.B;
Bo=reservoir.fluid.oil.B;

cw=reservoir.fluid.water.c;
co=reservoir.fluid.oil.c;

cf=reservoir.cf;

phi=reservoir.porosity(i,j);
Vi=numerical.V(i,j);

Sw=reservoir.Sw(l);
So=reservoir.So(l);

d11=Vi*Sw*phi/Bw/dt*(cf+cw);

d12=Vi*phi/dt/Bw*(1-Sw*phi*Pcprime);

d21=Vi*phi*So/Bo/dt*(cf+co);

d22=Vi/dt*(-1*phi/Bo);


