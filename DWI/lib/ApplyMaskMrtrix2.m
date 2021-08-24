function [Maskfile] = ApplyMaskMrtrix2(EddyPath,EddyFilename,data_info)

Outputfilename = [EddyPath '/nodif_brain.' data_info.ConvertFormat];
% Maskfile = [EddyPath '/nodif_brain_mask.' data_info.ConvertFormat];
Maskfile = Outputfilename;

bvecs = [EddyPath '/bvecs'];
bvals = [EddyPath '/bvals'];

if ~exist(Maskfile,'file')
%     dwi2mask dwi.nii.gz MrtrixMask.nii.gz -fslgrad bvecs bvals
    % Make bash command
    BashCommand = ['dwi2mask ' EddyFilename ' ' Outputfilename ' -fslgrad ' bvecs ' ' bvals];
    o = system(BashCommand);    
end


end
