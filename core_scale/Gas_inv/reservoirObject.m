classdef reservoirObject
   properties
       Kx
       Ky
       Kz
       Lx
       Ly
       porosity
       thickness
       depth
       pressure
       fluid
       depthvector
       Sw
       So
       BC
       relperm
       cf
       temp
   end
   methods 
       function obj=defaultdimension(obj)
           obj.Lx=1000; %reservoir length in ft
           obj.Ly=100;  %reservoir width         
       end
       
       function obj=seconddefault(obj)
          obj.Lx=1040;
          obj.Ly=220;
           
       end

   end
end