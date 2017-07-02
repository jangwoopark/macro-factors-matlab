function [alpha,beta,std ] = Reg_output( Y,X )
%REG_OUTPUT Summary of this function goes here
%   Detailed explanation goes here
statsN = regstats(Y,X,'linear');
alpha=statsN.beta(1);
beta=statsN.beta(2);
std=statsN.covb^(1/2);
ttest_a=(alpha)/std(1,1);
ttest_b=(beta-1)/std(2,2);
disp('For null hypothesis alpha=0 and beta=1')
fprintf('T-test for alpha is %f.\n', ttest_a)
fprintf('T-test for beta is %f.\n\n', ttest_b)
end

