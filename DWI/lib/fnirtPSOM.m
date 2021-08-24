    
function [fnirt_cell,fnirtMats] = fnirtPSOM(ImgCell,StructuralPath,AllSubs,flirtMats,ImgType)

ref = '/usr/local/fsl/data/standard/MNI152_T1_1mm_brain.nii.gz';

for u = 1:length(ImgCell)
    
    in = ImgCell{u};
    out_name = [AllSubs{u} '_NonLinear_' ImgType];
    out_nonlinear = fullfile(StructuralPath{u},out_name);    
    aff_omat = flirtMats{u};
    
        
    if ~exist(out_nonlinear,'file')
        fsl_cmd = ['''fnirt --in=' in ' --ref=' ref ' --aff=' aff_omat ' --cout=' out_nonlinear ''''];
        JobName = ['AnatNonLinear' num2str(u)];
        pipeline.(JobName).command = ['system(' fsl_cmd ')'];
    end
    
end


if exist('pipeline','var')
    
    opt.path_logs = fullfile(pwd,'Log_NonLinearAnat');
    opt.mode = 'background';
    opt.max_queued = maxNumCompThreads(10);
    psom_run_pipeline(pipeline,opt)
    
end

for u = 1:length(ImgCell)
    
    out_name = [AllSubs{u} '_NonLinear_' ImgType];
    out_nonlinear = fullfile(StructuralPath{u},out_name);
    omat = fullfile(StructuralPath{u},'LinearTransf.mat');
    
    if exist(out_nonlinear,'file')
        fnirt_cell{u} = out_nonlinear;
    end    

    
end

end
