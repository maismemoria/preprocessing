% setup
Options.ConvertFormat = 'nii.gz';

% Set path
TBSS_Path = '/home/guilherme/GoogleDrive/Proaction-Lab/Data/TBSS-Memoria';
AllTBSS_Paths = GetTBSS_Paths(TBSS_Path);

% RunTBSS
RunTBSS_Glm(AllTBSS_Paths,Options)