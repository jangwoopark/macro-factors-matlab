clc;
[data text] = xlsread('GARCH.xls');
data = data(:,2);
data = 1+data;
data = log(data);
logreturns = diff(data);
%lagsACF = input('Enter number of lags for ACF and PACF \n')
lagsACF = 40;
[ACF, nLags, ACFBounds] = autocorr(logreturns, lagsACF);
subplot(2,1,1), bar(ACF(2:end))
title('ACF')
hold on
plot(nLags,ACFBounds(1),'or',nLags,ACFBounds(2),'or','MarkerSize',2)
[PACF, nPLags, PACFBounds] = parcorr(logreturns, lagsACF);
subplot(2,1,2), bar(PACF(2:end))
plot(nLags,ACFBounds(1),'or',nLags,ACFBounds(2),'or','MarkerSize',2)
hold on
plot(nPLags,PACFBounds(1),'or',nPLags,PACFBounds(2),'or','Markersize',2)

pend = input('Enter number of lags for P \n')
qend = input('Enter number of lags for Q \n')

for i = 1:pend
       if i==1
           p=[i];
       else
           p=[p i];
       end
   for j = 1:qend
           if j==1
           q = [j];
           else
           q=[q j];
           end
     [Coeff, LogLikeli, Errors, SEReg, Diag, VCVrob, VCV, Likeli,Scores] = armaxfilter(logreturns,0,p,q);
     AIC(i,j) = Diag.AIC;
   end
 clear q
end

AIC
minAIC = min(min(AIC));
sprintf('The minimum AIC is: %f', minAIC)

