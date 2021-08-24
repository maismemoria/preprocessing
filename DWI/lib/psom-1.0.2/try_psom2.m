
clear 
clc

jobs = {'d1','d2','d3','d4','d5'};

for u = 1:length(jobs)   
    
    command = 'Mat = rand(3000); [a,b] = eig(Mat);';    
    pipeline.(jobs{u}).command = command;
    
end

opt.path_logs = [pwd '/eigs/logs' filesep];
opt.mode = 'background';
opt.max_queued = maxNumCompThreads();
psom_run_pipeline(pipeline,opt)


