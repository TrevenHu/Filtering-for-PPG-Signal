clc
close all
clear all

ba=load('result.txt');
figure(1)
plot(ba);
%FIR
fs=60;
wn1=5*2/fs;
wn2=0.5*2/fs;
c = fir1(200,[wn2,wn1]);
y_tmp=filter(c,1,ba);
y_filted=y_tmp-mean(y_tmp);
figure(2)
subplot(2,1,1);
temp=y_filted(200:3300);
plot(temp);
axis([6,3000,-25,25]);
title('FIR�˲��ź�');  

data_org=load('2015-7-17_20-1-12.txt');
B=resample(data_org,60,1000); 
fs=60;
wn1=5*2/fs; 
b = fir1(200,wn1);
yy_tmp=filter(b,1,B);
y_original=yy_tmp-mean(yy_tmp);
y_cut=y_original(200:3300);

%LMS
N=3000;                                             %�����źų�������N
k=5;                                                  %ʱ���ͷLMS�㷨�˲�������
u=0.001;                                             %��������

%���ó�ֵ
yn_1=zeros(1,N);                                  %output signal
yn_1(1:k)=temp(1:k);                 %�������ź�temp��ǰk��ֵ��Ϊ���yn_1��ǰk��ֵ
w=zeros(1,k);                                        %���ó�ͷ��Ȩ��ֵ
e=zeros(1,N);                                        %����ź�

%��LMS�㷨�����˲�
for i=(k+1):N
        XN=temp((i-k+1):(i));
        yn_1(i)=w*XN;
        e(i)=y_cut(i)-yn_1(i);
        w=w+2*u*e(i)*XN';
end
%figure(3)
%subplot(3,1,2);
%plot(y_cut);                               % ԭʼ�ź�
%axis([k+1,N,-4,4]);
%title('�̹�Ϻ��ź�-��������');
%figure(4)
subplot(2,1,2);
plot(yn_1);                                            %����Ӧ�˲����ź�
axis([k+1,N,-4,4]);
title('����Ӧ�˲����ź�');      
