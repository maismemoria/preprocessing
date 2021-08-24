
function [WM_cell, GM_cell, CSF_cell, T1_MNI_cell] = StructPreprocPSOM(StructuralPath,AllNiftiPaths)


for u = 1:length(AllNiftiPaths)
    
    NiiPath = AllNiftiPaths{u};
    OutputPathName = 'StructuralProc.anat';
    [fd,~,~] = fileparts(StructuralPath{u});
    FdName = fullfile(fd, 'StructuralProc');
    
    GenPath = fullfile(NiiPath,OutputPathName);
    
    if ~exist(GenPath,'dir')
        fsl_cmd = ['''fsl_anat -i ' StructuralPath{u} ' -o ' FdName ''''];
        JobName = ['AnatProc' num2str(u)];
%         eval(['system(' fsl_cmd ')'])
        pipeline.(JobName).command = ['system(' fsl_cmd ')'];
    end
end



if exist('pipeline','var')
    
    opt.path_logs = fullfile(pwd,'Log_Anat');
    opt.mode = 'background';
    opt.max_queued = maxNumCompThreads(10);
    psom_run_pipeline(pipeline,opt)
    
end

for u = 1:length(AllNiftiPaths)
    WM_name = 'T1_fast_pve_2';
    WM_path = fullfile(GenPath,WM_name);
    
    if exist(WM_path,'file')
        WM_cell{u} = WM_path;
    end
    
    GM_name = 'T1_fast_pve_1';
    GM_path = fullfile(GenPath,GM_name);
    
    if exist(GM_path,'file')
        GM_cell{u} = GM_path;
    end
    
    CSF_name = 'T1_fast_pve_0';
    CSF_path = fullfile(GenPath,CSF_name);
    
    if exist(CSF_path,'file')
        CSF_cell{u} = CSF_path;
    end
    
    T1_MNI_name = 'T1_to_MNI_nonlin';
    T1_MNI_path = fullfile(GenPath,T1_MNI_name);
    
    if exist(T1_MNI_path,'file')
        T1_MNI_cell{u} = T1_MNI_path;
    end    
    
end

end