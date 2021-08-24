
function RealignEstimateAllSubjects(funcSubjsCellArray)

Nsubjs = size(funcSubjsCellArray,2);

%% Estimate Realignment job:

matlabbatch = cell(1,Nsubjs);

for n = 1:Nsubjs
    
    CellArray = funcSubjsCellArray{:,n};
    if DataExists(CellArray)
        matlabbatch{1,n} = RealignEstimate(CellArray);          
    else
        disp('Problem with data. Check DataExists function carefully.')
        break
    end
        
        
end

%% Initialize SPM:

spm('defaults', 'FMRI');
% spm_jobman('initcfg')

%% Do Estimation:
jobs = matlabbatch;
% inputs = cell(0, 1)
spm_jobman('run', jobs);

end
