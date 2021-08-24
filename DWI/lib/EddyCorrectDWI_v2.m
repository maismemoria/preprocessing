
function [AllEddyPaths] = EddyCorrectDWI_v2(AllDWIPaths,AllSubs,DicomRootPath,data_info,Options)

NumDWI = length(AllDWIPaths);
ext = Options.ConvertFormat;

AllEddyPaths = cell(NumDWI,1);

for u = 1:NumDWI    
    
    disp([num2str(u) '/' num2str(NumDWI)])
   
    DWIPath = AllDWIPaths{u};    
    EddyPath = [DWIPath '/eddy']
    disp([num2str(u) '/' num2str(NumDWI)])
    AllEddyPaths{u} = EddyPath;
    
    if ~exist(EddyPath,'dir')
        mkdir(EddyPath)
    end
    
    % Check if Eddy was already computed
    if length(dir(EddyPath)) == 2
    
        % Make bash Command
        
        BashCommand = ['eddy_openmp --imain=' DWIPath '/denoised_dwi.' ext ...
           ' --mask=' DWIPath '/nodif_brain.' ext ' --bvecs=' DWIPath '/bvecs' ...
           ' --bvals=' DWIPath '/bvals' ' --out=' EddyPath '/eddy.' ext ...
           ' --index=' DWIPath '/index.txt --acqp=' DWIPath '/acqparams.txt'];
        
%         BashCommand = ['eddy_correct ' DWIPath '/dwi.' ext ' '  EddyPath '/eddy_dwi.' ext ' 0'];

        % Compute correction
        o = system(BashCommand);
        
    end
    
end

RemoveEddy_junkFiles(AllEddyPaths)

nameFile = ['eddy.' Options.ConvertFormat];
ReportName = 'EddyCorrection';

if DataExists(AllEddyPaths,nameFile,AllSubs,data_info,ReportName,DicomRootPath)
    disp('--  Eddy corrected!')
else
   disp('-- Some images were not Eddy processed -- See Report') 
end

end