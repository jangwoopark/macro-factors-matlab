clc;
[num,text,raw]=xlsread('ppi.xls','ppi');
ppi = num(3:3:end,3);
subplot(2,3,1), plot(ppi)
deltappi = diff(ppi);
subplot(2,3,2), plot(deltappi)
logppi = log(ppi);
deltalogppi = diff(logppi);
subplot(2,3,3), plot(deltalogppi)
[ACF,lag, bound] = autocorr(deltalogppi,12);
pse= ones(13,1)*bound(1,1);
nse= ones(13,1)*bound(2,1);
acfwithse=[ACF pse nse];
subplot(2,3,4), bar(acfwithse)
[PartialAFC, lags, bounds] = parcorr(deltalogppi,12);
pses= ones(13,1)*bounds(1,1);
nses= ones(13,1)*bounds(2,1);
pacfwithse=[PartialAFC pses nses];
subplot(2,3,5), bar(pacfwithse)
%ddeltalogppi = diff(deltalogppi);
%subplot(4,4,4), plot(ddeltalogppi)
%[dACF, lag] = autocorr(ddeltalogppi,12);
%[dPartialAFC,lags] = parcorr(ddeltalogppi,12);
%subplot(4,4,7), bar(dACF)
%subplot(4,4,8), bar(dPartialAFC)

[PARAMETERS11, LL11, ERRORS11, SEREGRESSION11, DIAGNOSTICS11, VCVROBUST11, VCV11, LIKELIHOODS11, SCORES11] = armaxfilter(deltalogppi,1,[1 2],[1 2 3 4 5]);
[PARAMETERS12, LL12, ERRORS12, SEREGRESSION12, DIAGNOSTICS12, VCVROBUST12, VCV12, LIKELIHOODS12, SCORES12] = armaxfilter(deltalogppi,1,[1 2],[1 2 3 4 5 9 10 11]);
[PARAMETERS21, LL21, ERRORS21, SEREGRESSION21, DIAGNOSTICS21, VCVROBUST21, VCV21, LIKELIHOODS21, SCORES21] = armaxfilter(deltalogppi,1,[1 2 9],[1 2 3 4 5]);
[PARAMETERS22, LL22, ERRORS22, SEREGRESSION22, DIAGNOSTICS22, VCVROBUST22, VCV22, LIKELIHOODS22, SCORES22] = armaxfilter(deltalogppi,1,[1 2 9],[1 2 3 4 5 9 10 11]);

[arroots11, absarroots11] = armaroots(PARAMETERS11, 1, [1 2], [1 2 3 4 5]);
[arroots12, absarroots12] = armaroots(PARAMETERS12, 1, [1 2], [1 2 3 4 5 9 10 11]);
[arroots21, absarroots21] = armaroots(PARAMETERS21, 1, [1 2 9], [1 2 3 4 5]);
[arroots22, absarroots22] = armaroots(PARAMETERS22, 1, [1 2 9], [1 2 3 4 5 9 10 11]);

%[h810,pValue810,Qstat810,cValue810] = lbqtest(ERRORS10,8,0.05,8);
%[h1210,pValue1210,Qstat1210,cValue1210] = lbqtest(ERRORS10,12,0.05,12);
%[h820,pValue820,Qstat820,cValue820] = lbqtest(ERRORS20,8,0.05,8);
%[h1220,pValue1220,Qstat1220,cValue1220] = lbqtest(ERRORS20,12,0.05,12);
%[h801,pValue801,Qstat801,cValue801] = lbqtest(ERRORS01,8,0.05,8);
%[h1201,pValue1201,Qstat1201,cValue1201] = lbqtest(ERRORS01,12,0.05,12);
%[h802,pValue802,Qstat802,cValue802] = lbqtest(ERRORS02,8,0.05,8);
%[h1202,pValue1202,Qstat1202,cValue1202] = lbqtest(ERRORS02,12,0.05,12);

[h811,pValue811,Qstat811,cValue811] = lbqtest(ERRORS11,8,0.05,8);
[h1211,pValue1211,Qstat1211,cValue1211] = lbqtest(ERRORS11,12,0.05,12);
[h812,pValue812,Qstat812,cValue812] = lbqtest(ERRORS12,8,0.05,8);
[h1212,pValue1212,Qstat1212,cValue1212] = lbqtest(ERRORS12,12,0.05,12);
[h821,pValue821,Qstat821,cValue821] = lbqtest(ERRORS21,8,0.05,8);
[h1221,pValue1221,Qstat1221,cValue1221] = lbqtest(ERRORS21,12,0.05,12);
[h822,pValue822,Qstat822,cValue822] = lbqtest(ERRORS22,8,0.05,8);
[h1222,pValue1222,Qstat1222,cValue1222] = lbqtest(ERRORS22,12,0.05,12);

