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

%% Non FA tbss
RunTBSS_nonFA(TBSS_Path)
