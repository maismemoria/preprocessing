function [Outputfilename] = ApplyMask(EddyPath,EddyFilename,Options)

Outputfilename = [EddyPath '/nodif_brain.' Options.ConvertFormat];
% Maskfile = [EddyPath '/nodif_brain_mask.' Options.ConvertFormat];

switch Options.Mask
    
    case 'Fsl'        
        
        if ~exist(Outputfilename,'file')            
            % Make bash command
%             BashCommand = ['bet ' EddyFilename ' ' Outputfilename ' -m -n -f 0.5 -g -0.2'];
            BashCommand = ['bet ' EddyFilename ' ' Outputfilename ' -m -n'];
            o = system(BashCommand);            
        end

    case 'Mrtrix'
        
        DWIPath = fileparts(EddyPath);
        
        bvecs = [DWIPath '/bvecs'];
        bvals = [DWIPath '/bvals'];
        
        if ~exist(Outputfilename,'file')
            % Make bash command
            BashCommand = ['dwi2mask ' EddyFilename ' ' Outputfilename ' -fslgrad ' bvecs ' ' bvals];
            o = system(BashCommand);
            
        end


end