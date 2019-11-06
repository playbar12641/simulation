function [i,j]=reverse_index(l,numerical)

Nx=numerical.Nx;

i=mod(l,Nx);

if i==0
   i=Nx;
end

j=(l-i)/Nx+1;
