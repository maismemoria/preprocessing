function [AllDTIPaths] = FitDTI_MaskMrtrix(AllEddyPaths,AllSubs,DicomRootPath,data_info)

NumDWI = length(AllEddyPaths);
ext = data_info.ConvertFormat;
AllDTIPaths = cell(NumDWI,1);


for u = 1:NumDWI
    
    EddyPath = AllEddyPaths{u};
    DTIPath = [EddyPath '/dti'];
    AllDTIPaths{u} = DTIPath;
    
    if ~exist(DTIPath,'dir')
        mkdir(DTIPath)
    end
    
    if length(dir(DTIPath)) == 2
        
        EddyFilename = [EddyPath '/eddy_dwi.' ext];        
        
%         [Maskfile] = ApplyMaskMrtrix(DWIPath,EddyPath,EddyFilename,data_info);
       [Maskfile] = ApplyMaskMrtrix2(EddyPath,EddyFilename,data_info);
        
%         Maskfile = ApplyBet(EddyPath,EddyFilename,data_info);        
        
        if ~exist(DTIPath,'dir')
            mkdir(DTIPath)
        end
        
        DTIfilename = [DTIPath '/dti.' ext];         
        
        % Make bash Command
        BashCommand = ['dtifit -k ' EddyFilename ' -o ' DTIfilename  ...
            ' -m ' Maskfile ' -r ' [EddyPath '/bvecs'] ' -b ' ...
            [EddyPath '/bvals']];
        
        % Fit DTI
        o = system(BashCommand);       
        
    end    
end

nameFile = ['dti_FA.' data_info.ConvertFormat];
ReportName = 'dtiFit';

if DataExists(AllDTIPaths,nameFile,AllSubs,data_info,ReportName,DicomRootPath)
    disp('--  DTI Fitted!')
else
   disp('-- Some images were not processed (DTIFIT) -- See report') 
end

end