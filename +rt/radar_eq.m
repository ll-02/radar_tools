%--------------------------------------------------------------------------
%   �״﷽��
%   qwe14789cn@gmail.com
%--------------------------------------------------------------------------
%   ����:
%       pt      ��ֵ����        W
%       fc      ����Ƶ��        Hz
%       G       ��������        dB
%       rcs     �״ﷴ������  m^2
%       bw      �źŴ���        Hz
%       nf      ����ϵ��        dB
%       L       �״����        dB
%       range   Ŀ�����        m
%   �����
%       snr     �����          dB
%--------------------------------------------------------------------------
%   example
%   ��ֵ����1.5MW   ����Ƶ��5.6GHz  ��������45dB    �״����6dB
%   ����ϵ��3dB     �״����5MHz    ��С̽�����25km  ���̽�����165km
%   radar_eq(1.5e6,5.6e9,45,0.1,5e6,3,6,25e3)
%--------------------------------------------------------------------------
function [snr] = radar_eq(pt,fc,G,rcs,bw,nf,L,range)
c      = 3e8;
pt_db  = pow2db(pt);
lambda = c/fc;
lambda_sqdb = pow2db(lambda.^2);
rcs_db      = pow2db(rcs);
four_pi_db  = pow2db((4*pi).^3);

k_db      = pow2db(1.38e-23);
T_db      = pow2db(290);
bw_db     = pow2db(bw);
range_db  = pow2db(range.^4);
A      = pt_db + G + G +lambda_sqdb + rcs_db;
B      = four_pi_db + k_db + T_db + bw_db + nf + L + range_db;
snr =  A-B;