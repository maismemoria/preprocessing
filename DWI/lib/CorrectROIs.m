
clear
close all
clc

addpath(genpath('lib'))

mainpath = pwd;
WorkingDir = '/home/guilherme/GoogleDrive/Proaction-Lab/PythonWorkspace/DiffusionDevelop/Test150739/temp';

label = [WorkingDir '/PD1507391_2.nii.gz'];

[temp]=strsplit(label,'_');
temp = strsplit(temp{2},'.');
label_num = str2double(temp{1});

NiiLabel = load_nii(label);
data = NiiLabel.img;
logic = data ~= 0;
data(logic) = label_num;