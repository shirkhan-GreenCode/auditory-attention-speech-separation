function outputs = run_attention_pipeline(audioFile, templateFile, frameLength, outputSampleRate, reconstructionIterations, outputDir)
%RUN_ATTENTION_PIPELINE End-to-end pipeline for auditory attention modeling.
%
% outputs = run_attention_pipeline(audioFile, templateFile, frameLength, ...
%    outputSampleRate, reconstructionIterations, outputDir)

arguments
    audioFile (1,:) char
    templateFile (1,:) char
    frameLength (1,1) double {mustBePositive} = 32
    outputSampleRate (1,1) double {mustBePositive} = 44100
    reconstructionIterations (1,1) double {mustBePositive} = 100
    outputDir (1,:) char = 'results'
end

if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

[x, fsIn] = audioread(audioFile);
if size(x,2) > 1
    x = mean(x, 2);
end

s = load(templateFile);
if isfield(s, 'T')
    T = s.T;
else
    error('Template file must contain variable T.');
end

spec = compute_auditory_spectrogram(x, frameLength, true);
harmonicCube = harmonic_analysis(spec, T);
rateFiles = cortical_analysis(harmonicCube, outputDir, frameLength);
[avgFeatures, standardizedFeatures, normalization] = compute_cortical_averages(rateFiles, outputDir);

[globalLabels, globalCenters] = cluster_global(standardizedFeatures, 2, false);
[trackedLabelsAvg, trackedCentersAvg] = cluster_framewise_average(standardizedFeatures, 2, false);
[trackedLabelsPrev, trackedCentersPrev] = cluster_framewise_previous(standardizedFeatures, 2, false);

[spk1Global, spk2Global, globalIndex] = reconstruct_speakers(globalLabels, audioFile, frameLength);
[spk1Tracked, spk2Tracked, trackedIndex] = reconstruct_speakers(trackedLabelsAvg, audioFile, frameLength);

[fileGlobal1, fileGlobal2] = write_reconstructed_audio(spk1Global, spk2Global, outputSampleRate, frameLength, ...
    fullfile(outputDir, 'speaker1_global.wav'), fullfile(outputDir, 'speaker2_global.wav'), reconstructionIterations);
[fileTracked1, fileTracked2] = write_reconstructed_audio(spk1Tracked, spk2Tracked, outputSampleRate, frameLength, ...
    fullfile(outputDir, 'speaker1_tracked.wav'), fullfile(outputDir, 'speaker2_tracked.wav'), reconstructionIterations);

save(fullfile(outputDir, 'pipeline_outputs.mat'), 'spec', 'avgFeatures', 'standardizedFeatures', ...
    'globalLabels', 'globalCenters', 'trackedLabelsAvg', 'trackedCentersAvg', ...
    'trackedLabelsPrev', 'trackedCentersPrev', 'globalIndex', 'trackedIndex', 'normalization', '-v7.3');

outputs = struct();
outputs.spec = spec;
outputs.avgFeatures = avgFeatures;
outputs.standardizedFeatures = standardizedFeatures;
outputs.globalLabels = globalLabels;
outputs.globalCenters = globalCenters;
outputs.trackedLabelsAvg = trackedLabelsAvg;
outputs.trackedCentersAvg = trackedCentersAvg;
outputs.trackedLabelsPrev = trackedLabelsPrev;
outputs.trackedCentersPrev = trackedCentersPrev;
outputs.globalFiles = {fileGlobal1, fileGlobal2};
outputs.trackedFiles = {fileTracked1, fileTracked2};
outputs.outputDir = outputDir;
outputs.inputSampleRate = fsIn;
end
