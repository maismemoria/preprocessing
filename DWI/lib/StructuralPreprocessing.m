
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
DicomRootPath = ['/media/proactionlab/HD-2Tb/Guilherme/ProactionLab/MatlabWorkspace/Memoria_scripts_develop/PreprocessingPipeline/Data'];
addpath(genpath('lib'))

%% Convert dicom files to nifti
[DWIPath,StructuralPath,AllNiftiPaths,AllSubs,data_info] = ConvertDicom2Nifti(DicomRootPath,data_info,Options);

%% Pre process Structural files
[WM_cell, GM_cell, CSF_cell, T1_MNI_cell] = StructPreprocPSOM(StructuralPath,AllNiftiPaths);

% %% Estimate linear transformation
% ImgType = 'WM';
% [flirt_cell,flirtMats] = flirtPSOM(WM_cell,StructuralPath,AllSubs,ImgType);
% 
% %% Estimate nonLinear transformation
% [fnirt_cell,fnirtMats] = fnirtPSOM(WM_cell,StructuralPath,AllSubs,ImgType);
% 
% %% Apply Non Linear transformation (warp)
% [OutCell] = matlab_applywarp([],WM_cell,fnirt_cell,AllSubs,ImgType)



