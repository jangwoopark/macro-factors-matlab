clear all;
clc;

[num, txt] = xlsread('zerocouponprices.xlsx', 'prices');

% Log price vectors of N=1,2,3,4,5
log1 = log(num(:,2));
log2 = log(num(:,3));
log3 = log(num(:,4));
log4 = log(num(:,5));
log5 = log(num(:,6));

% Yield vectors of N = 1,2,3,4,5
yield1 = -log1;

forward12 = log1 - log2;
forward23 = log2 - log3;
forward34 = log3 - log4;
forward45 = log4 - log5;

% creating the dependent variables for problem 1
% Dependent, N = 1,2,3,4
T=12;
YN1 = yield1((1+1*T):end)-yield1(1:end-1*T);
YN2 = yield1((1+2*T):end)-yield1(1:end-2*T);
YN3 = yield1((1+3*T):end)-yield1(1:end-3*T);
YN4 = yield1((1+4*T):end)-yield1(1:end-4*T);

% creating the matrix of independent variables for problem 1
x1 = forward12 - yield1;
x2 = forward23 - yield1;
x3 = forward34 - yield1;
x4 = forward45 - yield1;

XN1 = x1(1:end-1*T);
XN2 = x2(1:end-2*T);
XN3 = x3(1:end-3*T);
XN4 = x4(1:end-4*T);

display('When N = 1:');
Reg_output(YN1,XN1);
display('When N = 2:');
Reg_output(YN2,XN2);
display('When N = 3:');
Reg_output(YN3,XN3);
display('When N = 4:');
Reg_output(YN4,XN4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Problem 2, holding period return %%%%%%
disp('PART 2: Holding Period Return:');

XH1=x1(1:end-1);
XH2=x2(1:end-1);
XH3=x3(1:end-1);
XH4=x4(1:end-1);

hpr1=(log1(2:end)-log2(1:end-1));
hpr2=(log2(2:end)-log3(1:end-1));
hpr3=(log3(2:end)-log4(1:end-1));
hpr4=(log4(2:end)-log5(1:end-1));

YH1=hpr1-yield1(1:end-1);
YH2=hpr2-yield1(1:end-1);
YH3=hpr3-yield1(1:end-1);
YH4=hpr4-yield1(1:end-1);

display('When N = 1:');
Reg_output(YH1,XH1);
display('When N = 2:');
Reg_output(YH2,XH2);
display('When N = 3:');
Reg_output(YH3,XH3);
display('When N = 4:');
Reg_output(YH4,XH4);
