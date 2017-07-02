clc;
[num, text] = xlsread('factors.xls', 'factors_globalfinancialdata');
[num2, text2] = xlsread('factors.xls', 'factors_crsp');

I=num2(2:end,5);
MP=num2(2:end,6);

[ACF_I,lag_I,bound_I]=autocorr(I,60);
[PACF_I,plag_I,pbound_I]=parcorr(I,60);

[ACF_MP,lag_MP,bound_MP]=autocorr(MP,60);
[PACF_MP,plag_MP,pbound_MP]=parcorr(MP,60);

l=4;
k=2;

subplot(l,k,1);
bar(ACF_I(2:end,1));
line([0,60],[bound_I(1,1),bound_I(1,1)],'color','red');
line([0,60],[bound_I(2,1),bound_I(2,1)],'color','red');

subplot(l,k,2);
bar(PACF_I(2:end,1));
line([0,60],[pbound_I(1,1),pbound_I(1,1)],'color','red');
line([0,60],[pbound_I(2,1),pbound_I(2,1)],'color','red');

subplot(l,k,3);
bar(ACF_MP(2:end,1));
line([0,60],[bound_MP(1,1),bound_MP(1,1)],'color','red');
line([0,60],[bound_MP(2,1),bound_MP(2,1)],'color','red');

subplot(l,k,4);
bar(PACF_MP(2:end,1));
line([0,60],[pbound_MP(1,1),pbound_MP(1,1)],'color','red');
line([0,60],[pbound_MP(2,1),pbound_MP(2,1)],'color','red');

[PARAMETERS11I, LL11I, ERRORS11I, SEREGRESSION11I, DIAGNOSTICS11I, VCVROBUST11I, VCV11I, LIKELIHOODS11I, SCORES11I] = armaxfilter(I,1,1,1);
[PARAMETERS12I, LL12I, ERRORS12I, SEREGRESSION12I, DIAGNOSTICS12I, VCVROBUST12I, VCV12I, LIKELIHOODS12I, SCORES12I] = armaxfilter(I,1,1,[1 2]);
[PARAMETERS21I, LL21I, ERRORS21I, SEREGRESSION21I, DIAGNOSTICS21I, VCVROBUST21I, VCV21I, LIKELIHOODS21I, SCORES21I] = armaxfilter(I,1,[1 2],1);
[PARAMETERS22I, LL22I, ERRORS22I, SEREGRESSION22I, DIAGNOSTICS22I, VCVROBUST22I, VCV22I, LIKELIHOODS22I, SCORES22I] = armaxfilter(I,1,[1 2],[1 2]);

AICI = [11,DIAGNOSTICS11I.AIC;12,DIAGNOSTICS12I.AIC;21,DIAGNOSTICS21I.AIC;22,DIAGNOSTICS22I.AIC];
display(AICI);

[PARAMETERS11MP, LL11MP, ERRORS11MP, SEREGRESSION11MP, DIAGNOSTICS11MP, VCVROBUST11MP, VCV11MP, LIKELIHOODS11MP, SCORES11MP] = armaxfilter(MP,1,1,1);
[PARAMETERS12MP, LL12MP, ERRORS12MP, SEREGRESSION12MP, DIAGNOSTICS12MP, VCVROBUST12MP, VCV12MP, LIKELIHOODS12MP, SCORES12MP] = armaxfilter(MP,1,1,[1 2]);
[PARAMETERS21MP, LL21MP, ERRORS21MP, SEREGRESSION21MP, DIAGNOSTICS21MP, VCVROBUST21MP, VCV21MP, LIKELIHOODS21MP, SCORES21MP] = armaxfilter(MP,1,[1 2],1);
[PARAMETERS22MP, LL22MP, ERRORS22MP, SEREGRESSION22MP, DIAGNOSTICS22MP, VCVROBUST22MP, VCV22MP, LIKELIHOODS22MP, SCORES22MP] = armaxfilter(MP,1,[1 2],[1 2]);

AICMP = [11,DIAGNOSTICS11MP.AIC;12,DIAGNOSTICS12MP.AIC;21,DIAGNOSTICS21MP.AIC;22,DIAGNOSTICS22MP.AIC];
display(AICMP);

%choose arma(2,1) for I and arma(1,1) for MP

errorI=ERRORS21I.^2;
errorMP=ERRORS11MP.^2;

[LMI,P_lmI] = lmtest1(errorI,5);
[lbqI,P_lbI,QstatI,CVI] = lbqtest(errorI,1:5,0.05);
display(P_lmI);
display(P_lbI);

[LMMP,P_lmMP] = lmtest1(errorMP,5);
[lbqMP,P_lbMP,QstatMP,CVMP] = lbqtest(errorMP,1:5,0.05);
display(P_lmMP);
display(P_lbMP);

