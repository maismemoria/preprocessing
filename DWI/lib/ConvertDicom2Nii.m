
function [matlabbatch] = ConvertDicom2Nii(CellArray,OutputPath)


%% Convert Dicom to nifti:
%CellArray => cell(NumberOfdcmImagesPerSubject,1)

matlabbatch.spm.util.import.dicom.data = CellArray;
matlabbatch.spm.util.import.dicom.root = 'flat';
matlabbatch.spm.util.import.dicom.outdir = {OutputPath};
matlabbatch.spm.util.import.dicom.protfilter = '.*';
matlabbatch.spm.util.import.dicom.convopts.format = 'nii';
matlabbatch.spm.util.import.dicom.convopts.meta = 0;
matlabbatch.spm.util.import.dicom.convopts.icedims = 0;

end

