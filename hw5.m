clc;
[data,text] = xlsread('GARCH.xls');
vwretd = data(:,2);
vwretd1 =vwretd+1;
logvwretd = log(vwretd1);
[ACF,lag, bound] = autocorr(logvwretd,40);
[PartialACF, lags, bounds] = parcorr(logvwretd,40);
dlogvwretd = diff(logvwretd);
[dACF,dlag, dbound] = autocorr(dlogvwretd,40);
[dPartialACF, dlags, dbounds] = parcorr(dlogvwretd,40);

t=5;
r=2;

subplot(t,r,1), plot(logvwretd)
subplot(t,r,2), plot(dlogvwretd)
subplot(t,r,3), bar(ACF(2:40)); 
line([0,40],[bound(1,1),bound(1,1)]);
line([0,40],[bound(2,1),bound(2,1)]);
subplot(t,r,4), bar(PartialACF(2:40))
line([0,40],[bounds(1,1),bounds(1,1)]);
line([0,40],[bounds(2,1),bounds(2,1)]);
subplot(t,r,5), bar(dACF(2:40))
line([0,40],[dbound(1,1),dbound(1,1)]);
line([0,40],[dbound(2,1),dbound(2,1)]);
subplot(t,r,6), bar(dPartialACF(2:40))
line([0,40],[dbounds(1,1),dbounds(1,1)]);
line([0,40],[dbounds(2,1),dbounds(2,1)]);

[PARAMETERS11, LL11, ERRORS11, SEREGRESSION11, DIAGNOSTICS11, VCVROBUST11, VCV11, LIKELIHOODS11, SCORES11] = armaxfilter(dlogvwretd,1,1,1);
[PARAMETERS12, LL12, ERRORS12, SEREGRESSION12, DIAGNOSTICS12, VCVROBUST12, VCV12, LIKELIHOODS12, SCORES12] = armaxfilter(dlogvwretd,1,1,[1 2]);
[PARAMETERS21, LL21, ERRORS21, SEREGRESSION21, DIAGNOSTICS21, VCVROBUST21, VCV21, LIKELIHOODS21, SCORES21] = armaxfilter(dlogvwretd,1,[1 2],1);
[PARAMETERS22, LL22, ERRORS22, SEREGRESSION22, DIAGNOSTICS22, VCVROBUST22, VCV22, LIKELIHOODS22, SCORES22] = armaxfilter(dlogvwretd,1,[1 2],[1 2]);

error12=ERRORS12.^2;

[LM,PVAL] = lmtest1(error12,5);
[H, P, Qstat, CV] = lbqtest(error12, [1 2 3 4 5]', 0.05);

[gACF,glag, gbound] = autocorr(error12,40);
[gPartialACF, glags, gbounds] = parcorr(error12,40);

subplot(t,r,7), bar(gACF(2:40))
line([0,40],[gbound(1,1),gbound(1,1)]);
line([0,40],[gbound(2,1),gbound(2,1)]);
subplot(t,r,8), bar(gPartialACF(2:40))
line([0,40],[gbounds(1,1),gbounds(1,1)]);
line([0,40],[gbounds(2,1),gbounds(2,1)]);

derror12=diff(error12);
[dgACF,dglag, dgbound] = autocorr(derror12,40);
[dgPartialACF, dglags, dgbounds] = parcorr(derror12,40);

subplot(t,r,9), bar(dgACF(2:40));
line([0,40],[dgbound(1,1),gbound(1,1)]);
line([0,40],[dgbound(2,1),gbound(2,1)]);
subplot(t,r,10), bar(dgPartialACF(2:40));
line([0,40],[dgbounds(1,1),dgbounds(1,1)]);
line([0,40],[dgbounds(2,1),dgbounds(2,1)]);

Spec = garchset('p',1,'q',1);
[Coeff,Errors,LLF,Innovations,Sigmas,Summary] = garchfit(Spec,derror12);

[gLM,gPVAL] = lmtest1(Innovations,5);
[gH, gP, gQstat, gCV] = lbqtest(Innovations, [1 2 3 4 5]', 0.05);

