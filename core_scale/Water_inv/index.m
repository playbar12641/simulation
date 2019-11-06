function l=index(i,j,Numerical)
%compute the one dimensional index l based on two dimensional index (i,j)

l=(j-1)*Numerical.Nx+i;