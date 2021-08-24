clear all
close all
clc

addpath(genpath('lib'))
mainpath = pwd;
%% Specify Processing Options
Options.ConvertFormat = 'nii.gz';

%% Setup TBSS working dir
TBSS_Path = '/media/proactionlab/HD-2Tb/Guilherme/DATA/TBSSv2-Memoria';
[AllTBSS_Paths] = GetTBSS_Paths(TBSS_Path);

%% Extract info
ConfigDesign = MakeConfigDesign(AllTBSS_Paths,'Single-Group-Paired-Difference');

%% Treat data to later compute the statistics
SplitDiffMerge_v2(AllTBSS_Paths,Options,ConfigDesign)

%% Run Randomise Filtered:

% ROIs = {'Fornix', 'CingulumR','CingulumL', 'CingulumHipR','CingulumHipL', 'Uncinate'};
% labelNumVec = [6,35,36,37,38,45,46]; % Fornix, Cingulum R and L, Cingulum Hip R and L, Uncinate
% labelNumVec = [45,46]; Uncinate
% labelNumVec = [37,38]; % Cingulum Hip R and L
% labelNumVec = [3,4,5] Genu, Body, Splenium corpus callosum
% labelNumVec = [41,42] Superior Longitudinal Fasciculus R and L
% labelNumVec = [39,40] % Fornix R and L
% labelNumVec = [1] Middle cerebellar peduncle

Label = 'UNCINATE_RL_';
labelNumVec = [39,40];
clobber = true;
[AllRandomisePath] = RandomiseFilteredRois_PSOM(AllTBSS_Paths,labelNumVec,2000,clobber,Label);

%% Run Randomise Not Filtered:
% [AllRandomisePath] = RandomisePSOM(AllTBSS_Paths,2000);

