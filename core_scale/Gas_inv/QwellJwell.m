function [Qw,Qw2,Qo,Qo2,Jw,Jo]=QwellJwell(wells,numerical,reservoir)
% Q matrix includes, 1. sourse term for CR wells, 2. a J*Pwf term for CP
% well 3. Boundary conditions
% Qw is a matrix term and Qw2 is the actual rate, they may differ
% Q_well contain  the first 2 

NX=numerical.Nx;
NY=numerical.Ny;


Qw=sparse(NX*NY,1);
Qo=Qw;
Qw2=Qw;
Jw=sparse(NX*NY,NX*NY);
Jo=Jw;


for i=1:length(wells.x)
    xi=wells.xindex(i);
    yi=wells.yindex(i);
    l=index(xi,yi,numerical);
    
    if strcmp(wells.type(i),'CR')
    
    if wells.rate(i)>0;    
    % if well is a injection well, all injected is water
    Qw(l)=wells.rate(i);
    Qw2(l)=Qw(l);
   
    else
        Sw=reservoir.Sw(l);
        So=reservoir.So(l);
        miuo=reservoir.fluid.oil.miu;
        miuw=reservoir.fluid.water.miu;
        Bw=reservoir.fluid.water.B;
        Bo=reservoir.fluid.oil.B;
        
        kro=oilrelperm(So,reservoir);
        krw=waterrelperm(Sw,reservoir);
        fw=(krw/miuw/Bw)/(krw/miuw/Bw+kro/miuo/Bo);
       
    Qw(l)=fw*wells.rate(i);
    Qw2(l)=Qw(l);
    Qo(l)=(1-fw)*wells.rate(i);
    
    end
    
    end
    
    if strcmp(wells.type(i),'CP')
    % for constant BHP well, update J with productivity and Q_well with
    % J*Pwf
    Jw(l,l)=wells.Jw(i);
    Jo(l,l)=wells.Jo(i);
    Qw(l)=Jw(l,l)*wells.BHP(i);
    Qo(l)=Jo(l,l)*wells.BHP(i);
    Qw2(l)=-Jw(l,l)*(reservoir.pressure(l)-wells.BHP(i));
    Qo2(l)=-Jo(l,l)*(reservoir.pressure(l)-wells.BHP(i));
    end
end
    
    