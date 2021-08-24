
%% Initial Configurations:

% Set First paths:
mainpath = pwd;
datapath = strsplit(mainpath,'/MatlabWorkspace/TAFP_scripts');
datapath = [datapath{1} '/Data/TAFP'];

% Process Only Subjs with Resting state:
AnoP3_idx = [26, 33, 40,41,43];
CatP3_idx = [25,31,34,45,48,49];
Ctrl_idx = [19,27,35,39];
TAFPT6_idx = [28,29,30,42,44];
SubjIndx = [AnoP3_idx, CatP3_idx, Ctrl_idx, TAFPT6_idx];

% Set Input DataSetup:
DataSetup.datapath = datapath;
DataSetup.SubjIndx = SubjIndx;
