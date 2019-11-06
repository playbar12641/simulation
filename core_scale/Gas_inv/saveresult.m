function [saved]=saveresult(time,result,numerical,saved)

timeD=[1 2 3 1000];

    
    if any(abs(time-timeD)<0.5*numerical.dt)
    result.time=time;
    
    %result.P=vectortomatrix(result.P,numerical); 
    %pressureplot(result.P,time_days,numerical) 
    
    saved=[saved result];
    
    end
    



end   