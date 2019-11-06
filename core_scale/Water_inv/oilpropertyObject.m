classdef oilpropertyObject
   properties
      miu
      B
      c
      rho
   end
   methods 
       function obj=firstdefault(obj)
           obj.miu=1;
           obj.B=1;
           obj.c=1e-5;
           obj.rho=64.4; % density in lb/cft   
       end
       
       function obj=seconddefault(obj)
           obj.miu=5;
           obj.B=1;
           obj.c=5e-6;
           obj.rho=64.4;
           
       end
   end
end