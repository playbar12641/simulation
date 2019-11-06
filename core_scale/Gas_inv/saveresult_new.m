function [saved,wellinfo]=saveresult_new(time_days,result,wellinfo,numerical,saved,Qw2,Qo2)

Plimit=-2;
%time=[100 500 750 1000];

result.wellratewater=zeros(1,length(wellinfo.x));
result.wellrateoil=zeros(1,length(wellinfo.x));
result.wellBHP=zeros(1,length(wellinfo.x));


result.time=time_days;
   

    for i=1:length(wellinfo.x)
        xi=wellinfo.xindex(i);
        yi=wellinfo.yindex(i);
        l=index(xi,yi,numerical);
       
        
        if strcmp(wellinfo.type(i),'CR') %calculate the water oil rate and BHP for constant 
            Pw=result.P(l);
            Po=result.P(l);
            Jw=wellinfo.Jw(i);
            Jo=wellinfo.Jo(i);
            result.wellratewater(i)=Qw2(l);
            result.wellrateoil(i)=Qo2(l);
            %result.wellBHP(i)=result.wellrate(i)/wellinfo.productivity(i)+Pb;           
            %fprintf('\n CR calculation loop\n');
            %result.wellBHP(i)=result.wellratewater(i)/Jw+Pw;
            result.wellBHP(i)=(Jw*Pw+Jo*Po+(Qw2(l)+Qo2(l)))/(Jw+Jo);
            
        end
        
        if result.wellBHP(i)<Plimit              
                result.wellBHP(i)=Plimit;
                wellinfo.type(i)={'CP'};
                %wellinfo.rate(i)=nan;
                %fprintf('\n smaller than Plimit check\n');
                wellinfo.BHP(i)=Plimit;              
        end
        
        if strcmp(wellinfo.type(i),'CP') %calculate the water oil rate for constant BHP well
            %fprintf('\n CP  loop\n');
            result.wellBHP(i)=wellinfo.BHP(i);
            result.wellratewater(i)=Qw2(l);
            result.wellrateoil(i)=Qo2(l);
        end
        
        
        
        
    end
    
    
    %result.wellBHP
%     result.wellBHP=[result.wellBHP(1:cutoff1-1) H1BHP H2BHP result.wellBHP(cutoff2+1:end)];
%     result.wellratewater=[result.wellratewater(1:cutoff1-1) H1waterrate H2waterrate result.wellratewater(cutoff2+1:end)];
%     result.wellrateoil=[result.wellrateoil(1:cutoff1-1) H1oilrate H2oilrate result.wellrateoil(cutoff2+1:end)];

saved=[saved result];

end   