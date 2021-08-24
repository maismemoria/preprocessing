function [AllDTIPaths] = FitDTI(AllEddyPaths,AllDWIPath,AllSubs,DicomRootPath,data_info,Options)

% Get Number of diffusion images
NumDWI = length(AllEddyPaths);
% Define type of convertions
ext = Options.ConvertFormat;
% Get all
AllDTIPaths = cell(NumDWI,1);


for u = 1:NumDWI
    
    EddyPath = AllEddyPaths{u};
    DWIPath = AllDWIPath{u};    
    DTIPath = [EddyPath '/dti'];
    AllDTIPaths{u} = DTIPath;
    
    if ~exist(DTIPath,'dir')
        mkdir(DTIPath)
    end
    
    if length(dir(DTIPath)) == 2
        
        EddyFilename = [EddyPath '/eddy_dwi.' ext];                
        Maskfile = ApplyMask(EddyPath,EddyFilename,Options);

        if ~exist(DTIPath,'dir')
            mkdir(DTIPath)
        end
        
        DTIfilename = [DTIPath '/dti.' ext];    
        
        switch Options.DTI_fit
            
            case 'Fsl'
        
                % Make bash Command
                BashCommand = ['dtifit -k ' EddyFilename ' -o ' DTIfilename  ...
                    ' -m ' Maskfile ' -r ' [DWIPath '/bvecs'] ' -b ' ...
                    [DWIPath '/bvals'] ' --save_tensor'];

                % Fit DTI
                o = system(BashCommand);       
                
            case 'Mrtrix'
                
                % Make bash Command
                BashCommand = ['dwi2tensor ' EddyFilename ' ' DTIfilename  ...
                    ' -mask ' Maskfile ' -fslgrad ' [DWIPath '/bvecs'] ' ' ...
                    [DWIPath '/bvals']];

%                 BashCommand = ['dwi2tensor ' EddyFilename ' ' DTIfilename  ...
%                      ' -fslgrad ' [DWIPath '/bvecs'] ' ' ...
%                     [DWIPath '/bvals']];

                % Fit Kurtosis Tensor
                o = system(BashCommand);       
                
                FAfilename = [DTIPath '/dti_FA.' ext];    
                
                % Make bash Command
                BashCommand = ['tensor2metric ' DTIfilename ' -fa ' FAfilename];
                % Fit Kurtosis Tensor
                o = system(BashCommand);       
                
                
                

    end    
    end
end

nameFile = ['dti_FA.' Options.ConvertFormat];
ReportName = 'dtiFit';

if DataExists(AllDTIPaths,nameFile,AllSubs,data_info,ReportName,DicomRootPath)
    disp('--  DTI Fitted!')
else
   disp('-- Some images were not processed (DTIFIT) -- See report') 
end

end