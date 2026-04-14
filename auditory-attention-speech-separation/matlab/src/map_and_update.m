function [mappedLabels, updatedCenters] = map_and_update(labels, centers, prevCenters, useAveraging, strictPresence)
%MAP_AND_UPDATE Resolve label switching between adjacent frames.

D = [norm(prevCenters(1,:) - centers(1,:)), ...
     norm(prevCenters(1,:) - centers(2,:));
     norm(prevCenters(2,:) - centers(1,:)), ...
     norm(prevCenters(2,:) - centers(2,:))];

sameOrder = (D(1,1) + D(2,2)) <= (D(1,2) + D(2,1));
if sameOrder
    mappedLabels = labels;
    orderedCenters = centers;
else
    mappedLabels = 3 - labels; % swaps 1 <-> 2 for K=2
    orderedCenters = centers([2 1], :);
end

if strictPresence
    % Keep both speakers represented in each frame.
    if useAveraging
        updatedCenters = (orderedCenters + prevCenters) / 2;
    else
        updatedCenters = orderedCenters;
    end
else
    present1 = any(mappedLabels == 1);
    present2 = any(mappedLabels == 2);
    updatedCenters = prevCenters;
    if present1
        if useAveraging
            updatedCenters(1,:) = (orderedCenters(1,:) + prevCenters(1,:)) / 2;
        else
            updatedCenters(1,:) = orderedCenters(1,:);
        end
    end
    if present2
        if useAveraging
            updatedCenters(2,:) = (orderedCenters(2,:) + prevCenters(2,:)) / 2;
        else
            updatedCenters(2,:) = orderedCenters(2,:);
        end
    end
end
end
