%Harmonicity 
function [ha]=harmanal(spg,temp)
[l,o]=size(spg);
ha=zeros(l,255,128);
for i=1:128
    for j=1:l
        ha(j,:,i)=conv(spg(j,:),temp(i,:));      
    end
end

    

    