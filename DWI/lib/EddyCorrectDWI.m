
function [AllEddyPaths] = EddyCorrectDWI(AllDWIPaths,AllSubs,DicomRootPath,data_info,Options)

NumDWI = length(AllDWIPaths);
ext = Options.ConvertFormat;

AllEddyPaths = cell(NumDWI,1);

for u = 1:NumDWI    
   
    DWIPath = AllDWIPaths{u};    
    EddyPath = [DWIPath '/eddy'];
    AllEddyPaths{u} = EddyPath;
    
    if ~exist(EddyPath,'dir')
        mkdir(EddyPath)
    end
    
    % Check if Eddy was already computed
    if length(dir(EddyPath)) == 2
    
        % Make bash Command
        BashCommand = ['eddy_correct ' DWIPath '/dwi.' ext ' '  EddyPath '/eddy_dwi.' ext ' 0'];

        % Compute correction
        o = system(BashCommand);
        
    end
    
end

nameFile = ['eddy_dwi.' Options.ConvertFormat];
ReportName = 'EddyCorrection';

if DataExists(AllEddyPaths,nameFile,AllSubs,data_info,ReportName,DicomRootPath)
    disp('--  Eddy corrected!')
else
   disp('-- Some images were not Eddy processed -- See Report') 
end

end