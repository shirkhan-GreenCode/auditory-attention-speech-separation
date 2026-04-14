function [sp1, sp2, frameIndex] = reconstruct_speakers(clusterLabels, audioFile, frameLength)
%RECONSTRUCT_SPEAKERS Build two masked cortical representations and invert them.
arguments
    clusterLabels double
    audioFile (1,:) char
    frameLength (1,1) double {mustBePositive}
end

[x, ~] = audioread(audioFile);
if size(x,2) > 1
    x = mean(x, 2);
end
spec = compute_auditory_spectrogram(x, frameLength, false);
SF = 16000;
paras = [frameLength, 8, -2, log2(SF/16000)];
rv = [2,4,8,16,32];
sv = [1/8,1/4,1/2,1,2,4,8];

tmpName = tempname;
cr = aud2cor(spec, paras, rv, sv, tmpName, 1);
numRows = size(clusterLabels,1);
numFrames = numRows / 10;
if mod(numFrames,1) ~= 0
    error('clusterLabels must contain 10 labels per frame.');
end

frameIndex = zeros(numFrames, 10);
for i = 1:numFrames
    idx = (i-1)*10 + 1 : i*10;
    frameIndex(i,:) = clusterLabels(idx).';
end

[s, r, t, f] = size(cr);
cr1 = zeros(s,r,t,f);
cr2 = zeros(s,r,t,f);
for i = 1:numFrames
    for j = 1:min(10, r)
        if frameIndex(i,j) == 1
            cr1(:,j,i,:) = cr(:,j,i,:);
        else
            cr2(:,j,i,:) = cr(:,j,i,:);
        end
    end
end

cr1 = cor_intpol(cr1);
cr2 = cor_intpol(cr2);
sp1 = abs(cor2aud(tmpName, cr1));
sp2 = abs(cor2aud(tmpName, cr2));
end
