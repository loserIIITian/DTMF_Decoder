
function symbol = dtmf_decode(TouchToneDialler);
Fsampling = 8000;

dial_keys = ['1' '2' '3';'4' '5' '6'; '7' '8' '9'; '*' '0' '#'];
RowFreq = [1209,1336,1477];
ColFreq = [697,770,852,941];

len=length(TouchToneDialler);

figure(1);
plot(TouchToneDialler);
title('Signal generated by encoder');
ylabel('Amplitude');
xlabel('Seconds');

incremental = Fsampling/len;
f=0:incremental:1500;

signal_fft=abs(fft(TouchToneDialler));

signaltmp = signal_fft(1:length(f));

ColLowF = round(650/incremental);
ColUpF = round(950/incremental);
RowLowF = round(1200/incremental);
RowUpF = round(1500/incremental);

flower = 650:incremental:950;
signal_lower = signaltmp(ColLowF:ColUpF);
figure(3);
plot(flower,signal_lower(1:length(flower)));
xlabel('Frequency');
ylabel('Magnitude');
title('Column FFT');

fupper = 1200:incremental:1500;
signal_Upper = signaltmp(RowLowF:RowUpF);
figure(4);
plot(fupper,signal_Upper(1:length(fupper)));
xlabel('Frequency in Hz');
ylabel('Magnitude');
title('Row FFT');

[max1,indexLow] = max(signal_lower);
[max2,indexUp] = max(signal_Upper);

low_Freq = round(flower(indexLow));
Up_Freq = round(fupper(indexUp));

lower = abs(ColFreq - low_Freq);
upper = abs(RowFreq - Up_Freq);

[error0,result_low] = min(lower);
[error2,result_up] = min(upper);



symbol = dial_keys(result_low,result_up);