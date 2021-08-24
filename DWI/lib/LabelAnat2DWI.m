function [output] = LabelAnat2DWI(StructuralImg,Bo,label,SubjNum)

%% Convert Anat to DWI:

WorkingDir = fileparts(StructuralImg);

% SkullStripping anat:
disp('SkullStripping ...')
OutBet =  [WorkingDir '/Bet_anat.nii.gz'];
BashCommand1 = ['bet ' StructuralImg ' ' OutBet ' -g -0.3'];
system(BashCommand1)

% Linear transform anat to DWI
disp('Linear Anat to DWI ...')
LinearTransf = [WorkingDir '/anat2DWILinear'];
BashCommand2 = ['flirt -ref ' Bo ' -in ' OutBet ' -omat ' LinearTransf];
system(BashCommand2)

% NonLinear transform anat to DWI
disp('Non-Linear Anat to DWI ...')
NonLinearTransf = [WorkingDir '/anat2DWINonLinear.mat'];
BashCommand3 = ['fnirt --in=' OutBet ' --aff=' LinearTransf ' --cout=' NonLinearTransf ' --config=T1_2_MNI152_2mm'];
system(BashCommand3)

%% Convert Labels to DWI subject space

temp = strsplit(label,'_');
temp = strsplit(temp{2},'.');
LabelNum = temp{1};

WarpedLabels = [WorkingDir '/WarpedLabels_' LabelNum '.nii.gz'];

% Apply nonLinear transformation on label to MNI
disp('Apply warp 1')
BashCommand1 = ['applywarp --ref=' Bo ' --in=' label ' --warp=' NonLinearTransf ' --out=' WarpedLabels];
system(BashCommand1)


%% Fix labels:

FixLabelsPath = [WorkingDir '/FixedLabels'];

if ~exist(FixLabelsPath,'dir')
    mkdir(FixLabelsPath)
end

NiiFile = load_untouch_nii('WarpedLabels.nii.gz');
data = NiiFile.img;

% treshold of 3%
logic = data>= LabelNum/100*3;
data(logic) = LabelNum;

NiiFile.img = data;

save_untouch_nii(NiiFile,[FixLabelsPath '/' SubjNum '_' LabelNum '.nii.gz'])

end
