

function [ relativeError, x, flag, time]=newton(intialGuess,epslon,maxItr,funct)
func=eval(strcat('@(x)',funct));
dfunc=diff(funct);
df=inline(dfunc);
[relativeError, x, flag ,time]=newtonRaphson(func,df,intialGuess,epslon,maxItr);

