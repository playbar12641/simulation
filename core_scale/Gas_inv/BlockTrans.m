function [BlockTwater,BlockToil]=BlockTrans(L,direction,numerical,reservoir)
%% this function compute the block transmissibility
[i,j]=reverse_index(L,numerical);

if strcmp(direction,'horizontal')
    K=reservoir.Kx(i,j);
    A=numerical.dy*reservoir.thickness(i,j);
    d=numerical.dx;

elseif strcmp(direction,'vertical')
    K=reservoir.Ky(i,j);
    A=numerical.dx*reservoir.thickness(i,j);
    d=numerical.dy;       
else
    fpritnf('\nError in BlockTrans\n');
end 

Sw=reservoir.Sw(L);
So=reservoir.So(L);

krw=waterrelperm(Sw,reservoir);
kro=oilrelperm(So,reservoir);

miuo=reservoir.fluid.oil.miu;
miuw=reservoir.fluid.water.miu;
Bo=reservoir.fluid.oil.B;
Bw=reservoir.fluid.water.B;

BlockTwater=krw/miuw/Bw*K*A/d*6.33e-3;
BlockToil=kro/miuo/Bo*K*A/d*6.33e-3;

%out=1/(reservoir.fluid.miu*reservoir.fluid.B)*K*A/d;
%out=out*6.33e-3;