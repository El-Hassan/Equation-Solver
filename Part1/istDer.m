function [root relativeError x flag time]=istDer(start,last,epslon,maxItr,funct)
syms x;
func=funct;
f=inline(func);
[root relativeError x flag time]=falsepos(f,start,last,epslon,maxItr );
