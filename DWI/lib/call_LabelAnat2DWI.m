clear
close all
clc

%% Input
mainpath = pwd;
WorkingDir = '/home/guilherme/GoogleDrive/Proaction-Lab/PythonWorkspace/DiffusionDevelop/Test150739/temp/';

StructuralImg = [WorkingDir '1507391anat.nii.gz'];
label = [WorkingDir 'PD1507391_2.nii.gz'];
Bo = [WorkingDir 'b0.nii.gz'];
SubjNum = 1507391;

%%
[output] = LabelAnat2DWI(StructuralImg,Bo,label,SubjNum);