function well_info=wellproductivity(well_info,numerical,reservoir)


miuw=reservoir.fluid.water.miu;
miuo=reservoir.fluid.oil.miu;
Bo=reservoir.fluid.oil.B;
Bw=reservoir.fluid.water.B;


% get values for Kx, Ky, Kz, h for all well locations
Kx=reservoir.Kx(sub2ind(size(reservoir.Kx),well_info.xindex,well_info.yindex));
Ky=reservoir.Ky(sub2ind(size(reservoir.Ky),well_info.xindex,well_info.yindex));
Kz=reservoir.Kz(sub2ind(size(reservoir.Kz),well_info.xindex,well_info.yindex));
h=reservoir.thickness(sub2ind(size(reservoir.thickness),well_info.xindex,well_info.yindex));

dx=numerical.dx;
dy=numerical.dy;

Jw=zeros(1,length(Kx));
Jo=zeros(1,length(Kx));

H_Jsumw=0;
H_Jsumo=0;

for i=1:length(Kx)
    xi=well_info.xindex(i);
    yi=well_info.yindex(i);
    l=index(xi,yi,numerical);
    Sw=reservoir.Sw(l);
    So=reservoir.So(l);
    krw=waterrelperm(Sw,reservoir);
    kro=oilrelperm(So,reservoir);
    
    if strcmp(well_info.orientation(i),'V') %&& strcmp(well_info.type(i),'CP')
        %calculate productivity for vertical well
        ratio=Ky(i)/Kx(i);
        over1=sqrt(sqrt(ratio)*dx^2+sqrt(1/ratio)*dy^2);
        under1=nthroot(ratio,4)+nthroot(1/ratio,4);
       
        Req=0.28*over1/under1;
        rw=well_info.rw(i);
        s=well_info.skin(i);
                
        over2=2*pi*h(i)*sqrt(Kx(i)*Ky(i));
        under2w=miuw*Bw*(log(Req/rw)+s);
        under2o=miuo*Bo*(log(Req/rw)+s);
        Jw(i)=6.33e-3*over2/under2w*krw;
        Jo(i)=6.33e-3*over2/under2o*kro;
        
    elseif strcmp(well_info.orientation(i),'H1')
        % for horizontal well, need productivity regardless of CR or CP
        ratio=Kz(i)/Ky(i);
        over1=sqrt(sqrt(ratio)*dy^2+sqrt(1/ratio)*h(i)^2);
        under1=nthroot(ratio,4)+nthroot(1/ratio,4);
        
        Req=0.28*over1/under1;
        
        rw=well_info.rw(i);
        s=well_info.skin(i);
        
        over2=2*pi*dx*sqrt(Ky(i)*Kz(i));
        under2w=miuw*Bw*(log(Req/rw)+s);
        under2o=miuo*Bo*(log(Req/rw)+s);
               
        Jw(i)=6.33e-3*over2/under2w*krw;       
        Jo(i)=6.33e-3*over2/under2o*kro; 
       
        H_Jsumw= H_Jsumw+Jw(i);
        H_Jsumo= H_Jsumo+Jo(i);
    else

    end
end

% calculates the flow rate for the horizontal wells with constant rate 
% for i=1:length(Kx)
%     if strcmp(well_info.orientation(i),'H1') && strcmp(well_info.type(i),'CR')
%        well_info.rate(i)=well_info.rate(i)*productivity(i)/H_Jsum;
%     end
% end


well_info.Jw=Jw;
well_info.Jo=Jo;



       