function [sp1,sp2,index]=result(cl,wavfile,frl)
wav=wavread(wavfile);
sp=spg(wav,frl);
SF = 16000;
paras=[frl,8,-2,log2(SF/16000)];
rv=[2,4,8,16,32];
sv=[1/8,1/4,1/2,1,2,4,8];
figure,
cr=aud2cor(sp,paras,rv,sv,'tmpxxx',1);
[m,n]=size(cl);
frno=m/10;
%frno : no. of fram
index=zeros(frno,10);
%index= shakese taalogh har rat da har frame be kodam gooiande
for i=1:frno
    for j=(i-1)*10+1:i*10
        z=mod((j+10),10);
        if z==0
            z=10;
        end
        index(i,z)=cl(j,1);
    end
end
[s,r,t,f]=size(cr);
cr1=zeros(s,r,t,f);
cr2=zeros(s,r,t,f);
for i=1:frno
    for j=1:10
        if index(i,j)==1
            cr1(:,j,i,:)=cr(:,j,i,:);
        else
            cr2(:,j,i,:)=cr(:,j,i,:);
        end
    end
end
% do interpolation
cr1=cor_intpol(cr1);
cr2=cor_intpol(cr2);
sp1=cor2aud('tmpxxx',cr1);
sp2=cor2aud('tmpxxx',cr2);
figure,imshow(sp1'),colormap(jet)
figure,imshow(sp2'),colormap(jet)
sp1=abs(sp1);
sp2=abs(sp2);
end

        
        
