function [rhat ] = getr( inreturns, factors )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(inreturns);
[m,n]=size(factors);
    A=[1 1 1 1 1];
    b=1;
    Beta= lsqlin(factors,inreturns,[],[],A,b)
    
    T=length(inreturns);
    rstar=factors*Beta;
    rvar=var(inreturns);
    rstarvar=var(rstar);
    gamma=sqrt(var(inreturns))/sqrt(var(rstar));
    rhat=gamma*rstar;
    mrhat= mean(rhat)
    mr=mean(inreturns)
end

