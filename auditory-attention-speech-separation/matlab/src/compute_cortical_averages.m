function [avgFeatures, standardizedFeatures, normalization] = compute_cortical_averages(rateFiles, outputDir)
%COMPUTE_CORTICAL_AVERAGES Extract centroid-like features from cortical data.
arguments
    rateFiles cell
    outputDir (1,:) char = 'results'
end

numRates = numel(rateFiles);
avgFeatures = [];

for rf = 1:numRates
    S = load(rateFiles{rf});
    fn = fieldnames(S);
    ca = S.(fn{1});
    [h, s, r, t, f] = size(ca);
    if isempty(avgFeatures)
        avgFeatures = zeros(numRates * 2, t, 4);
    end
    baseIdx = (rf - 1) * 2;
    for m = 1:t
        stats = zeros(2,4);
        for rc = 1:min(2, r)
            ave_s = 0; ave_h = 0; ave_f = 0; total_a = 0;
            for i = 1:s
                for j = 1:f
                    for z = 1:h
                        val = abs(ca(z,i,rc,m,j));
                        ave_s = ave_s + val * i;
                        ave_f = ave_f + val * j;
                        ave_h = ave_h + val * z;
                        total_a = total_a + val;
                    end
                end
            end
            ta = s * f * h;
            ave_a = total_a / max(ta, 1);
            total_a = max(abs(total_a), eps);
            stats(rc,1) = ave_s / total_a;
            stats(rc,2) = ave_h / total_a;
            stats(rc,3) = ave_f / total_a;
            stats(rc,4) = ave_a;
        end
        avgFeatures(baseIdx + 1, m, :) = stats(1,:);
        avgFeatures(baseIdx + 2, m, :) = stats(2,:);
    end
end

reshaped = reshape(avgFeatures, size(avgFeatures,1) * size(avgFeatures,2), []);
rawFeatures = reshaped;
[standardizedFeatures, ps] = mapstd(rawFeatures', 0, 1);
standardizedFeatures = standardizedFeatures';
normalization = ps;

save(fullfile(outputDir, 'ave.mat'), 'avgFeatures');
save(fullfile(outputDir, 'rave.mat'), 'standardizedFeatures');
save(fullfile(outputDir, 'raw_features.mat'), 'rawFeatures', 'normalization');
end
