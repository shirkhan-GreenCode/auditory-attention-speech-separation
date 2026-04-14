function [labels, runningCenters] = cluster_framewise_average(features, K, strictPresence)
%CLUSTER_FRAMEWISE_AVERAGE Frame-wise clustering with averaged running centers.
arguments
    features double
    K (1,1) double {mustBePositive, mustBeInteger} = 2
    strictPresence (1,1) logical = false
end

numInst = size(features,1);
frames = numInst / 10;
if mod(frames,1) ~= 0
    error('Features must be arranged in blocks of 10 rows per frame.');
end

[frameLabels, runningCenters] = local_cluster10(features(1:10,:), K);
labels = zeros(numInst,1);
labels(1:10) = frameLabels;

for i = 2:frames
    idx = (i-1)*10 + 1 : i*10;
    [curLabels, curCenters] = local_cluster10(features(idx,:), K);
    [mappedLabels, runningCenters] = map_and_update(curLabels, curCenters, runningCenters, true, strictPresence);
    labels(idx) = mappedLabels;
end
end

function [labels, centers] = local_cluster10(X, K)
    [g, centers] = kmeans(X, K, 'Distance', 'sqeuclidean', 'Start', 'sample', 'Replicates', 5);
    labels = g(:);
end
