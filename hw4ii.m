clc;
shocks11 = randn(100,1000);
shocks1 = shocks11*.15;

p1=NaN(100,1000);

for j=1:1000
    for i=1:100;
        if i==1
            p1(i,j)=0.05+shocks1(i,j);
        else
            p1(i,j)=0.05+p1(i-1,j)+shocks1(i,j);
        end
    end
end


shocks22 = randn(100,1000);
shocks2 = shocks22*.15;

for j=1:1000
    for i=1:100;
        if i==1
            p2(i,j)=0.05+shocks2(i,j);
        else
            p2(i,j)=0.05+p2(i-1,j)+shocks2(i,j);
        end
    end
    
end


totalr=0;
totalt=[0;0];
for j=1:1000
    stats(j) = regstats(p1(:,j), p2(:,j) , 'linear', {'rsquare', 'tstat'});
    totalr=totalr+stats(j).rsquare;
    totalt=totalt+stats(1,j).tstat.t;
    vectort(j,1)=stats(1,j).tstat.t(1);
    vectort(j,2)=stats(1,j).tstat.t(2);
end

avgr = totalr/1000
b0avgt = totalt(1)/1000
b1avgt = totalt(2)/1000

figure
hist(vectort(:,1))
title('Histogram of t-stats for beta0')
figure
hist(vectort(:,2))
title('Histogram of t-stats for beta1')

