clear all;
clc;

filename='data_ps1.txt';

[num, txt] = xlsread('data_ps1.xlsx', 'DBV');
%[num, txt] = xlsread('data_ps1.xlsx', 'SP500');
%date=datenum(txt(:,1), 'mm/dd/yyyy');
dbvopenPrice=num(:, 2);
dbvclosePrice=num(:, 4);

l=length(dbvclosePrice);

dbvLogReturn=-diff(log(dbvclosePrice));

disp('The average daily log return of DBV is:')
meanReturns=[mean(dbvLogReturn)]

disp('The annualized log return is:')
annuallizedlogreturn=meanReturns*250

disp('The standard deviation of average daily log returns is:')
standarddeviationoflogreturns=[std(dbvLogReturn)]

disp('The average daily log return per unit of risk is:')
adlrpuor=meanReturns/standarddeviationoflogreturns

disp('The average daily simple return is:')
simpleMean=exp(meanReturns+standarddeviationoflogreturns/2)

skewnessOfLogReturns=[skewness(dbvLogReturn)]
disp('The skewness test is:')
stest=skewnessOfLogReturns/sqrt(6/l)
kurtosisOfLogReturns=[kurtosis(dbvLogReturn)]
disp('The kurtosis test is:')
ktest=(kurtosisOfLogReturns-3)/sqrt(24/l)
disp('The JB test is:')
jbtest=skewnessOfLogReturns^2/(6/l)+(kurtosisOfLogReturns-3)^2/(24/l)
