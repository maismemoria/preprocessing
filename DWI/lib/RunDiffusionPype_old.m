clear all
close all
clc

%% Specify (Edit):

data_info.ProjectName = 'Memoria';
data_info.NumberSlices.rs_fMRI = 180;
% NumberOfTemporalPositions = 180;
data_info.NumberSlices.anat = 192;
% LocationsInAcquisition = 192;
data_info.NumberSlices.dwi = 70;
data_info.ConvertFormat = 'nii.gz';


%% Initial Setup
mainpath = pwd;
[~,folder_root,~] = fileparts(mainpath);
DicomRootPath = replace(mainpath,['MatlabWorkspace/' folder_root],['Data/' data_info.ProjectName]);
addpath(genpath('lib'))


%% Convert dicom files to nifti
[DWIPath,StructuralPath,AllNiftiPaths,AllSubs] = ConvertDicom2Nifti(DicomRootPath,data_info);


%% top up
% Can not be applied due to restrictions in the acquisition: There is only
% one phase encoding direction


%% Eddy current correction
[EddyPath] = EddyCorrectDWI(DWIPath,AllSubs,DicomRootPath,data_info);

%% DTI-FIT
[AllDTIPaths] = FitDTI(EddyPath,DWIPath,AllSubs,DicomRootPath,data_info);


%% FLIRT


%% TBSS
% PrepareForTBSS
% [TBSS_Path] = PrepareForTBSS(DicomRootPath,data_info);

% RunTBSS
% RunTBSS (TBSS_Path,data_info,mainpath)







