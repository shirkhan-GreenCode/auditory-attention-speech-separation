function y = compute_auditory_spectrogram(wav, frameLength, showFigure)
%COMPUTE_AUDITORY_SPECTROGRAM Compute NSL auditory spectrogram.
arguments
    wav (:,1) double
    frameLength (1,1) double {mustBePositive}
    showFigure (1,1) logical = false
end

SF = 16000;
paras = [frameLength, 8, -2, log2(SF/16000)];
y = wav2aud(wav, paras, 'p_o');

if showFigure
    figure('Name', 'Auditory spectrogram');
    imagesc(y'); axis xy; colormap(jet); colorbar;
    xlabel('Time frame'); ylabel('Channel');
    title(sprintf('Auditory spectrogram (frame length = %g)', frameLength));
end
end