%the lm test for I and MP reject the null of no heteroskedasticity.
%the lb test for I does not reject it.
%the lb test for MP rejects it.

[ACF_Ier,lag_Ier,bound_Ier]=autocorr(errorI,60);
[PACF_Ier,plag_Ier,pbound_Ier]=parcorr(errorI,60);

[ACF_MPer,lag_MPer,bound_MPer]=autocorr(errorMP,60);
[PACF_MPer,plag_MPer,pbound_MPer]=parcorr(errorMP,60);

subplot(l,k,5);
bar(ACF_Ier(2:end,1));
line([0,60],[bound_Ier(1,1),bound_Ier(1,1)],'color','red');
line([0,60],[bound_Ier(2,1),bound_Ier(2,1)],'color','red');

subplot(l,k,6);
bar(PACF_Ier(2:end,1));
line([0,60],[pbound_Ier(1,1),pbound_Ier(1,1)],'color','red');
line([0,60],[pbound_Ier(2,1),pbound_Ier(2,1)],'color','red');

subplot(l,k,7);
bar(ACF_MPer(2:end,1));
line([0,60],[bound_MPer(1,1),bound_MPer(1,1)],'color','red');
line([0,60],[bound_MPer(2,1),bound_MPer(2,1)],'color','red');

subplot(l,k,8);
bar(PACF_MPer(2:end,1));
line([0,60],[pbound_MPer(1,1),pbound_MPer(1,1)],'color','red');
line([0,60],[pbound_MPer(2,1),pbound_MPer(2,1)],'color','red');

%given the ACF and the PACF for the errors of I and MP,
%we use the arma(2,1) for I and arma(1,1) garch(1,1) for MP to get the
%coeffs for forecasting

SpecMP = garchset('r',1,'m',1,'p',1,'q',1);
[CoeffMP,ErrorsMP,LLFMP,InnovationsMP,SigmasMP,SummaryMP] = garchfit(SpecMP,errorMP);
CoeffsMP=[CoeffMP.C CoeffMP.AR CoeffMP.MA]';

%forecasting I

[yhattph21,yhat21,forerr21,ystd21]=arma_forecaster(I,PARAMETERS21I,1,[1 2],1,1,1,SEREGRESSION21I);

DEI=diff(yhattph21);

%forecasting MP

[yhattph11,yhat11,forerr11,ystd11]=arma_forecaster(MP,CoeffsMP,1,1,1,1,1,SEREGRESSION11MP);

%compute UI and UMP

UI=I-yhattph21;

UMP=MP-yhattph11;

% Part 2

l=409;

trusacom=num(l:end,2);
trusabin=num(l:end,3);
trusg10m=num(l:end,4);
spxd=num(l:end,5);
djcbtd=num(l:end,6);

ump=UMP(l:end,1);
dei=DEI(l-1:end,1);
ui=UI(l:end,1);
urp=num(l:end,12);
uts=num(l:end,13);

x=[ump dei ui urp uts];

statstrusacom=regstats(trusacom,x,'linear',{'beta','covb', 'yhat', 'r','fstat', 'tstat'});
statstrusabin=regstats(trusabin,x,'linear',{'beta','covb', 'yhat', 'r','fstat', 'tstat'});
statstrusg10m=regstats(trusg10m,x,'linear',{'beta','covb', 'yhat', 'r','fstat', 'tstat'});
statsspxd=regstats(spxd,x,'linear',{'beta','covb', 'yhat', 'r','fstat', 'tstat'});
statsdjcbtd=regstats(djcbtd,x,'linear',{'beta','covb', 'yhat', 'r','fstat', 'tstat'});

betax=[statstrusacom.tstat.beta(1:end,1)'; statstrusabin.tstat.beta(1:end,1)'; statstrusg10m.tstat.beta(1:end,1)'; statsspxd.tstat.beta(1:end,1)'; statsdjcbtd.tstat.beta(1:end,1)'];

y=[trusacom'; trusabin'; trusg10m'; spxd'; djcbtd'];

for i=1:length(ump)
    strusacom(i)=regstats(y(:,i),betax,'linear',{'beta','covb', 'yhat', 'r','fstat', 'tstat'});
    strusabin(i)=regstats(y(:,i),betax,'linear',{'beta','covb', 'yhat', 'r','fstat', 'tstat'});
    strusg10m(i)=regstats(y(:,i),betax,'linear',{'beta','covb', 'yhat', 'r','fstat', 'tstat'});
    sspxd(i)=regstats(y(:,i),betax,'linear',{'beta','covb', 'yhat', 'r','fstat', 'tstat'});
    sdjcbtd(i)=regstats(y(:,i),betax,'linear',{'beta','covb', 'yhat', 'r','fstat', 'tstat'});
end;
