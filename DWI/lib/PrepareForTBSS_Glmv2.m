
function [AllTBSS_Paths] = PrepareForTBSS_Glmv2(DicomRootPath,data_info,Options)

load('Conditions.mat','DTIdadosmodif')
ConditionsDados = DTIdadosmodif;
DTI_Folder = 'Nifti/DWI/eddy/dti';
list = dir(DicomRootPath);

[dataPath] = fileparts(DicomRootPath);
TBSS_Path = [dataPath '/TBSSv2-' data_info.ProjectName];

if ~exist(TBSS_Path,'dir')
    mkdir(TBSS_Path)
end

[rows,cols] = size(ConditionsDados);

for u = 3:length(list)
    
    [~,SubjNum,extension] = fileparts(list(u).name);
    
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
            
            ListMeasures = dir([DTI_Path '/*.nii*']);
            
            for ii = 1:length(ListMeasures)
                
                if strcmp(ListMeasures(ii).name,['dti_S0.' Options.ConvertFormat])
                    continue
                end
                
                if strcmp(ListMeasures(ii).name,['dti_tensor.' Options.ConvertFormat])
                    continue
                end
                
                if strcmp(ListMeasures(ii).name,['dti_FA.' Options.ConvertFormat])
                    continue
                end
                
                temp = strsplit(ListMeasures(ii).name,'_');
                temp = strsplit(temp{2},'.');
                
                Measure_file = [DTI_Path '/' ListMeasures(ii).name];
                FA_file = [DTI_Path '/dti_FA.nii.gz'];
                
                % Redefine FA map file name
                NewFileName = [TimeExperiment '_' SubjNum '.nii.gz'];
                
                switch TimeExperiment
                    
                    case 'Pre'
                        
                        NewFilePath1 = [Against_1 '/' NewFileName];
                        NewFilePath2 = [Against_3 '/' NewFileName];
                        
                        % Copy File to each proper comparison directory
                        if ~exist(NewFilePath1,'file')                        
                            copyfile(FA_file,NewFilePath1)
                        end
                        
                        if~exist(NewFilePath2,'file')
                            copyfile(FA_file,NewFilePath2)
                        end
                        
                        NewDir1 = [Against_1 '/' temp{1}];
                        NewDir3 = [Against_3 '/' temp{1}];
                        
                        NewFilePath_measure1 = [NewDir1 '/' NewFileName];
                        NewFilePath_measure2 = [NewDir3 '/' NewFileName];
                                                
                        if ~exist(NewDir1,'dir')
                            mkdir(NewDir1)
                        end
                        
                        if ~exist(NewDir3,'dir')
                            mkdir(NewDir3)
                        end 
                                                
                        copyfile(Measure_file,NewFilePath_measure1)
                        copyfile(Measure_file,NewFilePath_measure2)
                        
                    case 'Pos'
                        
                        NewFilePath1 = [Against_2 '/' NewFileName];
                        NewFilePath2 = [Against_3 '/' NewFileName];
                        
                        % Copy File to each proper comparison directory
                        if ~exist(NewFilePath1,'file')                        
                            copyfile(FA_file,NewFilePath1)
                        end
                        
                        if~exist(NewFilePath2,'file')
                            copyfile(FA_file,NewFilePath2)
                        end
                        
                        NewDir2 = [Against_2 '/' temp{1}];
                        NewDir3 = [Against_3 '/' temp{1}];
                        
                        NewFilePath_measure1 = [NewDir2 '/' NewFileName];
                        NewFilePath_measure2 = [NewDir3 '/' NewFileName];
                                                
                        if ~exist(NewDir2,'dir')
                            mkdir(NewDir2)
                        end
                        
                        if ~exist(NewDir3,'dir')
                            mkdir(NewDir3)
                        end 
                                                
                        copyfile(Measure_file,NewFilePath_measure1)
                        copyfile(Measure_file,NewFilePath_measure2)
                        
                    case 'Follow-up'
                        
                        NewFilePath1 = [Against_1 '/' NewFileName];
                        NewFilePath2 = [Against_2 '/' NewFileName];
                        
                        % Copy File to each proper comparison directory
                        if ~exist(NewFilePath1,'file')                        
                            copyfile(FA_file,NewFilePath1)
                        end
                        
                        if~exist(NewFilePath2,'file')
                            copyfile(FA_file,NewFilePath2)
                        end
                        NewDir1 = [Against_1 '/' temp{1}];
                        NewDir2 = [Against_2 '/' temp{1}];
                        
                        NewFilePath_measure1 = [NewDir1 '/' NewFileName];
                        NewFilePath_measure2 = [NewDir2 '/' NewFileName];
                                                
                        if ~exist(NewDir1,'dir')
                            mkdir(NewDir1)
                        end
                        
                        if ~exist(NewDir2,'dir')
                            mkdir(NewDir2)
                        end 
                                                
                        copyfile(Measure_file,NewFilePath_measure1)
                        copyfile(Measure_file,NewFilePath_measure2)                        
                        
                end
                
            end
            
            
        end
    end
end

[AllTBSS_Paths] = GetTBSS_Paths (TBSS_Path);

end