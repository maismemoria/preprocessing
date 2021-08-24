clear all
close all
clc

%% Specify raw data information(Edit):

data_info.ProjectName = 'Memoria';
data_info.NumberSlices.rs_fMRI = 180;
% NumberOfTemporalPositions = 180;
data_info.NumberSlices.anat = 192;
% LocationsInAcquisition = 192;
data_info.NumberSlices.dwi = 70;

%% Specify Processing Options
Options.Mask = 'Mrtrix'; %Options.Mask = {Mrtrix, Fsl}
Options.DTI_fit = 'Mrtrix'; %Options.Mask = {Mrtrix, Fsl}
Options.ConvertFormat = 'nii.gz';

%% Initial Setup
mainpath = pwd;
[~,folder_root,~] = fileparts(mainpath);
DicomRootPath = '/home/guilherme/GoogleDrive/Proaction-Lab/Data/MemoriaEddy';
addpath(genpath('lib'))

%% GetPaths

[EddyPath,DWIPath,AllSubjs] = GetPaths_fromDicomRoot(DicomRootPath);
delete([DicomRootPath '/*.csv*'])

%% DTI-FIT
[AllDTIPaths] = FitDTI(EddyPath,DWIPath,AllSubjs,DicomRootPath,data_info,Options);

%% FLIRT


%% TBSS
% PrepareForTBSS
% [AllTBSS_Paths] = PrepareForTBSS_Glm(DicomRootPath,data_info);

% RunTBSS
% RunTBSS_Glm(AllTBSS_Paths,Options,mainpath)
