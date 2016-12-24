function [ mean_sVRI,sVRIs ] = filting( file )
    data_org1=xlsread(file);
    data_org = data_org1(:,2);
    %plot(data_org)
    %pause
    fs=500;
    wn1=5*2/fs; 
    b = fir1(200,wn1);
    y_tmp=filter(b,1,data_org);
    y_filted=y_tmp-mean(y_tmp);

    %plot(y_filted)
    %pause
    %%%%计算一阶导数
    for n=1:length(y_filted)-1
        Y1(n)=fs*(y_filted(n+1)-y_filted(n));          %一阶导数
    end
    %%%一阶导数滤波
    %wn2=3*2/fs; 
    %b2 = fir1(200,wn2);
    %Y1=filter(b2,1,Y1);
    %%%计算二阶导数
    for n=1:length(y_filted)-2
        Y2(n)=fs*(Y1(n+1)-Y1(n));   %二阶导数
    end
    %%%滤波引起的群延时
    Y1(1:108)=[];
    Y2(1:108)=[];
    %%%显示Y1 Y2
    % figure(1)
    % subplot 211
    % plot(Y1)
    % axis([-1,10000,-5,5]);
    % subplot 212
    % plot(Y2)
     %axis([-1,10000,-50,50]);
    %pause;
    %%%切割
    used=0*y_filted+1;
    used(1:300)=0;
    SpacePoint=[];
    while(min(used.*y_filted)<-0.1)
        tmp=used.*y_filted;
        [mini,pos]=min(tmp);  
        SpacePoint=[SpacePoint,pos];
        tmp_pos=pos;
        used(tmp_pos)=0;
        while (y_filted(tmp_pos)<0 & tmp_pos > 1)
            tmp_pos=tmp_pos-1;
            used(tmp_pos)=0;
        end
        tmp_pos=pos;
        while (y_filted(tmp_pos)<0 & tmp_pos<length(y_filted))
            tmp_pos=tmp_pos+1;
            used(tmp_pos)=0;
        end
    end
    SpacePoint=sort(SpacePoint);%%%%%%各个区间的分割点
    result=[];%%%特征集
    %%%%得到各个区间，及其一阶导数，二阶导数
    for i=1:length(SpacePoint)-2
        
        single_wave=y_filted(SpacePoint(i):SpacePoint(i+1));
        %y1=Y1(SpacePoint(i):SpacePoint(i+1));
        %y2=Y2(SpacePoint(i):SpacePoint(i+1));
        for n=1:length(single_wave)-1
            y1(n)=fs*(single_wave(n+1)-single_wave(n));          %一阶导数
        end
        
        for n=1:length(y1)-1
            y2(n)=fs*(y1(n+1)-y1(n));          %一阶导数
        end
        i
        
        %pause
        %[max1,max_index]=max(single_wave);
        %[min1,min_index]=min(single_wave);
            
       
        %max1
        %%max_index
        %min1
        %min_index
        %length(single_wave)
        if(Condition(single_wave,y1,y2) == 1)
            
            %plot(single_wave)
            %pause
             figure('visible','off')
             h=plot(single_wave);
             filename=[strcat(file(1:end-5),'/') num2str(i) '_selected.jpg'];
             saveas(h,filename)
            %pause
            result= [result;sVRi( single_wave)];
        else
            figure('visible','off')
            h=plot(single_wave);
            filename=[strcat(file(1:end-5),'/') num2str(i) '.jpg'];
            saveas(h,filename)
        end
        clear y1;
        clear y2;
    end
    sVRIs = result;
    mean_sVRI = PostFilter(result);
end