%spectrogram
function [y]=spg(wav,frl)
%frl= frame lenght
SF = 16000;
paras=[frl,8,-2,log2(SF/16000)];
y= wav2aud(wav,paras,'p_o');
s=y';
imshow(s),colormap(jet)
end