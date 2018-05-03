clear
clc
close all

fs=11025; %Sampling Frequency
[y,fs]=wavread('ECE6342_morse_code_sound.wav');
L=length(y);
Y=fft(y);
t=[1/fs:1/fs:L/fs];
plot(t,y) %Time domain plot of original audio file
title('Audio Plot')
xlabel('t/s---->')
figure
F = (fs/L:fs/L:fs);
plot(F,abs(Y)); %Plot of absolute value dft of y
title('fft of Audio file')
xlabel('f/Hz---->')
figure  

a=1;
for i=153501:154047  %13.923*fs,13.9725*fs (as there is no audio between 13.923s and 13.9725s and only morse code is there during this time) 
x(a)=y(i);           % Extracting the portion between 13-14s where there is no audio and only morse code
a=a+1;
end

L2=length(x);
t2=[1/fs:1/fs:L2/fs];
plot(t2,x)
title('Plot of 13-14s portion')
xlabel('t/s---->')
figure                                                           
X=fft(x);
F2 = (fs/L2:fs/L2:fs);
plot(F2,abs(X)) % Plot of DFT of x
title('fft of 13-14s')
xlabel('f/Hz---->')
n=3000; %order of bandpass filter
wn=[1736 1796]/(fs); % Bandpass filter from 883-15=868Hz to 883+15=898Hz as morse code frequency =883Hz (2*868=1736 and 2*1796 are taken as we have to use fir1 function)
wn2=[1736 1796]/(fs);% Bandstop filter parameters
[b a]=fir1(n,wn,'bandpass');
[d c]=fir1(n,wn2,'stop');
f2=filter(b,a,y);
f3=filter(d,c,y);
figure
plot(t,f2)
title('bandpass filtered output')
xlabel('t/s---->')
figure
plot(F,abs(fft(f2)))
title('fft of bandpass filtered output')
xlabel('f/Hz---->')
wavwrite(f2,fs,'Abdullah_Farooq_Morse');
wavwrite(f3,fs,'Abdullah_Farooq_Music');