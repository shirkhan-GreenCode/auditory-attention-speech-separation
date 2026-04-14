function [labels, centers] = cluster_global(features, K, showFigure)
%CLUSTER_GLOBAL Global K-means clustering across all frames.
arguments
    features double
    K (1,1) double {mustBePositive, mustBeInteger} = 2
    showFigure (1,1) logical = true
end

[labels, centers] = kmeans(features, K, 'Distance', 'sqeuclidean', 'Start', 'sample', 'Replicates', 5);

if showFigure && size(features,2) >= 3
    clr = lines(K);
    figure('Name', 'Global clustering'); hold on;
    scatter3(features(:,1), features(:,2), features(:,3), 36, clr(labels,:), 'filled');
    scatter3(centers(:,1), centers(:,2), centers(:,3), 120, clr, 'o', 'LineWidth', 2);
    xlabel('Feature 1'); ylabel('Feature 2'); zlabel('Feature 3');
    title('Global K-means clustering'); grid on; view(3);
    hold off;
end
end
