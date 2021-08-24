    
function [flirt_cell,flirtMats] = flirtPSOM(ImgCell,StructuralPath,AllSubs,ImgType)

ref = '/usr/local/fsl/data/standard/MNI152_T1_1mm_brain.nii.gz';

for u = 1:length(ImgCell)
    
    in = ImgCell{u};
    out_name = [AllSubs{u} '_Linear_' ImgType];
    out_linear = fullfile(StructuralPath{u},out_name);    
    omat = fullfile(StructuralPath{u},'LinearTransf.mat');
        
    if ~exist(out_linear,'file')
        fsl_cmd = ['''flirt -in ' in ' -ref ' ref ' -out ' out_linear ' -omat ' omat ''''];
        JobName = ['AnatLinear' num2str(u)];
        pipeline.(JobName).command = ['system(' fsl_cmd ')'];
    end
    
end


if exist('pipeline','var')
    
    opt.path_logs = fullfile(pwd,'Log_LinearAnat');
    opt.mode = 'background';
    opt.max_queued = maxNumCompThreads(10);
    psom_run_pipeline(pipeline,opt)
    
end

for u = 1:length(ImgCell)
    
    out_name = [AllSubs{u} '_Linear_' ImgType];
    out_linear = fullfile(StructuralPath{u},out_name);
    omat = fullfile(StructuralPath{u},'LinearTransf.mat');
    
    if exist(out_linear,'file')
        flirt_cell{u} = out_linear;
    end    

    if exist(omat,'file')
        flirtMats{u} = omat;
    end    
    
end


end
