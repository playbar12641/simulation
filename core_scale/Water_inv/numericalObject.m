classdef numericalObject
   properties
      Nx
      Ny
      dx
      dy
      dt
      gridcenter_x
      gridcenter_y
      V
      edges
   end
   
   methods
       function obj=firstdefault(obj,obj2)
          obj.Nx=52;
          obj.Ny=11;
          obj.dx=obj2.Lx/obj.Nx;
          obj.dy=obj2.Ly/obj.Ny;           
          obj.gridcenter_x=obj.dx.*(linspace(1,obj.Nx,obj.Nx)-1/2);  
          obj.gridcenter_y=obj.dy.*(linspace(1,obj.Ny,obj.Ny)-1/2);             
       end
       
       function obj=seconddefault(obj,obj2)
          obj.Nx=3;
          obj.Ny=3;
          obj.dx=obj2.Lx/obj.Nx;
          obj.dy=obj2.Ly/obj.Ny;           
          obj.gridcenter_x=obj.dx.*(linspace(1,obj.Nx,obj.Nx)-1/2);  
          obj.gridcenter_y=obj.dy.*(linspace(1,obj.Ny,obj.Ny)-1/2); 
           
       end
       
   end
end