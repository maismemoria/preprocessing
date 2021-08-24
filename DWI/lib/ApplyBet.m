function [Maskfile] = ApplyBet(EddyPath,EddyFilename,data_info)

Outputfilename = [EddyPath '/nodif_brain.' data_info.ConvertFormat];
Maskfile = [EddyPath '/nodif_brain_mask.' data_info.ConvertFormat];


if ~exist(Maskfile,'file')
    
    % Make bash command
    BashCommand = ['bet ' EddyFilename ' ' Outputfilename ' -m -n -f 0.5 -g -0.2'];
    o = system(BashCommand);
    
end


end