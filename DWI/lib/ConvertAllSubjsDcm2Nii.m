
function ConvertAllSubjsDcm2Nii(SubjsCellArray,OutputPath)

Nsubjs = size(SubjsCellArray,2);

%% ConvertDicom2nii job:

%SubjsCellArray => cell(Nsubjs); Contains Nsubjs cell arrays which contain
%each a cell array with (NumberOfdcmImagesPerSubject,1) dimensions
%OutputPath => cell(Nsubjs,1); Contains the output directories for each
%subject

matlabbatch = cell(1,Nsubjs);


for n = 1:Nsubjs
    
    CellArray = SubjsCellArray{:,n};
    
    if DataExists(CellArray)
        [matlabbatch{1,n}] = ConvertDicom2Nii(CellArray,OutputPath{n});
    else
        disp('Problem with data. Check DataExists function carefully.')
        break
    end
    
end

%% Initialize SPM:

spm('defaults', 'FMRI');
% spm_jobman('initcfg')

%% Do Conversion:
jobs = matlabbatch;
% inputs = cell(0, 1)
spm_jobman('run', jobs);

end
