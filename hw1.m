m=input('order of derivative= ');
k=input('order of accuracy=');
%centeral
if rem(k,2)==1
    k=k+1 %number of 
end 
if rem(m,2)==1
    j=m+k-1 %number of point
else
    j=m+k-2
end
ListB =cell(1,j/2); %listA=listB BEFOR
for p=1:j/2;
    ListB{1,p}=strcat('xneg',num2str(p));
end
A=sym(ListB);
ListA =cell(1,j/2);%listA=list AFTER
for p=1:j/2;
    ListA{1,p}=strcat('xpos',num2str(p));
end
A(2,:)=sym(ListA)
M=cell(j,k+m);
for p=1:j/2;
    for l=1:k+m;
        M{p,l}= (-(j/2)+p-1)^(l-1);
    end
end
for p=1:j/2;
    for l=1:k+m;
        M{((j/2)+p),l}= (p)^(l-1);
    end
end
f=cell2mat(M)

b=sym(zeros(size(j,(k+m))));
for p=1:(j/2);
    for l=1:k+m;
        b(p,l)=A(1,((j/2)-p+1)) .* f(p,l);
    end
end
for p=1:(j/2);
    for l=1:k+m;
       b((j/2)+p,l)=A(2,p) .* f((j/2)+p,l)
    end
end
z=1;

for p=2:(k+m);
    if p~=m+1
     eval(['eq' num2str(z) '=sum(b(:,p)) == 0'])
    else
      eval(['eq' num2str(z) '=sum(b(:,p)) == factorial(m)'])
    end
  
    z=z+1;
end
eqs=sym(zeros(size(1,(z-1))));
for p=1:z-1
    eval(['eqs(1,p)= eq' num2str(p)])
end
s=sym(zeros(size(1,j)));
for p=1:j/2
    s(1,p)=A(1,((j/2-p+1)));
end
ss=j/2
for p=1:j/2;
    s(1,(p+ss))=A(2,p);
end
anss=solve(eqs,s);
anss_values = sym(zeros(size(j+1)));
h = 1;
w=0;
for item = fliplr(ListB);
    anss_values (h) = getfield(anss,item{1})
    w=w+anss_values (h)
    h = h+1;
end
r=h+1;
for item = ListA
    anss_values (r) = getfield(anss,item{1})
    w=w+anss_values (r)
    r = r+1;
end
anss_values (h)=-w
disp(anss_values)
clear

