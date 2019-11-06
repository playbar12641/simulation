clc
close all
clear all 
tic

[numerical,reservoir,well_info]=initialize();

reservoir.fluid.oil.miu=0.4;
reservoir.fluid.water.miu=1;


Pold=matrixtovector(reservoir.pressure,numerical);
reservoir.pressure=Pold;
Swold=matrixtovector(reservoir.Sw,numerical);
reservoir.Sw=Swold;
result=results;
savedresult=ObjectArray.empty;

t=0; %starting time at 
nt=250; %number of time steps
tfinal=0.1042/1; %days
dt=tfinal/nt; %time step of in day
plottime=linspace(0,nt,8)*dt;

numerical.dt=dt;
while t<tfinal
    t=t+dt;
      
    [Tw,To,d11,d12,d21,d22,D]=matrices(numerical,reservoir);
    d22overd12=d12\d22;
    [Q_inv,Qw2,Qo,Qo2,Jw,Jo]=QwellJwell(well_info,numerical,reservoir);
    
    T=-d22overd12*Tw+To;
    J=-d22overd12*Jw+Jo;
    Q=-d22overd12*Q_inv+Qo;
    
    Pnew=(T+J+D)\(D*Pold+Q);
    
    Swnew=Swold+d12\(-d11*(Pnew-Pold)+Qw2-Tw*Pnew);
    
    %Swnew=Swold+d12\(-1*Tw*Pnew+Qw);
    reservoir.pressure=Pnew;
    %reservoir.Sw=Swnew;
    reservoir=checkSw(Swnew,reservoir);
    Swnew=reservoir.Sw;
    reservoir.So=1-reservoir.Sw;
    
    well_info=wellproductivity(well_info,numerical,reservoir);
    
    Pold=Pnew;
    Swold=Swnew;
    result.time=t;
    result.P=Pnew;
    result.Sw=Swnew;
    [savedresult,well_info]=saveresult_new(t,result,well_info,numerical,savedresult,Qw2,Qo2); 
end

toc

% time_days=0;
% 
% pressureplot(reservoir.pressure,time_days,numerical,'water')
% saturationplot(reservoir.Sw,time_days,numerical,'water')

%% plot pressure and saturation at a specific time
id=2;
Q_inv=0*plottime;
n=length(savedresult);
for i=1:n
    time_days=savedresult(i).Value.time;
       if any(abs(time_days-plottime)<0.5*numerical.dt)
       P=savedresult(i).Value.P;
       Sw=savedresult(i).Value.Sw;   
       %pressureplot(P,time_days,numerical,'water') 
       p_line_plot(P,time_days,numerical)
       %saturationplot(Sw,time_days,numerical,'water')       
       V_inv=s_line_plot(Sw,time_days,numerical);
       Q_inv(id)=V_inv;%*(reservoir.Ly*30.48)^2*(reservoir.Lx*30.48); % amount of water invaded in mL 
       id=id+1;
       end
end


plottime_min=plottime*24*60;
[fit_inv,cap_inv,xc_inv,yc_inv]=fitfunction(Q_inv,plottime_min);

figure
run IEEEfigure.m
h(1)=plot(fit_inv,'--b');
hold on;
h(2)=plot(Q_inv,plottime_min,'ob');
text(xc_inv,0.9*yc_inv,cap_inv);

hold off

ylabel('Invasion time (min)');
xlabel('Amount of water/gas invaded (mL)');
legend('fit','data');
set(gca,'linewidth',2);


