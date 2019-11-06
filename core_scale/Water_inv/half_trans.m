function [T_halfw,T_halfo]=half_trans(l1,l2,numerical,reservoir)
%the input will be single index

Nx=numerical.Nx;

%% obtain double indexes from single index
[i1,j1]=reverse_index(l1,numerical);
[i2,j2]=reverse_index(l2,numerical);

if abs(abs(l1-l2)-Nx)<0.1 %if the two index are differ by Nx, then the transmissiblity is calculated along y direction
    k1=reservoir.Ky(i1,j1);
    k2=reservoir.Ky(i2,j2);
    A1=numerical.dx*reservoir.thickness(i1,j1); %along y direction, cross section area is dx*h
    A2=numerical.dx*reservoir.thickness(i1,j2);
    d=numerical.dy;
else    % otherwise the transmissiblity is calculated along x direction
    k1=reservoir.Kx(i1,j1);
    k2=reservoir.Kx(i2,j2);
    A1=numerical.dy*reservoir.thickness(i1,j1);%along x direction, cross section area is dy*h
    A2=numerical.dy*reservoir.thickness(i1,j2);
    d=numerical.dx;
end
    
%% upwinding for oil part without gravity and Pc:

P1=reservoir.pressure(l1);
P2=reservoir.pressure(l2);
 
if P1>=P2;
    Sw=reservoir.Sw(l1);
    So=reservoir.So(l1);
    %P=P1;
else
    Sw=reservoir.Sw(l2);
    So=reservoir.So(l2);
    %P=P2;
end

krw=waterrelperm(Sw,reservoir);
kro=oilrelperm(So,reservoir);

miuo=reservoir.fluid.oil.miu;
miuw=reservoir.fluid.water.miu;
Bo=reservoir.fluid.oil.B;
Bw=reservoir.fluid.water.B;

temp2=2*k1*A1*k2*A2/(k1*A1*d+k2*A2*d)*6.33e-3;

T_halfw=krw/miuw/Bw*temp2;

T_halfo=kro/miuo/Bo*temp2;

%T_half=(1/(reservoir.fluid.miu*reservoir.fluid.B))*2*k1*A1*k2*A2/(k1*A1*d+k2*A2*d);
        
%T_half=T_half*6.33e-3;
    