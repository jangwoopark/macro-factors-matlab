function [s]= skewness(data)

s=(1/((length(data)-1)*std(data)^3))*sum((data-mean(data)).^3)

end