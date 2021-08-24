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
data_info.DWI_Nreadouts = 0.0476;

%% Specify Processing Options

Options.Mask = 'Mrtrix'; %Options.Mask = {Mrtrix, Fsl}
Options.DTI_fit = 'Fsl'; %Options.Mask = {Mrtrix, Fsl}
Options.ConvertFormat = 'nii.gz';

%% Initial Setup
mainpath = pwd;
DicomRootPath = ['/media/proactionlab/HD-2Tb/Guilherme/DATA/Memoria'];
addpath(genpath('lib'))

%% Convert dicom files to nifti
[DWIPath,StructuralPath,AllNiftiPaths,AllSubs,data_info] = ConvertDicom2Nifti(DicomRootPath,data_info,Options);

%% Denoise data
[AllDenoisedFiles] = DenoiseData(DWIPath,Options,data_info,AllSubs,DicomRootPath);

%% Mask data
[AllMaskFiles] = ApplyMask_v2(DWIPath,Options,data_info,AllSubs,DicomRootPath);

%% top up


%% Eddy current correction
[EddyPath] = EddyCorrectDWI_v2(DWIPath,AllSubs,DicomRootPath,data_info,Options);

%% DTI-FIT
[AllDTIPaths,AllFAPaths] = FitDTI_v2(EddyPath,DWIPath,AllMaskFiles,AllSubs,DicomRootPath,data_info,Options);

%% Transform atlas in standard space to subject space - Aiming tractography analysis
% [AllLabelPaths,AllT1Bet] = Atlas2SubjectSpace(AllFAPaths,StructuralPath,Options);

%% TBSS
% PrepareForTBSS
[AllTBSS_Paths] = PrepareForTBSS_Glmv2(DicomRootPath,data_info,Options);

% RunTBSS
RunTBSS_Glm_v2_nFlag(AllTBSS_Paths,Options)


% RunTBSS - non FA
% TBSS_Path = '/media/proactionlab/HD-2Tb/Guilherme/DATA/TBSS-Memoria';
% RunTBSS_nonFA(TBSS_Path)





