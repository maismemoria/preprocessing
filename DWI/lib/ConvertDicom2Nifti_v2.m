function [AllDWIPaths,AllStructuralPaths,AllNiftiPaths,AllSubjs] = ConvertDicom2Nifti_v2(DicomRootPath,data_info,Options)

% DicomRootPath : directoru path with all dicom files for all subjects.

% Clear Reports on dicom root path:
delete([DicomRootPath '/*.csv*'])

ListDirData = ListFoldersNames(DicomRootPath);
AllDWIPaths = cell(length(ListDirData)-2,1);
AllStructuralPaths = cell(length(ListDirData)-2,1);
AllNiftiPaths = cell(length(ListDirData)-2,1);
AllSubjs = cell(length(ListDirData)-2,1);

for u = 1:length(ListDirData)
            
    SubjNum = ListDirData{u};
    AllSubjs{u} = SubjNum;
    
    dicomPathSingle = [DicomRootPath '/' SubjNum];
    
    NiftiPath = [dicomPathSingle '/Nifti'];
    
    AllNiftiPaths{u} = NiftiPath;
    
    if ~exist(NiftiPath,'dir')
        mkdir(NiftiPath)
    end
    
    % Check if Nifti files were processed:
    if isempty(ListFoldersNames(NiftiPath))        
        out = dicm2nii(dicomPathSingle, NiftiPath, Options.ConvertFormat);        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                  Diffusion Data                    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    DWIPath = [NiftiPath '/DWI'];
    AllDWIPaths{u} = DWIPath;
    
    % Find out which nifti images are DWI
    ListDWIfiles = dir([NiftiPath '/*.bvec*']);
    
    if ~isempty(ListDWIfiles)
        
        % Finds prefix of all dwi files
        for v = 1:length(ListDWIfiles)
            
            % Get file parts
            [fold,prefix,~] = fileparts(ListDWIfiles(v).name);
            
            % List all images with that prefix
            ListPrefix = dir([NiftiPath '/*' prefix '*']);
            
            % Check if directory exists
            if ~exist(DWIPath,'dir')
                % Create directory
                mkdir(DWIPath)
            end
            
            
            for t = 1:length(ListPrefix)
                
                % Not very Good check if DWI files were copy:
                if length(dir(DWIPath)) < 5
                    
                    % Get file parts
                    [~,~,ext] = fileparts([NiftiPath '/' ListPrefix(t).name]);
                    
                    switch ext
                        case '.bval'
                            % Move file
                            movefile([NiftiPath '/' ListPrefix(t).name],[DWIPath '/bvals'])
                            
                        case '.bvec'
                            % Move file
                            movefile([NiftiPath '/' ListPrefix(t).name],[DWIPath '/bvecs'])
                            
                        case '.nii'
                            % Move file
                            movefile([NiftiPath '/' ListPrefix(t).name],[DWIPath '/dwi' ext])
                            
                        case '.gz'
                            % Move file
                            movefile([NiftiPath '/' ListPrefix(t).name],[DWIPath '/dwi.nii' ext])
                            
                    end
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                  Structural Data                    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    StructuralPath = [NiftiPath '/Structural'];
    AllStructuralPaths{u} = StructuralPath;
    
    % Check if directory exists
    if ~exist(StructuralPath,'dir')
        % Create directory
        mkdir(StructuralPath)
    end
    
    try
        % Load dicom header file (h):
        load([NiftiPath '/dcmHeaders.mat'])
    catch erro
        ConversionProblem{u} = num2str(u);
        continue
    end
    ConversionProblem{u} = 'None';
    
    % Get fields from dicom header
    Fields1 = fieldnames(h);
    
    % Iterate over nii structures
    for t = 1:length(Fields1)
        
        % Nii structure
        StructImg = h.(Fields1{t});
        
        % Get fields name
        Fields2 = fieldnames(StructImg);
        
        % Iterate over fields
        for v = 1:length(Fields2)
            if ischar(Fields2{v})
                if length(dir(StructuralPath)) < 3
                    if strcmp(Fields2{v},'LocationsInAcquisition')
                        if StructImg.(Fields2{v}) == data_info.NumberSlices.anat
                            %%%%
                            StructuralFile = [NiftiPath '/' Fields1{t} '.' Options.ConvertFormat];
                            movefile(StructuralFile,[StructuralPath '/anat.' Options.ConvertFormat])
                            
                        end
                    end
                end
            end
        end
    end
    
    
    %% Delete remaining files:    
    delete ([NiftiPath '/*.nii*'])  
  
end

nameFile = ['dwi.' Options.ConvertFormat];
ReportName = 'dwiNiiConversion';
if DataExists(AllDWIPaths,nameFile,AllSubjs,data_info,ReportName,DicomRootPath)
    disp('-- DWI data was converted with success!')
end

nameFile = ['anat.' Options.ConvertFormat];
ReportName = 'anatNiiConversion';
if DataExists(AllStructuralPaths,nameFile,AllSubjs,data_info,ReportName,DicomRootPath)
   disp('-- Structural data was converted with success!')
end 

end




