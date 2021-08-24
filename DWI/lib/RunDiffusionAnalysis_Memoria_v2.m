clear all
close all
clc

addpath('lib')

%% Specify Processing Options

Options.ConvertFormat = 'nii.gz';

%%
TBSS_Path = '/media/proactionlab/HD-2Tb/Guilherme/DATA/TBSS-Memoria';
[AllTBSS_Paths] = GetTBSS_Paths (TBSS_Path);

ConfigDesign = MakeConfigDesign(AllTBSS_Paths,'Single-Group-Paired-Difference');
% [DesignCellMat,ContrastCell] = GenerateDesignMatrix(ConfigDesign);
% GenerateDesignFSL(ConfigDesign,DesignCellMat,ContrastCell)


SplitDiffMerge_v2(AllTBSS_Paths,Options,ConfigDesign)

%% Run Randomise:
[AllRandomisePath] = RunRandomise_OneSample_ttest(temp,2000);


%% 



