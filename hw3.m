clc
clear all;
[data,text] = xlsread('dataps3_update.xlsx','CISDM');
[hft,text2] = xlsread('dataps3_update.xlsx','factors');
factors = [hft(:,2:4) hft(:,6:7)];
r=hft(:,1);
[vw, CRSP] = xlsread('CRSP.xls');
n=15;
h=zeros(n,1);
pVal=zeros(n,1);
pVal1=zeros(n,1);
stat=zeros(n,1);
cValue=zeros(n,1);



count = 1;
for j=1:2:30
    for i=1:length(data)
        temp = data(:,j);
        if(isnan(temp(i)))
            stop = i+1;
        end
    end
    newdata = temp(stop:end);
k=(j+1)/2;
    [ACF, lags] = autocorr(newdata,12);
    [h(k,1),pVal(k,1),stat(k,1),cValue(k,1)] = lbqtest(newdata,12,0.05,12);
    subplot(4,4,count), bar(ACF) 
    title(text(1,j+1));
    count = count+1;
  
end



    [ACF, lags] = autocorr(vw,12);
    [hc,pValc,statc,cValuec] = lbqtest(vw,12,0.05,12);
    subplot(4,4,16), bar(ACF)
    title('CRSP-VW');
    

    %Linear Hedge Fund Clones
    
   
%    A=[1 1 1 1 1];
%    b=1;
%    Beta= lsqlin(factors,r,[],[],A,b)
%    
%    T=length(r)
%    rstar=factors*Beta;
%    rvar=var(r);
%    rstarvar=var(rstar);
%    gamma=sqrt(var(r))/sqrt(var(rstar))
%    rhat=gamma*rstar
   
    irr=getr(r, factors);
counter=1;
    factors2 = [hft(36:end,2:4) hft(36:end,6:7)];
for j=1:2:30
    for i=1:length(data)
        temp = data(:,j);
        if(isnan(temp(i)))
            stop = i+1;
        end
    end
    newdata = temp(stop:end);
    independ=factors2(stop+1:end,:);
    disp('This is the betas for clone of')
    x=text(1,j+1)
    %sprintf('This is %s ',x)
    rhat=getr(newdata, independ);
    
    k=(j+1)/2;
    [ACF, lags] = autocorr(rhat,12);
    [h(k,1),pVal1(k,1),stat(k,1),cValue(k,1)] = lbqtest(rhat,12,0.05,12);
    subplot(4,4,counter), bar(ACF) 
    title(text(1,j+1));
    counter = counter+1;
    
end

