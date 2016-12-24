function [ mean_svri ] = PostFilter( svris )
      
        %figure
        %hist(svris)
        %title('sVRIs before SIM')
        
        %3倍标准差正态分布方法 使用svri数据 结果为svri     
       
        i=1;
        while(i<=length(svris))
            if(abs(svris(i)-mean(svris))>3*std(svris))
            svris(i)=[];
            end
            i=i+1;
        end
        
        %figure
        %histfit(svris)
        %fprintf('正态分布均值：%d',mean(svris))
        %title('sVRIs after SIM')
        
        
        %Q3=0;%下四分位数
        %Q1=0;%上四分位数
        %Q1=prctile(svris,25);%上四分位数
        %Q3=prctile(svris,75);%下四分位数
        %IQR=Q3-Q1;%极差
        %i=1;
        %while(i<=length(svris))
         %   if(svris(i)>(Q3+1.5*IQR)||svris(i)<(Q1-1.5*IQR))%温和异常
          %      svris(i)=[];
           % end
            %i=i+1;
        %end
        
        
        mean_svri = mean(svris);

end

