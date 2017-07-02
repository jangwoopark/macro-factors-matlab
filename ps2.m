clear all;
clc;

[num, txt] = xlsread('zerocouponprices.xlsx', 'prices');

log1 = log(num(:,2));
log2 = log(num(:,3));
log3 = log(num(:,4));
log4 = log(num(:,5));
log5 = log(num(:,6));

yield1 = -log1;

forward12 = log1 - log2;
forward23 = log2 - log3;
forward34 = log3 - log4;
forward45 = log4 - log5;

% creating the dependent variables for problem 1

b1 = diff(yield1);

for i=3:length(yield1)
    b2(i-2) = yield1(i) - yield1(i-2);
end

for i=length(yield1):-1:4
    b3(i-3) = yield1(i) - yield1(i-3);
end

for i=length(yield1):-1:5
    b4(i-4) = yield1(i) - yield1(i-4);
end 
%sb2=[0;b2'];
%sb3=[0;0;b3'];
%sb4=[0;0;0;b4'];
%matrix=[b1 sb2 sb3 sb4];
% creating the matrix of independent variables for problem 1

xx1 = forward12 - yield1;
xx2 = forward23 - yield1;
xx3 = forward34 - yield1;
xx4 = forward45 - yield1;

x1 = xx1(1:end-1);
x2 = xx2(1:end-2);
x3 = xx3(1:end-3);
x4 = xx4(1:end-4);

xxx1=xx1;
xxx2=xx2(1:end-1);
xxx3=xx3(1:end-1);
xxx4=xx4(1:end-1);


%X1 = [ones(size(x1)) x1 ];
%X2 = [ones(size(x2)) x2 ];
% run the OLS regression
% b = lscov(X2,b2')
%Xm1 = X1'*X1;
%invXm1 = inv(Xm1);
%bet=invXm1*X1'*b1

stats1 = regstats(b1,x1,'linear');
betax1=stats1.beta;
se_x1=stats1.covb^(1/2);
ttestx11=(betax1(1))/se_x1(1,1);
ttestx12=(betax1(2)-1)/se_x1(2,2);
disp('N=1: For null hypothesis alpha=0 and beta=1')
fprintf('T-test for beta is %f\n', ttestx11)
fprintf('T-test for beta is %f\n\n', ttestx12)

stats2 = regstats(b2,x2,'linear');
betax2=stats2.beta;
se_x2=stats2.covb^(1/2);
ttestx21=(betax2(1))/se_x2(1,1);
ttestx22=(betax2(2)-1)/se_x2(2,2);
disp('N=2: For null hypothesis alpha=0 and beta=1')
fprintf('T-test for beta is %f\n', ttestx21)
fprintf('T-test for beta is %f\n\n', ttestx22 )

stats3 = regstats(b3,x3,'linear');
betax3=stats3.beta;
se_x3=stats3.covb^(1/2);
ttestx31=(betax3(1))/se_x3(1,1);
ttestx32=(betax3(2)-1)/se_x3(2,2);
disp('N=3: For null hypothesis alpha=0 and beta=1')
fprintf('T-test for beta is %f\n', ttestx31)
fprintf('T-test for beta is %f\n\n', ttestx32)

stats4 = regstats(b4,x4,'linear');
betax4=stats4.beta;
se_x4=stats4.covb^(1/2);
ttestx41=(betax4(1))/se_x4(1,1);
ttestx42=(betax4(2)-1)/se_x4(2,2);
disp('N=4: For null hypothesis alpha=0 and beta=1')
fprintf('T-test for beta is %f\n', ttestx41)
fprintf('T-test for beta is %f\n\n', ttestx42)

disp('PART 2')

hpr1=(log1(2:end)-log2(1:end-1));
hpr2=(log2(2:end)-log3(1:end-1));
hpr3=(log3(2:end)-log4(1:end-1));
hpr4=(log4(2:end)-log5(1:end-1));

hstats1 = regstats(hpr1,x1,'linear');
hbetax1=hstats1.beta;
hse_x1=hstats1.covb^(1/2);
httestx11=(hbetax1(1))/hse_x1(1,1);
httestx12=(hbetax1(2)-1)/hse_x1(2,2);
disp('N=1: For null hypothesis alpha=0 and beta=1')
fprintf('T-test for beta is %f\n', httestx11)
fprintf('T-test for beta is %f\n\n', httestx12)

hstats2 = regstats(hpr2,xxx2,'linear');
hbetax2=hstats2.beta;
hse_x2=hstats2.covb^(1/2);
httestx21=(hbetax2(1))/hse_x2(1,1);
httestx22=(hbetax2(2)-1)/hse_x2(2,2);
disp('N=2: For null hypothesis alpha=0 and beta=1')
fprintf('T-test for beta is %f\n', httestx21)
fprintf('T-test for beta is %f\n\n', httestx22 )

hstats3 = regstats(hpr3,xxx3,'linear');
hbetax3=hstats3.beta;
hse_x3=hstats3.covb^(1/2);
httestx31=(hbetax3(1))/hse_x3(1,1);
httestx32=(hbetax3(2)-1)/hse_x3(2,2);
disp('N=3: For null hypothesis alpha=0 and beta=1')
fprintf('T-test for beta is %f\n', httestx31)
fprintf('T-test for beta is %f\n\n', httestx32)

hstats4 = regstats(hpr4,xxx4,'linear');
hbetax4=hstats4.beta;
hse_x4=hstats4.covb^(1/2);
httestx41=(hbetax4(1))/hse_x4(1,1);
httestx42=(hbetax4(2)-1)/hse_x4(2,2);
disp('N=4: For null hypothesis alpha=0 and beta=1')
fprintf('T-test for alpha is %f\n', httestx41)
fprintf('T-test for beta is %f\n\n', httestx42)