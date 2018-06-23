%--------------------------------------------------------------------------
%   ��ѹ�ź��Զ�������ѹ����
%   20180623
%   ����
%--------------------------------------------------------------------------
%   ����
%   sig         ���ź�
%   bw_range    �źŴ���
%   fs          �����źŵĲ�������
%   Nfft        ����ѹ���ӵĵ���
%   window_fun  �����������Բ�д��Ĭ����chebwin����Ϊchebwin���ƽ̹
%--------------------------------------------------------------------------
%   example
%   waveform = phased.FMCWWaveform('SweepTime',T,'SweepBandwidth',bw,...
%              'SampleRate',fs,'SweepInterval','Symmetric');
%   sig = step(waveform);
%   rt.pc_factor(sig,[-5e6 5e6],fs,Nfft);
%--------------------------------------------------------------------------
function pcf = pc_factor(sig,bw_range,fs,Nfft,window_fun)
if isreal(sig)~=0
    disp('sig����Ϊ���ź�');
    pcf = nan;
    return
end

if nargin <=4
    window_fun = @chebwin;                                                  %�����ݲ�������Ĭ���б�ѩ��
end

bw_low = min(bw_range);                                                     %�ź���ʼ����
bw_max = max(bw_range);                                                     %�źŽ�������
bw = bw_max-bw_low;                                                         %�źŴ�����Χ

N = round(bw/fs*Nfft);                                                      %ռ��fft�����ķ�Χ����
window_f = [window_fun(N);zeros(Nfft-N,1)];                                 %����Ƶ��Ӵ�����
shift_point = round(bw_low/fs*Nfft);                                        %���㴰�����ƶ�����
window_f = circshift(window_f,shift_point);                                 %�µ�Ƶ��

pc_sig = conj(fft(sig,Nfft));                                               %���㴫ͳ��ѹ����
shape = 1./abs(pc_sig).^2.*window_f;                                        %��̬����
pcf= pc_sig.* shape;                                                        %������ѹ���Ӱ���