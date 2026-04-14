function [ca]=corticanal(ha)
%ha:harmonicity analys
sv=[1/8,1/4,1/2,1,2,4,8];
rv=[2];    
[l,w,h]=size(ha);
SF = 16000;
paras=[4,8,-2,log2(SF/16000)];
a=length(sv);
b=length(rv);
for i=1:128
    cr=aud2cor(ha(:,:,i),paras,rv,sv,'R2',1);
    ca(i,:,:,:,:)=cr;
end
ca2=ca;
save ('Rate2','ca2','-v7.3');
clear ca
clear cr
clear ca2
rv=[4];
for i=1:128
    cr=aud2cor(ha(:,:,i),paras,rv,sv,'R4',1);
    ca(i,:,:,:,:)=cr;
end
ca4=ca;
save ('Rate4','ca4','-v7.3');
clear ca
clear cr
clear ca4
rv=[8];
for i=1:128
    cr=aud2cor(ha(:,:,i),paras,rv,sv,'R8',1);
    ca(i,:,:,:,:)=cr;
end
ca8=ca;
save ('Rate8','ca8','-v7.3');
clear ca
clear cr
clear ca8
rv=[16];
for i=1:128
    cr=aud2cor(ha(:,:,i),paras,rv,sv,'R16',1);
    ca(i,:,:,:,:)=cr;
end
ca16=ca;
save ('Rate16','ca16','-v7.3');
clear ca
clear cr
clear ca16
rv=[32];
for i=1:128
    cr=aud2cor(ha(:,:,i),paras,rv,sv,'R32',1);
    ca(i,:,:,:,:)=cr;
end
ca32=ca;
save ('Rate32','ca32','-v7.3');
clear ca
clear cr
clear ca32
end