function ha = harmonic_analysis(spec, templateBank)
%HARMONIC_ANALYSIS Apply harmonic template matching to an auditory spectrogram.
arguments
    spec double
    templateBank double
end

[numFrames, ~] = size(spec);
numTemplates = size(templateBank, 1);
convLen = size(spec,2) + size(templateBank,2) - 1;
ha = zeros(numFrames, convLen, numTemplates);
for i = 1:numTemplates
    template = templateBank(i, :);
    for j = 1:numFrames
        ha(j, :, i) = conv(spec(j, :), template);
    end
end
end
