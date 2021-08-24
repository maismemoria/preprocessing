
function [AllTBSS_Paths] = PrepareForTBSS_Glm(DicomRootPath,data_info)

load('Conditions.mat','DTIdadosmodif')
ConditionsDados = DTIdadosmodif;
DTI_Folder = 'Nifti/DWI/eddy/dti';
list = dir(DicomRootPath);

[dataPath] = fileparts(DicomRootPath);
TBSS_Path = [dataPath '/TBSS-' data_info.ProjectName];

if ~exist(TBSS_Path,'dir')
    mkdir(TBSS_Path)
end

[rows,cols] = size(ConditionsDados);

for u = 3:length(list)
    
    [~,SubjNum,extension] = fileparts(list(u).name);
    
    if strcmp(SubjNum,'2404471')
        a = 'a';        
    end
    
    if isempty(extension)
        [ii,jj] = FindConditions(SubjNum,rows,cols,ConditionsDados);
        
        if isempty(ii) && isempty(jj)
            continue
        else
            Condition = char(ConditionsDados{ii,1});
            TimeExperiment = char(ConditionsDados{1,jj});
            
            % Make a directory for each condition
            CondPath = [TBSS_Path '/' Condition];
            
            if ~exist(CondPath,'dir')
                mkdir(CondPath)
            end
            
            % Make a directory for each comparison
            Against_1 = [CondPath '/Pre-Flwup'];
            
            if ~exist(Against_1,'dir')
                mkdir(Against_1)
            end
            
            % Make a directory for each comparison
            Against_2 = [CondPath '/Pos-Flwup'];
            
            if ~exist(Against_2,'dir')
                mkdir(Against_2)
            end
            
            % Make a directory for each comparison
            Against_3 = [CondPath '/Pre-Pos'];
            
            if ~exist(Against_3,'dir')
                mkdir(Against_3)
            end
            
            % Define DTI_Path and filename
            DTI_Path = [DicomRootPath '/' SubjNum '/' DTI_Folder];
            FA_file = [DTI_Path '/dti_FA.nii.gz'];
            
            % Redefine FA map file name
            NewFileName = [TimeExperiment '_' SubjNum '.nii.gz'];
            
            switch TimeExperiment
                
                case 'Pre'
                    
                    NewFilePath1 = [Against_1 '/' NewFileName];
                    NewFilePath2 = [Against_3 '/' NewFileName];
                    
                    % Copy File to each proper comparison directory
                    copyfile(FA_file,NewFilePath1)
                    copyfile(FA_file,NewFilePath2)
                    
                case 'Pos'
                    
                    NewFilePath1 = [Against_2 '/' NewFileName];
                    NewFilePath2 = [Against_3 '/' NewFileName];
                    
                    % Copy File to each proper comparison directory
                    copyfile(FA_file,NewFilePath1)
                    copyfile(FA_file,NewFilePath2)
                    
                case 'Follow-up'
                    
                    NewFilePath1 = [Against_1 '/' NewFileName];
                    NewFilePath2 = [Against_2 '/' NewFileName];
                    
                    % Copy File to each proper comparison directory
                    copyfile(FA_file,NewFilePath1)
                    copyfile(FA_file,NewFilePath2)
                    
            end
            
            
            %             copyfile(FA_file,[TBSS_Path '/' char(Condition) '_' char(TimeExperiment) '_FA.nii.gz'])
        end
    end
end

[AllTBSS_Paths] = GetTBSS_Paths (TBSS_Path);

end