function output=vectortomatrix(input,numerical)


NX=numerical.Nx;
NY=numerical.Ny;
output=sparse(NX,NY);

%output=reshape(input,[NX NY]);


for l=1:NX*NY;
    [i,j]=reverse_index(l,numerical);
    output(i,j)=input(l);
end


%V1 = X(:);
%V2 = reshape(X, 1, []);
%V3 = reshape(X, numel(X), 1);