function [cl,center]=cluster1(rave,K);
%tarif shode baraie clustring ravesh dovom ke shekl ha az an hazf shode.
%k= number of cluster
X=rave;
[numInst,numDims] = size(X);
%# K-means clustering
%# (K: number of clusters, G: assigned groups, C: cluster centers)
[G,C] = kmeans(X,K,'distance','sqEuclidean', 'start','sample');
center=C;
cl=zeros(numInst,5);
cl(:,1:4)=X;
cl(:,5)=G(:);
end
