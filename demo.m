clear
clc;
Fs = 16000;
filename = 'C:\Users\Filip\Projects\master-thesis\data\processed\MIR-1k\Wavfile\Ani_1_01.wav'
convnet = getfield(load('convModel.mat'), 'convnet')
pitch = PitchExtraction(filename, convnet);

a = miraudio(filename,'Sampling',Fs);
a_v1 = mirgetdata(a);
f = mirframe(a,'Length',0.05,'s','Hop',0.01,'s');
s = mirspectrum(f,'Length',8192);
s_v1 = mirgetdata(s);
f_v1 = get(f,'FramePos');
s_v2 = get(s,'Pos');

figure
[none1,none2,t] = spectrogram(a_v1,ceil(Fs*0.05),ceil(Fs*0.04),8192,Fs,'yaxis');
% hold on;
ylim([0.05 0.4]); % To ensure frequencies between 50 Hz and 2 kHz are highlighted.
hold on;
if(f_v1{1,1}{1,1}(1,end) >= 60)
    plot(f_v1{1,1}{1,1}(1,:)./60, pitch./1000,'--r');
else
    plot(f_v1{1,1}{1,1}(1,:), pitch./1000,'--r');
end
hold off;
title(filename);