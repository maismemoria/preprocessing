function [AllDenoisedFiles] = DenoiseData(DWIPath,Options,data_info,AllSubjs,DicomRootPath)

for u = 1:length(DWIPath)
    
    denoiseFile = [DWIPath{u} '/denoised_dwi.' Options.ConvertFormat];    
    noiseFile = [DWIPath{u} '/noise.' Options.ConvertFormat];
    
    AllDenoisedFiles{u} = denoiseFile;
    
    if ~exist(denoiseFile,'file')
        
        dwiFile = [DWIPath{u} '/dwi.' Options.ConvertFormat];
        
        if exist(dwiFile,'file')
            BashCommand = ['dwidenoise ' dwiFile ' ' denoiseFile ' -noise ' noiseFile];
            system(BashCommand)
        end
    end
    
end

nameFile = ['denoised_dwi.' Options.ConvertFormat];
ReportName = 'denoise_dwi';
if DataExists(DWIPath,nameFile,AllSubjs,data_info,ReportName,DicomRootPath)
    disp('-- DWI denoised with success!')    
end