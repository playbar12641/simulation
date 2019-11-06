function output=matrixtovector(input,numerical)

NX=numerical.Nx;
NY=numerical.Ny;

output=sparse(NX*NY,1);

%output=input(:);


for j=1:NY 
  for i=1:NX
      output(index(i,j,numerical))=input(i,j);
  end
end