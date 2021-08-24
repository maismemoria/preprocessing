function [AllRandomisePath] = RandomisePSOM(AllTBSS_Paths,NumPerm)

% See for details: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/GLM#Single-Group_Paired_Difference_.28Paired_T-Test.29
% Randomise detailsRandomise_OneSample_ttest_FilteredRois_PSOM

for u = 1:length(AllTBSS_Paths)
    u
    
    temp = strsplit(AllTBSS_Paths{u},'/');
    Job1 = [temp{end-1} '-' temp{end}];
    Job1 = strrep(Job1,'-','');
    
    AllRandomisePath{u} = [AllTBSS_Paths{u} '/stats'];
    List = dir([AllRandomisePath{u} '/*G1-G2*']);
    
    for qq = 1:length(List)
        
        cd (AllRandomisePath{u});
        temp = split(List(qq).name,'_');
        Type = temp{1};
        
        %% Create Average skeleton
        
        Image_path = [AllRandomisePath{u} '/all_' Type '_skeletonised.nii.gz'];
        
        if exist(Image_path,'file')
            mask_path = [AllRandomisePath{u} '/mean_' Type '_skeleton.nii.gz'];
            if ~exist(mask_path,'file')
                [mask_path] = MakeAverage(Image_path,Type);
            end
        else
            disp('Problem with all_skeletonized image. Check if the path for the file exists.')
        end
        
        %% Create Target Masks for randomise
        
        [TargetMask] = mask_path;
        
        %% Run Randomise
        
        tbssName = [Type '_Notfiltered_tbss'];
        tbss_path = [AllRandomisePath{u} '/' tbssName '_tstat1.nii.gz'];
        in=[AllRandomisePath{u} '/' List(qq).name];
        
        if ~exist(tbss_path,'file')
            
            
            BashCommand = ['''randomise -i ' in ' -o ' tbss_path  ...
                ' -m ' TargetMask ' -1 -v 5 ' ...
                '--T2 -n ' num2str(NumPerm) ''''];
            
            JobName = [Job1 Type];
            pipeline.(JobName).command = ['system(' BashCommand ')'];
            
            
        end
        
        
        
    end
    
end

opt.path_logs = ['/media/proactionlab/HD-2Tb/Guilherme/ProactionLab/MatlabWorkspace/Memoria_scripts_develop/PreprocessingPipeline/logs' filesep];
opt.mode = 'background';
opt.max_queued = maxNumCompThreads();
psom_run_pipeline(pipeline,opt)

end
