clear all
close all
clc

%% Initial Configurations:
% Set First paths:
addpath('lib')
PathSPM = '/home/guilherme/GoogleDrive/Proaction-Lab/MatlabWorkspace/spm12';
addpath(PathSPM)

mainpath = pwd;
datapath = strsplit(mainpath,'/MatlabWorkspace/TAFP_scripts');
datapath = [datapath{1} '/Data/TAFP'];

% Process Only Subjs with Resting state:
AnoP3_idx = [26, 33, 40,41,43];
CatP3_idx = [25,31,34,45,48,49];
Ctrl_idx = [19,27,35,39];
TAFPT6_idx = [28,29,30,42,44];
SubjIndx = [AnoP3_idx, CatP3_idx, Ctrl_idx, TAFPT6_idx];

% Set Input DataSetup:
DataSetup.datapath = datapath;
DataSetup.SubjIndx = SubjIndx;
DataSetup.FixedName = 'TAFP';
DataSetup.FileExtension = 'IMA';

%% Generate the varibles SubjsCellArray and OutputPath:
[SubjsCellArrayDcm,OutputPath] = OrganizeData(DataSetup);

%% Convert files from dicom to nifti and save in OutputPath:
% ConvertAllSubjsDcm2Nii(SubjsCellArrayDcm,OutputPath)

%% Get Nifti Files:
[SubjsCellArrayNifti,ImageTypeCell,funcSubjsCellNifti, ...
    strucSubjsCellNifti] = GetNiftiFiles(OutputPath);

%% Run Realign Estimate Procedure:
% RealignEstimateAllSubjects(funcSubjsCellNifti)

%% Run Normalize Estimate Write Procedure
[WarpedSubjsCellArray] = NormalizeRealignEstimateAllSubjs(funcSubjsCellNifti,PathSPM);

%% Move Generated Files to appropriate directory:
MoveFiles(WarpedSubjsCellArray,[])
