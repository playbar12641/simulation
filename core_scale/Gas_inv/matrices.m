function [Tw,To,d11,d12,d21,d22,D]=matrices(numerical,reservoir)

%% defining reservoir edges
%edge=boundary_indexes(numerical); %obtain the single digit indexes for blocks at the left, right, top and bottom boundary
BC=reservoir.BC;

left_edge=numerical.edges.left;
right_edge=numerical.edges.right;
bottom_edge=numerical.edges.bottom;
top_edge=numerical.edges.top;


NX=numerical.Nx;
NY=numerical.Ny;

Tw=sparse(NX*NY,NX*NY);
To=sparse(NX*NY,NX*NY);
D=sparse(NX*NY,NX*NY);  
%Q=sparse(NX*NY,1);

d11=sparse(NX*NY,NX*NY);
d12=sparse(NX*NY,NX*NY);
d21=sparse(NX*NY,NX*NY);
d22=sparse(NX*NY,NX*NY);
%% the following code is based on the pseudo-coode from reservoir simulation text book
%% compute T matrix
for L=1:NX*NY
    
    [i,j]=reverse_index(L,numerical); %obtain the two digit index from l
    
    [d11c,d12c,d21c,d22c]=dcoefficients(i,j,numerical,reservoir);
         d11(L,L)=d11c;
         d12(L,L)=d12c;
         d21(L,L)=d21c;
         d22(L,L)=d22c;
     
     if not(ismember(L,left_edge))   %if the block is not on the left edge
         [Tw_half,To_half]=half_trans(L,L-1,numerical,reservoir);
         Tw(L,L-1)=-Tw_half;
         To(L,L-1)=-To_half;
         %T(L,L-1)=-half_trans(L,L-1,numerical,reservoir); %the halftrans is computed in horizontal direction                                
         Tw(L,L)=Tw(L,L)-Tw(L,L-1);
         To(L,L)=To(L,L)-To(L,L-1);
              
     elseif ismember(L,left_edge) && BC.left(1)==1   %if block is on the left edge and is a dirichelet condition
         [Tw_block,To_block]=BlockTrans(L,'horizontal',numerical,reservoir); %calculate the block transmissibility, block trans depend on the direction
         Tw(L,L)=Tw(L,L)+2*Tw_block;         
         To(L,L)=To(L,L)+2*To_block;  
         %Q(L)=2*Tblock*BC.left(2);
         %current code does not work with dirichelet BC
     elseif ismember(L,left_edge) && BC.left(1)==0  %if left edge is a neumann condition do nothing   
     end
     
     
     if not(ismember(L,right_edge)) %if the block is not on the right edge
         [Tw_half,To_half]=half_trans(L,L+1,numerical,reservoir);
         Tw(L,L+1)=-Tw_half;
         To(L,L+1)=-To_half;
         
         %T(L,L+1)=-half_trans(L,L+1,numerical,reservoir);
         Tw(L,L)=Tw(L,L)-Tw(L,L+1);
         To(L,L)=To(L,L)-To(L,L+1);
                
     elseif ismember(L,right_edge) && BC.right(1)==1 %if block is on the right edge and is a dirichelet condition
         [Tw_block,To_block]=BlockTrans(L,'horizontal',numerical,reservoir);
         Tw(L,L)=Tw(L,L)+2*Tw_block;         
         To(L,L)=To(L,L)+2*To_block;   
         %T(L,L)=T(L,L)+2*Tblock;
         %Q(L)=2*Tblock*BC.right(2);
     elseif ismember(L,right_edge) && BC.right(1)==0 %if right edge is a neumann condition do nothing   
     end
     
     if not(ismember(L,bottom_edge)) %if the block is not on the bottom edge
         [Tw_half,To_half]=half_trans(L,L-NX,numerical,reservoir); %half trans should be computed in vertical direction 
         Tw(L,L-NX)=-Tw_half;
         To(L,L-NX)=-To_half;         
         
         %T(L,L-NX)=-half_trans(L,L-NX,numerical,reservoir);
         Tw(L,L)=Tw(L,L)-Tw(L,L-NX);
         To(L,L)=To(L,L)-To(L,L-NX);
     elseif ismember(L,bottom_edge) && BC.bottom(1)==1
         [Tw_block,To_block]=BlockTrans(L,'vertical',numerical,reservoir);
         
         %Tblock=BlockTrans(L,'vertical',numerical,reservoir); %block trans is also in vertical direction         
         Tw(L,L)=Tw(L,L)+2*Tw_block;
         To(L,L)=To(L,L)+2*To_block;
         %Q(L)=2*Tblock*BC.bottom(2);
     elseif ismember(L,bottom_edge) && BC.bottom(1)==0
     end
     
     if not(ismember(L,top_edge)) %similar algorithm for bottom boundary
         [Tw_half,To_half]=half_trans(L,L+NX,numerical,reservoir);
         Tw(L,L+NX)=-Tw_half;
         To(L,L+NX)=-To_half;        
         %T(L,L+NX)=-half_trans(L,L+NX,numerical,reservoir);
         Tw(L,L)=Tw(L,L)-Tw(L,L+NX);
         To(L,L)=To(L,L)-To(L,L+NX);
         
         
     elseif ismember(L,top_edge) && BC.top(1)==1
         [Tw_block,To_block]=BlockTrans(L,'vertical',numerical,reservoir);
         %Tblock=BlockTrans(L,'vertical',numerical,reservoir);          
         Tw(L,L)=Tw(L,L)+2*Tw_block;
         To(L,L)=To(L,L)+2*To_block;
         %Q(L)=2*Tblock*BC.top(2);
     elseif ismember(L,top_edge) && BC.top(1)==0
     end
         %Q(L)=Q(L)+Q_well(L);
                
         D(L,L)=-d22c/d12c*d11c+d21c;
         %B(L,L)=numerical.V(i,j)*reservoir.fluid.ct*reservoir.porosity(i,j)/reservoir.fluid.B;
         
end


%d22overd12=spdiags(d22(:)./d12(:),0,NX*NY,NX*NY);




%%
%G=-reservoir.fluid.rho/144*T*reservoir.depthvector;