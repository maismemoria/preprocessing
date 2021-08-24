


function [OutCell] = matlab_applywarp(ref,ImgCell,WarpNiiCell,AllSubs,ImgType)

if isempty(ref)
    ref = '/usr/local/fsl/data/standard/MNI152_T1_1mm_brain.nii.gz';
end

for u = 1:length(ImgCell)
        
    in = ImgCell{u};
    
    [fd,~,~] = fileparts(in);
    
    WarpNii = WarpNiiCell{u};
    
    outputName = fullfile(fd,[AllSubs{u} '_' ImgType '_NonLinearTransformed.nii.gz']);
    
    if exist(outputName,'file')
    BashCommand1 = ['applywarp --ref=' ref ' --in=' in ' --warp=' WarpNii ' --out=' outputName];
    system(BashCommand1)
    end
    
end