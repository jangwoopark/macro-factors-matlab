function [k]=kurtosis(data)

k=(1/((length(data)-1)*std(data)^4))*sum((data-mean(data)).^4)

end