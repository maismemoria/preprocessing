clear all
close all
clc

addpath('lib')

%% Specify Processing Options
Options.ConvertFormat = 'nii.gz';

%% Setup TBSS working dir
TBSS_Path = '/media/proactionlab/HD-2Tb/Guilherme/DATA/TBSS-Memoria';
[AllTBSS_Paths] = GetTBSS_Paths (TBSS_Path);

%% Extract info
ConfigDesign = MakeConfigDesign(AllTBSS_Paths,'Single-Group-Paired-Difference');

%% Treat data to later compute the statistics
SplitDiffMerge_v2(AllTBSS_Paths,Options,ConfigDesign)

%% Run Randomise:
[AllRandomisePath] = RunRandomise_OneSample_ttest(AllTBSS_Paths,2000);


%% 



