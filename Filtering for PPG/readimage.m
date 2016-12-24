clc
close all
clear all

pa=[];
data_org=load('2015-7-17_20-1-12.txt');
B=resample(data_org,60,1000); 
fs=60;
wn1=5*2/fs; 
b = fir1(200,wn1);
yy_tmp=filter(b,1,B);
y_original=yy_tmp-mean(yy_tmp);
y_cut=y_original(200:2900);

%set(gca,'xdir','reverse')
axis([0,3000,-10,10]);
%��ȡ�����ļ�
av_files = dir('C:\\Users\\sony\\Desktop\\surface\\zxright-valid\\*.png');

fileamount = length(av_files);
for i=1:1:fileamount
     dirname = strcat('C:\\Users\\sony\\Desktop\\surface\\zxright-valid\\',av_files(i).name);
     [X,map,alpha]=imread(dirname);
     %(color,alpha,cdata)=uiopen(dirname,1);
     pa(i)=alpha(7,6);
end
figure(7)
plot(pa);
pa = pa(1:fileamount-600);
t=1:1:fileamount-600;

figure(1)
subplot(2,1,1);
plot(t,pa);
title('Sur40ԭʼ�ź�');
pa=smooth(pa,30);
subplot(2,1,2);
plot(t,pa);
title('ƽ���˲���');

%FIR
fs=60;
wn1=5*2/fs;
wn2=0.5*2/fs;
b = fir1(200,[wn2,wn1]);
y_tmp=filter(b,1,pa);
y_filted=y_tmp-mean(y_tmp);
figure(2)
temp=y_filted(200:2900);
subplot(3,1,1);
plot(temp);
axis([51,2700,-4,4]);
title('FIR�˲��ź�');  
%set(gca,'xdir','reverse')

%LMS
N=2700;                                             %�����źų�������N
k=50;                                                  %ʱ���ͷLMS�㷨�˲�������
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
subplot(3,1,2);
plot(y_cut);                               % ԭʼ�ź�
axis([k+1,N,-4,4]);
title('�̹�Ϻ��ź�-��������');
%figure(4)
subplot(3,1,3);
plot(yn_1);                                            %����Ӧ�˲����ź�
axis([k+1,N,-4,4]);
title('����Ӧ�˲����ź�');                          











