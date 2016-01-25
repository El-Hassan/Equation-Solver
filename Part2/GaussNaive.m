function [x,time] = GaussNaive(Aug) 
tic ;

[m,n] = size(Aug); 

nb=n;
n=n-1;
 

% forward elimination
for k = 1:n-1
    temp=Aug(k,k);
    for z=k+1:n-1
        if(temp<Aug(z,k))
        temp=Aug(z,k);
        temp2=Aug(k,:);      %partial pivoting
        Aug(k,:)=Aug(z,:);
        Aug(z,:)=temp2;
        end
        
    end
    
    for y = k+1:n 
        factor = Aug(y,k)/Aug(k,k);
        Aug(y,k:nb) = Aug(y,k:nb)-factor*Aug(k,k:nb); 
    end
end

% back substitution 
x = zeros(n,1); 
x(n) = Aug(n,nb)/Aug(n,n);
for i = n-1:-1:1 
    x(i) = (Aug(i,nb)-Aug(i,i+1:n)*x(i+1:n))/Aug(i,i); 
end

time = toc ;