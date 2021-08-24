function AllMaskFiles = ApplyMask_v2(AllDWIPath,Options,data_info,AllSubs,DicomRootPath)

for u = 1:length(AllDWIPath)
    
    DWIPath = AllDWIPath{u};        
    Inputfilename = [DWIPath '/denoised_dwi.' Options.ConvertFormat];
    Outputfilename = [DWIPath '/nodif_brain.' Options.ConvertFormat];        
    
    AllMaskFiles{u} = Outputfilename;
    
    bvecs = [DWIPath '/bvecs'];
    bvals = [DWIPath '/bvals'];
    
    if ~exist(Outputfilename,'file')
        if exist(Inputfilename,'file')
            % Make bash command
            BashCommand = ['dwi2mask ' Inputfilename ' ' Outputfilename ' -fslgrad ' bvecs ' ' bvals];
            o = system(BashCommand);

        end
    end
end

nameFile = ['nodif_brain.' Options.ConvertFormat];
ReportName = 'Mask_dwi';
if DataExists(AllDWIPath,nameFile,AllSubs,data_info,ReportName,DicomRootPath)
    disp('-- DWI masked with success!')    
end
end