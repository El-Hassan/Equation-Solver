function [ answer , time ] = gaussjordan(a)
tic ;
[m,n]=size(a);
for j=1:m-1
    % pivoting
    for v=j+1:m
        max = a(j,j);
        if a(v,j)> max
            temp=a(j,:);
            a(j,:)=a(v,:);
            a(v,:)=temp;
        end
    end
    %End pivoting
    
    %forward elimination
    for i=j+1:m
        a(i,:)=a(i,:)-a(j,:)*(a(i,j)/a(j,j));
    end
end
 
% backward elimination
for j=m:-1:2
    for i=j-1:-1:1
        a(i,:)=a(i,:)-a(j,:)*(a(i,j)/a(j,j));
    end
end
 
% assign answers to the final vector
for s=1:m
    a(s,:)=a(s,:)/a(s,s);
    answer(s)=a(s,n);
end
time = toc ;

