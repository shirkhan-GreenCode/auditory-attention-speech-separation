function rateFiles = cortical_analysis(harmonicCube, outputDir, frameLength)
%CORTICAL_ANALYSIS Compute cortical representations for multiple rates.
arguments
    harmonicCube double
    outputDir (1,:) char = 'results'
    frameLength (1,1) double {mustBePositive} = 4
end

rates = [2, 4, 8, 16, 32];
scales = [1/8, 1/4, 1/2, 1, 2, 4, 8];
SF = 16000;
paras = [frameLength, 8, -2, log2(SF/16000)];
numTemplates = size(harmonicCube, 3);
rateFiles = cell(numel(rates), 1);

for rIdx = 1:numel(rates)
    rv = rates(rIdx);
    ca = [];
    for i = 1:numTemplates
        cr = aud2cor(harmonicCube(:,:,i), paras, rv, scales, fullfile(outputDir, sprintf('R%d', rv)), 1);
        if isempty(ca)
            ca = zeros([numTemplates, size(cr)]);
        end
        ca(i,:,:,:,:) = cr;
    end
    varName = sprintf('ca%d', rv);
    rateFile = fullfile(outputDir, sprintf('Rate%d.mat', rv));
    eval([varName ' = ca;']); %#ok<EVLDIR>
    save(rateFile, varName, '-v7.3');
    rateFiles{rIdx} = rateFile;
end
end
