%% An example of (toy) pipeline

% where to generate the outputs of the demo
clear, path_demo = [pwd filesep 'demo_psom' filesep]; 

% Job "sample" :    No input, generate a random vector a
command = 'a = randn([opt.nb_samps 1]); save(files_out,''a'')';
pipeline.sample.command      = command;
pipeline.sample.files_out    = [path_demo 'sample.mat'];
pipeline.sample.opt.nb_samps = 12;

% Job "quadratic" : Compute a.^2 and save the results
command = 'load(files_in); b = a.^2; save(files_out,''b'')';
pipeline.quadratic.command   = command;
pipeline.quadratic.files_in  = pipeline.sample.files_out;
pipeline.quadratic.files_out = [path_demo 'quadratic.mat']; 

% Adding a job "cubic" : Compute a.^3 and save the results
command = 'load(files_in); c = a.^3; save(files_out,''c'')';
pipeline.cubic.command       = command;
pipeline.cubic.files_in      = pipeline.sample.files_out;
pipeline.cubic.files_out     = [path_demo 'cubic.mat']; 

% Adding a job "sum" : Compute a.^2+a.^3 and save the results
command = 'load(files_in{1}); load(files_in{2}); d = b+c, save(files_out,''d'')';
pipeline.sum.command       = command;
pipeline.sum.files_in{1}   = pipeline.quadratic.files_out;
pipeline.sum.files_in{2}   = pipeline.cubic.files_out;
pipeline.sum.files_out     = [path_demo 'sum.mat'];

%%
% opt.path_logs = [path_demo 'logs' filesep]; 
% opt.mode = 'background';
% opt.max_queued = 12;
% psom_run_pipeline(pipeline,opt)
