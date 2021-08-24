function [WarpedSubjsCellArray] = NormalizeRealignEstimateAllSubjs(SubjsCellArray,PathSPM)

Nsubjs = size(SubjsCellArray,2);

%% Convert Dicom to nifti:

%SubjsCellArray => cell(Nsubjs); Contains Nsubjs cell arrays which contain
%each a cell array with (NumberOfdcmImagesPerSubject,1) dimensions
%OutputPath => cell(Nsubjs,1); Contains the output directories for each
%subject


for n = 1:Nsubjs
    
    CellArray = SubjsCellArray{:,n};
    if DataExists(CellArray)
        matlabbatch{1}.spm.spatial.normalise.estwrite.subj(n).vol = {CellArray{1}};
        matlabbatch{1}.spm.spatial.normalise.estwrite.subj(n).resample = CellArray;        
        matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.biasreg = 0.0001;
        matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.biasfwhm = 60;
        matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.tpm = {[PathSPM '/tpm/TPM.nii']};
        matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.affreg = 'mni';
        matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.reg = [0 0.001 0.5 0.05 0.2];
        matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.fwhm = 0;
        matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.samp = 3;
        matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.bb = [-78 -112 -70
            78 76 85];
        matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.vox = [2 2 2];
        matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.interp = 4;
        matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.prefix = 'w';
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

%% Rename Subjects
[WarpedSubjsCellArray] = RenameSubjects(SubjsCellArray,matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.prefix);


end
