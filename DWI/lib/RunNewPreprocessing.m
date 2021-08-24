clear all
close all
clc

%% Initial Configurations:
% Set First paths:
addpath('lib')
PathSPM = '/home/guilherme/GoogleDrive/Proaction-Lab/MatlabWorkspace';
addpath(PathSPM)

mainpath = pwd;
datapath = strsplit(mainpath,'/MatlabWorkspace/TAFP_scripts');
datapath = [datapath{1} '/Data/TAFP'];

% Process Only Subjs with Resting state:
SubjIndx = [26, 33, 40, 41, 43, 47, 52,  ...
    25, 31, 34, 45, 48, 49, 50, ...
    19, 21, 23, 27, 35, 37, ...
    28, 30, 42, 44, 51];

% Set Input DataSetup:
DataSetup.datapath = datapath;
DataSetup.SubjIndx = SubjIndx;
DataSetup.FixedName = 'TAFP';
DataSetup.FileExtension = 'IMA';

%% Generate the varibles SubjsCellArray and OutputPath:
[SubjsCellArrayDcm,OutputPath] = OrganizeData(DataSetup);

%% Convert files from dicom to nifti and save in OutputPath:
ConvertAllSubjsDcm2Nii(SubjsCellArrayDcm,OutputPath)

%% Get Nifti Files:
[SubjsCellArrayNifti,ImageTypeCell,funcSubjsCellNifti, ...
    strucSubjsCellNifti] = GetNiftiFiles(OutputPath);

%%
NfuncMRI = length(funcSubjsCellNifti);
Nsubjs = length(strucSubjsCellNifti);

for n = 1:Nsubjs
    
    for u = 1:(NfuncMRI/Nsubjs)
        
        FuncMRI = funcSubjsCellNifti{u};
        StructuralMRI = strucSubjsCellNifti{n};        

        [matlabbatch] = Realign_StrucProc_Coreg_Normalize_Smooth(FuncMRI,StructuralMRI,PathSPM);
    
    end
end
