
function [matlabbatch] = RealignEstimate(CellArray)


%% Convert Dicom to nifti:
%CellArray => cell(NumberOfdcmImagesPerSubject,1)

matlabbatch{1}.spm.spatial.realign.estwrite.data = {cellstr(f)};
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [0 1];


matlabbatch.spm.spatial.realign.estimate.data = {CellArray};
matlabbatch.spm.spatial.realign.estimate.eoptions.quality = 0.9;
matlabbatch.spm.spatial.realign.estimate.eoptions.sep = 4;
matlabbatch.spm.spatial.realign.estimate.eoptions.fwhm = 5;
matlabbatch.spm.spatial.realign.estimate.eoptions.rtm = 1;
matlabbatch.spm.spatial.realign.estimate.eoptions.interp = 2;
matlabbatch.spm.spatial.realign.estimate.eoptions.wrap = [0 0 0];
matlabbatch.spm.spatial.realign.estimate.eoptions.weight = '';
end

