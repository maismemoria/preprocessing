function [SubjsCellArray,OutputPath] = OrganizeData(DataSetup)

cont = 1;

for u = 1:length(DataSetup.SubjIndx)
    
    FolderName = [DataSetup.FixedName num2str(DataSetup.SubjIndx(u))];
    ParentDirContent = dir([DataSetup.datapath]);
    
    for v = 1:length(ParentDirContent)
        
        if strcmp(ParentDirContent(v).name,FolderName)
            
            Subdir = [DataSetup.datapath '/' FolderName];
            
            SubdirContent = dir(Subdir);
            
            if length(SubdirContent) == 3
                Subdir2 = [Subdir '/' SubdirContent(end).name];
            else
                Problem{u} = Subdir;
                continue
            end
            
            Subdir2Content = dir(Subdir2);
            
            for q = 3:length(Subdir2Content)
                
                Subdir3 = [Subdir2 '/' Subdir2Content(q).name];
                
                if strcmp(Subdir2Content(q).name,'MPRAGE')
                    
                    NiftiPath = [Subdir3 '/Nifti'];
                    if ~exist(NiftiPath,'dir')
                        mkdir(NiftiPath)
                    end
                    
                    DicomPath = [Subdir3 '/dcm'];
                    if ~exist(DicomPath,'dir')
                        mkdir(DicomPath)
                    end
                    
                else
                    
                    NiftiPath = [Subdir3 '/Nifti'];
                    if ~exist(NiftiPath,'dir')
                        mkdir(NiftiPath)
                    end
                    
                    DicomPath = [Subdir3 '/dcm'];
                    if ~exist(DicomPath,'dir')
                        mkdir(DicomPath)
                    end
                    
                    SmoothWarpedPath = [Subdir3 '/Smooth'];
                    if ~exist(SmoothWarpedPath,'dir')
                        mkdir(SmoothWarpedPath)
                    end
                    
                    WarpedPath = [Subdir3 '/Warped'];
                    if ~exist(WarpedPath,'dir')
                        mkdir(WarpedPath)
                    end
                end                
                
                ListImages = dir([Subdir3 '/*.' DataSetup.FileExtension]);
%                 NiftiPath
%                 SubjsCellArrayNifti{1,cont}
                [SubjsCellArray{1,cont}] = GetPaths (ListImages,Subdir3);
                OutputPath{1,cont} = NiftiPath;
                
                cont = cont + 1;
                
            end
        end
        
    end
    
end
