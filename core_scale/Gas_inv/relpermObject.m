classdef relpermObject
   properties
   Swr
   Sor
   nw
   no
   koep
   kwep
   
   end
   methods 
       function obj=default(obj)
%        obj.Swr=0.35;
%        obj.Sor=0.42;
%        obj.nw=3;
%        obj.no=2;
%        obj.koep=1;
%        obj.kwep=0.08;
       
       obj.Swr=0.15;
       obj.Sor=0.7;
       obj.nw=1;
       obj.no=2;
       obj.koep=1;
       obj.kwep=0.8;


   end
   end
end