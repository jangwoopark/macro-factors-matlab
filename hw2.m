clear all;
clc;

filename='zerocouponprices.xlsx';

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

lag1=lagts(log1,1)

% creating the matrix of independent variables for problem 1

A1 = forward12 - yield1;
A2 = forward23 - yield1;
A3 = forward34 - yield1;
A4 = forward45 - yield1;

% run the OLS regression

