function [ condition ] = Condition( single_wave,y1,y2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [max1,max_index]=max(single_wave);
    [min1,min_index]=min(single_wave);
    accepted = 0;
    %����1�����Ȳ����1000
    if(max1 - min1 < 1000)
        accepted = accepted+1; 
    end 
    %����2�����ڴ���250������120��С��600������50��
    if(length(single_wave) > 250 &&  length(single_wave) < 600)
        accepted = accepted+1;  
    end 
    %����3��������ʱ��С���½���
    if(length(single_wave) - max_index > max_index)
        accepted = accepted+1;  
    end 
    
    %����4����Сֵ�����ڿ�ͷ�����
    if(min_index == 1 || min_index == length(single_wave))
        accepted = accepted+1;  
    end 
    %����5����β�ķ��Ȳ�С���������Ȳ��40%
    if( abs(single_wave(1)-single_wave(end)) /(max1-min1) < 0.4)
        accepted = accepted+1;  
    end 
    
    [max_value,max_point]=max(single_wave);%%%%��ߵ�
    x=max_value-single_wave(1);%%%��ߵ����ʼ����������
    %%%%%ta1 
    [max_value_a,max_point_a]=max(y1);%%%%��ߵ�
    %����6��������һ�׵�������0,��������
    for i=1:max_point
        if y1(i)<0
            break;
        end
    end
    if i == max_point
         accepted = accepted+1;  
    end
    
    %����7���������ز������䲨��Ϊy��(x - y)/x > 10% 
    %(x-y)/x(alternative augmentation index),x(systolic peak),y(diastolic
    %peak),(x - y)/x > 10%
    
    %%%%tb1
    tb1 = 10000;
    for i=max_point:length(single_wave)-2
        if y2(i)>0
            break;
        end
    end
    tb1=i;
   
    %%%%t2
    if tb1==10000
        t2=10000;
    else
        for i=(tb1+1):length(single_wave)-2
            if y2(i)<y2(i-1)
                break;
            end
        end
        if i==length(single_wave)-2
            t2=100000;
        else t2=i;
        end    
    end
    %%%%%%%%%%%%%t3
    if t2==10000
        t3=10000;
    else
        for i=(t2*+1):length(single_wave)-2
            if y2(i)>y2(i-1)
                break;
            end
        end
        if i==length(single_wave)-2
            t3=10000;
        else t3=i;
        end    
    end
    
    
   
    %%%%%%2  y (diastolic peak)
    y = 10000;
    if t3 < length(single_wave)
        y=single_wave(t3)-((t3-1)/(length(single_wave)-1)*(single_wave(end)-single_wave(1))+single_wave(1));
    
    end
     
    %%%6 (x��y)/x (alternative augmentation index)
    agi = 0;
    if x~=10000 && y~=10000
        agi =(x-y)/x;
    end
     
    if agi > 0.1
        accepted = accepted;
    end
    
    
    condition = -1;
    if(accepted == 6)
        condition = 1;
    end
    
   
end

