function [ result ] = sVRi( single_wave )
%SVRI Summary of this function goes here
%   Detailed explanation goes here

    [max_1,index]=max(single_wave);
    up=single_wave;
    up=up(1:index);
    down=single_wave;
    down=down(index:length(single_wave));%分开上下沿
   
    %上升沿与下降沿数据
    max_up=max(up);
    min_up=min(up);

    dif_up=max_up-min_up;
    max_down=max(down);
    min_down=min(down);
    dif_down=max_down-min_down;

    %上升沿归一化处理 结果up_1
    n = 1;

    while(n<=length(up))
        up_1 (n)=(up(n)-min_up)/dif_up;
        n=n+1;
    end

    %下降沿归一化处理 结果down_1
    m = 1;
    while(m<=length(down))
        down_1(m)=(down(m)-min_down)/dif_down;
        m=m+1;
    end

    %积分获得SVRI A1为上升沿幅值 A2为下降沿幅值
    fs=500;%采样频率
    t_up=[1:length(up_1)]*(1/fs);
    A1=trapz(t_up,up_1)/(length(up_1)/fs);
    t_down=[1:length(down_1)]*(1/fs);
    A2=trapz(t_down,down_1)/(length(down_1)/fs);
    result=A2/A1;
end

