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
data_info.NumberVolumes.dwi = 79;
% data_info.DWI_Nreadouts = 0.0476

%% Specify Processing Options

Options.Mask = 'Mrtrix'; %Options.Mask = {Mrtrix, Fsl}
Options.DTI_fit = 'Fsl'; %Options.Mask = {Mrtrix, Fsl}
Options.ConvertFormat = 'nii.gz';

%% Initial Setup
mainpath = pwd;
[~,folder_root,~] = fileparts(mainpath);
DicomRootPath = '/home/guilherme/GoogleDrive/Proaction-Lab/Data/Memoria';
addpath(genpath('lib'))

%%

%% Convert dicom files to nifti
[DWIPath,StructuralPath,AllNiftiPaths,AllSubs,data_info] = ConvertDicom2Nifti(DicomRootPath,data_info,Options);

%% top up



%% Eddy current correction
[EddyPath] = EddyCorrectDWI(DWIPath,AllSubs,DicomRootPath,data_info,Options);

%% DTI-FIT
[AllDTIPaths] = FitDTI(EddyPath,DWIPath,AllSubs,DicomRootPath,data_info,Options);


%% FLIRT


%% TBSS
% PrepareForTBSS
[AllTBSS_Paths] = PrepareForTBSS_Glm_2(DicomRootPath,data_info,Options);

% RunTBSS
RunTBSS_Glm(AllTBSS_Paths,Options)







