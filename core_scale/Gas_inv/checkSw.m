function reservoir=checkSw(Sw,reservoir)

Swmax=1-reservoir.relperm.Sor; %this is a theoretical maximum water saturation

%depth=reservoir.depthvector; %

%Sw(depth>reservoir.WOC)=-999; 

Sw(Sw>Swmax)=Swmax-0.001;
Sw(Sw<-0.0005)=0.0001;

reservoir.Sw=Sw;

