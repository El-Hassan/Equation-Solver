function [relativeError,x,flag,time]=falsepos (fun,start,last,epslon,maxItr)
flag=1;
func=eval(strcat('@(x)',fun));
star=start;
eps=epslon;
maxIt=maxItr;
fstart=func(star);
flast=func(last);
%
fplot(func,[start-1,last+1]);
y1=get(gca,'ylim');
hold on ;
pause(1);
plot(y1,[0,0],'k');
%drawRange=linspace(start,last,100);
%for s=1:length(drawRange)
  %     drawfunc(s)=func(drawRange(s));
 %      xaxis(s)=0;
%end
%plot(drawRange,drawfunc,'r');
%
tic;
if(fstart*flast>0)
    disp('by substitution, the 2 points have the same sign!!');
    relativeError=0;
    flag=0;
    x=0;
    time=0;
    disp('here');
    return
end

xr=0;
relativeError(1)=0;
temp = 0 ;
for i=1:maxIt
    
    lastXr=xr;
    xr=((star(i)*flast(i))-(last(i)*fstart(i)))/(flast(i)-fstart(i));
    ea=abs((xr-lastXr/xr));
    relativeError(i)=ea;
    x(i)=xr;
    y=func(x(i));
    if(y==0)
        disp('exact root found!');
        flag=1;
        tmie=toc;
        %relativeError=0;
        Itr=i;
        break;
    elseif y*fstart<0
        star(i+1)=star(i);
        fstart(i+1)=fstart(i);
        last(i+1)=x(i);
        flast(i+1)=y; 
    else
        star(i+1)=x(i);
        fstart(i+1)=y;
        last(i+1)=last(i);
        flast(i+1)=flast(i);
    end;
    if(i>maxIt & abs(x(i)-x(i-1)<eps))
        flag=1;
        %disp('an approximate root has been found');
        break;
    end
    if(i>1 & (abs(x(i)-x(i-1))/x(i))<eps)
         flag=1;
        % disp('an approximate root has been found');
         Itr=i;
         break;
    end;
    Itr=i;
    
    temp = temp + toc ;
    pause(1);
    xPoint=[star(i),last(i)];
    yPoint=[func(star(i)),func(last(i))];
    plot(xPoint,yPoint,'b');
    tic ;
end
hold off;
if(Itr>maxIt)
    disp('cant find a root with given ntolerance with this number of itrations');
    flag=0;
end
time=toc+temp ;
end



        
    
        
    
  
    

