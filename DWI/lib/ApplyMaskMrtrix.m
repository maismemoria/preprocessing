function [Maskfile] = ApplyMaskMrtrix(DWIPath,EddyPath,EddyFilename,data_info)

Outputfilename = [EddyPath '/nodif_brain.' data_info.ConvertFormat];
Maskfile = [EddyPath '/nodif_brain_mask.' data_info.ConvertFormat];

bvecs = [DWIPath '/bvecs'];
bvals = [DWIPath '/bvals'];

if ~exist(Maskfile,'file')
    % Make bash command
    BashCommand = ['dwi2mask ' EddyFilename ' ' Outputfilename ' -fslgrad ' bvecs ' ' bvals];
    o = system(BashCommand);
    
end


end