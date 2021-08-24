
function [TBSS_Path] = PrepareForTBSS2(DicomRootPath,data_info)

load('SubjsConditions.mat','DTIdados1')
DTI_Folder = 'Nifti/DWI/eddy/dti';
list = dir(DicomRootPath);

[dataPath] = fileparts(DicomRootPath);
TBSS_Path = [dataPath '/TBSS-' data_info.ProjectName];

if ~exist(TBSS_Path,'dir')
    mkdir(TBSS_Path)
end

[rows,cols] = size(DTIdados1);

for u = 3:length(list)
    
    [~,SubjNum,extension] = fileparts(list(u).name);
    
    if isempty(extension)
        [ii,jj] = FindConditions(SubjNum,rows,cols,DTIdados1);
        
        if isempty(ii) && isempty(jj)
            continue
        else
            Condition = char(DTIdados1{ii,1});
            TimeExperiment = char(DTIdados1{1,jj});
            
            DTI_Path = [DicomRootPath '/' SubjNum '/' DTI_Folder];
            FA_file = [DTI_Path '/dti_FA.nii.gz'];
            NewName = [TBSS_Path '/' TimeExperiment '_' ...
                Condition '_' SubjNum '.nii.gz'];
            
            copyfile(FA_file,NewName)
            
            %             copyfile(FA_file,[TBSS_Path '/' char(Condition) '_' char(TimeExperiment) '_FA.nii.gz'])
        end
    end    
end