function [cl,Ctotal]=cluster4(rave,K);
% anjame clustering be ravesh chaharom (clustering har fram).ravesh 
% miangin giri bad az har fram va  vojoode do gooiande dar har fram
[m,n]=size (rave);
cl_total=zeros(m,1);
[cl,Ctotal]=cluster1(rave(1:10,:),K);
cl_total(1:10,1)=cl(:,5);
for i=2:m/10
    clx=zeros(10,1);
    [cl,center]=cluster1(rave((i-1)*10+1:i*10,:),K);
    clx(:,1)=cl(:,5);
    %faseleie oghlidisi
    a(1,1)=norm(Ctotal(1,:)-center(1,:));
    a(2,1)=norm(Ctotal(1,:)-center(2,:));
    a(3,1)=norm(Ctotal(2,:)-center(1,:));
    a(4,1)=norm(Ctotal(2,:)-center(2,:));
    %peida kardan adrese kamtarin faseleie oghlidosi
    [r1,c1]=find(a==min(min(a)));
    %peida kardan adrese dovomin faseleie kam oghlidosi
    a(r1,c1)=100000000;
    [r2,c2]=find(a==min(min(a)));
        if r1*r2==6
        % tabdile 2 be 1 va 1 be do
        clx=((clx-2)*-2+2)/2;
        Ctotal(1,:)=(center(2,:)+Ctotal(1,:))/2;
        Ctotal(2,:)=(center(1,:)+Ctotal(2,:))/2;
        
        else
            Ctotal(1,:)=(center(1,:)+Ctotal(1,:))/2;
            Ctotal(2,:)=(center(2,:)+Ctotal(2,:))/2;
        end

        
        cl_total((i-1)*10+1:i*10,1)=clx(:,1);
end 
cl=cl_total;
end












        
        











