function [ mean_svri ] = PostFilter( svris )
      
        %figure
        %hist(svris)
        %title('sVRIs before SIM')
        
        %3����׼����̬�ֲ����� ʹ��svri���� ���Ϊsvri     
       
        i=1;
        while(i<=length(svris))
            if(abs(svris(i)-mean(svris))>3*std(svris))
            svris(i)=[];
            end
            i=i+1;
        end
        
        %figure
        %histfit(svris)
        %fprintf('��̬�ֲ���ֵ��%d',mean(svris))
        %title('sVRIs after SIM')
        
        
        %Q3=0;%���ķ�λ��
        %Q1=0;%���ķ�λ��
        %Q1=prctile(svris,25);%���ķ�λ��
        %Q3=prctile(svris,75);%���ķ�λ��
        %IQR=Q3-Q1;%����
        %i=1;
        %while(i<=length(svris))
         %   if(svris(i)>(Q3+1.5*IQR)||svris(i)<(Q1-1.5*IQR))%�º��쳣
          %      svris(i)=[];
           % end
            %i=i+1;
        %end
        
        
        mean_svri = mean(svris);

end

