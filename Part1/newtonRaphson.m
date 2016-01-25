function [relativeError,x,flag,time]=newtonRaphson (func,dfunc,intialGuess ,epslon,maxItr)
eps=epslon;
flag = 1 ;
maxIt=maxItr;
x(1)=intialGuess;
relativError(1)=1;
tic;

for i=2:maxIt
    dif=dfunc(x(i-1));
    if(dif==0)
     %   disp('this function cant be calculated using newton raphson method')
        flag=0;
        time = toc ;
        relativeError=zeros (1,50);
        return ;
    end
    tempF=func(x(i-1));
    x(i)=x(i-1)-(tempF/dif);
    relativeError(i)=abs((x(i)-(x(i-1)))/(x(i)));
    if(tempF==0 ||  relativeError(i)<eps)
       % disp('an exact root has been found');
       relativeError(1)=100;
        break;
    end
end
time = toc ;
if(i>=maxItr & abs((x(i)-x(i-1))/x(i))>eps)
    %disp('no accurate root can be found with this number of itrations and accurcy');
    flag=0;
    return;
end

%plot the function
fplot(func,[intialGuess-10,intialGuess+10]);
y1=get(gca,'ylim');
hold on ;
pause(1);
plot(y1,[0,0],'k');
pause(1);
for s=1:length(x)
    temp1=[x(s),x(s),x(s)];
    temp2=[0,20,-20];
    plot(temp1,temp2);
    pause(1);
end

%

%relativeError
%x
hold off ;



    