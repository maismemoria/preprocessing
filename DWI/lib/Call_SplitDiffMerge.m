
%% Specify raw data information(Edit):

data_info.ProjectName = 'Memoria';
data_info.NumberSlices.rs_fMRI = 180;
% NumberOfTemporalPositions = 180;
data_info.NumberSlices.anat = 192;
% LocationsInAcquisition = 192;
data_info.NumberSlices.dwi = 70;

%% Specify Processing Options

Options.Mask = 'Mrtrix'; %Options.Mask = {Mrtrix, Fsl}
Options.DTI_fit = 'Mrtrix'; %Options.Mask = {Mrtrix, Fsl}
Options.ConvertFormat = 'nii.gz';

%%


%% 
addpath('lib')
TBSS_Path = '/home/guilherme/GoogleDrive/Proaction-Lab/Data/TBSS-Memoria';
[AllTBSS_Paths] = GetTBSS_Paths (TBSS_Path);

SplitDiffMerge(AllTBSS_Paths,Options,ConfigDesign)