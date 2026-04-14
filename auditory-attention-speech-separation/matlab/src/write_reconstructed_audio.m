function [file1, file2] = write_reconstructed_audio(sp1, sp2, sampleRate, frameLength, file1, file2, iterations)
%WRITE_RECONSTRUCTED_AUDIO Invert auditory spectrograms and save WAV files.
arguments
    sp1 double
    sp2 double
    sampleRate (1,1) double {mustBePositive}
    frameLength (1,1) double {mustBePositive}
    file1 (1,:) char
    file2 (1,:) char
    iterations (1,1) double {mustBePositive} = 100
end

paras = [frameLength, 8, -2, log2(16000/16000)];
xh1 = aud2wavi(sp1, paras);
xh2 = aud2wavi(sp2, paras);
xh1 = aud2wav(sp1, xh1, [paras iterations 0 0]);
xh2 = aud2wav(sp2, xh2, [paras iterations 0 0]);
audiowrite(file1, xh1, sampleRate);
audiowrite(file2, xh2, sampleRate);
end
