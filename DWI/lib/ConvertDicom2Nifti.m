function [AllDWIPaths,AllStructuralPaths,AllNiftiPaths,AllSubjs,data_info] = ConvertDicom2Nifti(DicomRootPath,data_info,Options)

% DicomRootPath : Path with all dicom files for all subjects.


% Clear Reports on dicom root path:
delete([DicomRootPath '/*.csv*'])

ListDirData = dir(DicomRootPath);
contador = 0;
AllDWIPaths = cell(length(ListDirData)-2,1);
AllStructuralPaths = cell(length(ListDirData)-2,1);
AllNiftiPaths = cell(length(ListDirData)-2,1);
AllSubjs = cell(length(ListDirData)-2,1);

for u = 3:length(ListDirData)
    
    contador = contador + 1;
    
    SubjNum = ListDirData(u).name;
    AllSubjs{contador} = SubjNum;
    
    dicomPathSingle = [DicomRootPath '/' SubjNum];
    
    NiftiPath = [dicomPathSingle '/Nifti'];
    
    AllNiftiPaths{contador} = NiftiPath;
    
    if ~exist(NiftiPath,'dir')
        mkdir(NiftiPath)
    end
    
    % Not very Good check if Nifti files were processed:
    if length(dir(NiftiPath)) == 2
        
        out = dicm2nii(dicomPathSingle, NiftiPath, Options.ConvertFormat);
        
        % Make bash command
        %         BashCommand = ['dcm2niix -o ' NiftiPath  ' y ' dicomPathSingle];
        % Convert Dicom to Nifti
        %         o = system(BashCommand);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                  Diffusion Data                    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    DWIPath = [NiftiPath '/DWI'];
    AllDWIPaths{contador} = DWIPath;
    
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
            
            load([NiftiPath '/dcmHeaders.mat'])
            data_info.DWI_Nreadouts = h.(prefix).ReadoutSeconds;
            
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
    AllStructuralPaths{contador} = [StructuralPath '/anat.nii.gz'];
    
    % Check if directory exists
    if ~exist(StructuralPath,'dir')
        % Create directory
        mkdir(StructuralPath)
    end
    
    try
        % Load dicom header file (h):
        load([NiftiPath '/dcmHeaders.mat'])
        data_info.DWI_Nreadouts = h.(prefix).ReadoutSeconds;
    catch erro
        ConversionProblem{contador} = num2str(contador);
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
    
    %%
    
    
end

Make_acqp_index(AllDWIPaths,data_info)

nameFile = ['dwi.' Options.ConvertFormat];
ReportName = 'dwiNiiConversion';
if DataExists(AllDWIPaths,nameFile,AllSubjs,data_info,ReportName,DicomRootPath)
    disp('-- DWI data was converted with success!')
    
else
    disp('-- Some problems occurred while converting dwi dicom files to Nifti! Check Report for details.')
end

nameFile = ['anat.' Options.ConvertFormat];
ReportName = 'anatNiiConversion';
if DataExists(AllStructuralPaths,nameFile,AllSubjs,data_info,ReportName,DicomRootPath)
    disp('-- Structural data was converted with success!')
    
else
    disp('-- Some problems occurred while converting dicom anat files to Nifti! Check Report for details.')
end

end




