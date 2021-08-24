clear all
close all
clc

addpath('lib')

%% Specify Processing Options

Options.Mask = 'Mrtrix'; %Options.Mask = {Mrtrix, Fsl}
Options.DTI_fit = 'Mrtrix'; %Options.Mask = {Mrtrix, Fsl}
Options.ConvertFormat = 'nii.gz';

%%
TBSS_Path = '/media/proactionlab/HD-2Tb/Guilherme/DATA/TBSS-Memoria';
[AllTBSS_Paths] = GetTBSS_Paths (TBSS_Path);

ConfigDesign = MakeConfigDesign(AllTBSS_Paths,'Single-Group-Paired-Difference');
DesignCellMat = GenerateDesignMatrix(ConfigDesign);

% SplitDiffMerge(AllTBSS_Paths,Options,ConfigDesign)

%% Create Design Matrices Manually:

%% Run Randomise:
[AllRandomisePath] = RunRandomise(AllTBSS_Paths,1000);


%% 



