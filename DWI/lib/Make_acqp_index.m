
function Make_acqp_index(DWIPath,data_info)


for u = 1:length(DWIPath)
    
    try
        
        acqp_file = [DWIPath{u} '/acqparams.txt'];
        
        if ~exist(acqp_file,'file')
            fileID1 = fopen(acqp_file,'w');
            acqp_vec = ['0 -1 0 ' num2str(data_info.DWI_Nreadouts)];
            fprintf(fileID1,'%s',acqp_vec);
            fclose(fileID1);
        end
        
        index_file = [DWIPath{u} '/index.txt'];
        
        if ~exist(index_file,'file')
            fileID2 = fopen(index_file,'w');
            index = num2str(ones(1,data_info.NumberVolumes.dwi));
            fprintf(fileID2,'%s',index);
            fclose(fileID2);
        end
        
    catch erro
        continue        
    end
    
end

end