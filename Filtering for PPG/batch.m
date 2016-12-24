userpath('C:\Users\hyh\Desktop\matlab\w20');% 工作路径，情各自修改
savepath;

clear all; close all; clc;


%读取数据

files = listfiles('.\data','*.xlsx');
N = length(files)
result=[];%%%svri
for j=1:N
    
    disp(files{j}) % 显示文件名   
    [mean_sVRI,sVRIs ] = filting( files{j} );
    result= [result;mean_sVRI];

    format long g;

    name = strcat(files{j}(1:end-4),'_svri.txt')
    fp = fopen(name,'wt');

    fprintf(fp, '%s\t %.4f \n','mena_sVRI',mean_sVRI);
    m = 1;
    while(m<=length(sVRIs))
        fprintf(fp, '%.4f \n',sVRIs(m));
        m = m+1;
    end



    fclose(fp);

    % 其他操作
    clear sVRIs;
    clear data;
    clear fp;

end

fp = fopen('.\result_box.txt','wt');
l = 1;
for k=1:N
    if( mod(k,3) == 1)
        fprintf(fp, '%s\t\t', files{k});    
        fprintf(fp, '%.4f \t',result(k+2));
    end
    if( mod(k,3) == 2)   
        fprintf(fp, '%.4f \t',result(k-1));
    end
    if( mod(k,3) == 0)
        fprintf(fp, '%.4f \n',result(k-1));
    end
     
end
clear fp;