ppi2 = num(3:3:645,3);
%subplot(4,3,7), plot(ppi2)
deltappi2 = diff(ppi2);
%subplot(4,3,8), plot(deltappi2)
logppi2 = log(ppi2);
deltalogppi2 = diff(logppi2);
%subplot(4,3,9), plot(deltalogppi2)
%[ACF2] = autocorr(deltalogppi2,12);
%subplot(4,3,10), bar(ACF2)
%[PartialACF2] = parcorr(deltalogppi2,12);
%subplot(4,3,11), bar(PartialACF2)
%ddeltalogppi2 = diff(deltalogppi2);
%subplot(4,4,12), plot(ddeltalogppi2)
%[dACF2, lag2] = autocorr(ddeltalogppi2,12);
%[dPartialAFC2,lags2] = parcorr(ddeltalogppi2,12);
%subplot(4,4,15), bar(dACF2)
%subplot(4,4,16), bar(dPartialACF2)

[PARAMETERS112, LL112, ERRORS112, SEREGRESSION112, DIAGNOSTICS112, VCVROBUST112, VCV112, LIKELIHOODS112, SCORES112] = armaxfilter(deltalogppi2,1,[1 2],[1 2 3 4 5]);
[PARAMETERS122, LL122, ERRORS122, SEREGRESSION122, DIAGNOSTICS122, VCVROBUST122, VCV122, LIKELIHOODS122, SCORES122] = armaxfilter(deltalogppi2,1,[1 2],[1 2 3 4 5 9 10 11]);
[PARAMETERS212, LL212, ERRORS212, SEREGRESSION212, DIAGNOSTICS212, VCVROBUST212, VCV212, LIKELIHOODS212, SCORES212] = armaxfilter(deltalogppi2,1,[1 2 9],[1 2 3 4 5]);
[PARAMETERS222, LL222, ERRORS222, SEREGRESSION222, DIAGNOSTICS222, VCVROBUST222, VCV222, LIKELIHOODS222, SCORES222] = armaxfilter(deltalogppi2,1,[1 2 9],[1 2 3 4 5 9 10 11]);

[arroots112, absarroots112] = armaroots(PARAMETERS112, 1, [1 2], [1 2 3 4 5]);
[arroots122, absarroots122] = armaroots(PARAMETERS122, 1, [1 2], [1 2 3 4 5 9 10 11]);
[arroots212, absarroots212] = armaroots(PARAMETERS212, 1, [1 2 9], [1 2 3 4 5]);
[arroots222, absarroots222] = armaroots(PARAMETERS222, 1, [1 2 9], [1 2 3 4 5 9 10 11]);

% forecasting
lt = length(deltalogppi);
lr = length(deltalogppi2);
ltr = length(deltalogppi)-length(deltalogppi2);

[yhattph11,yhat11,forerr11,ystd11]=arma_forecaster(deltalogppi,PARAMETERS112,1,[1 2],[1 2 3 4 5],lr,1,SEREGRESSION112);
[yhattph12,yhat12,forerr12,ystd12]=arma_forecaster(deltalogppi,PARAMETERS122,1,[1 2],[1 2 3 4 5 9 10 11],lr,1,SEREGRESSION122);
[yhattph21,yhat21,forerr21,ystd21]=arma_forecaster(deltalogppi,PARAMETERS212,1,[1 2 9],[1 2 3 4 5],lr,1,SEREGRESSION212);
[yhattph22,yhat22,forerr22,ystd22]=arma_forecaster(deltalogppi,PARAMETERS222,1,[1 2 9],[1 2 3 4 5 9 10 11],lr,1,SEREGRESSION222);

er25=sum(forerr11(215:end-1).^2)/ltr
er211=sum(forerr12(215:end-1).^2)/ltr
er95=sum(forerr21(215:end-1).^2)/ltr
er911=sum(forerr22(215:end-1).^2)/ltr

nopredict=ones(31,1)*deltalogppi(214);
noer=deltalogppi(215:end-1)-nopredict;
noerss=sum(noer.^2)/ltr


