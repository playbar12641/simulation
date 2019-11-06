function [xindex,yindex]=wellpositionindex(x,y,numerical)


[c,xindex]=min(abs(x-numerical.gridcenter_x));

[c,yindex]=min(abs(y-numerical.gridcenter_y));