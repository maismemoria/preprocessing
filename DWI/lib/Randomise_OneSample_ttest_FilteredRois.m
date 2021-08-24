function [AllRandomisePath] = Randomise_OneSample_ttest_FilteredRois(AllTBSS_Paths,labelNumVec,NumPerm)

% See for details: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/GLM#Single-Group_Paired_Difference_.28Paired_T-Test.29
% Randomise details

for u = 1:length(AllTBSS_Paths)    
    u
           
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
                
        Image_path2 = [AllRandomisePath{u} '/' List(qq).name];
        label_image_path = ['/usr/local/fsl/data/atlases/JHU/JHU-ICBM-labels-1mm.nii.gz'];
                        
        [TargetMask] = CreateTagetMasks_memoria(Image_path2,label_image_path,mask_path,labelNumVec,Type);
        
        %% Run Randomise
        
        tbssName = [Type '_tbss'];
        tbss_path = [AllRandomisePath{u} '/' tbssName '_tstat1.nii.gz'];
        
        if ~exist(tbss_path,'file')
            
            BashCommand = ['randomise -i ' List(qq).name ' -o ' tbssName  ...
                ' -m ' TargetMask ' -1 -v 5 ' ...
                '--T2 -n ' num2str(NumPerm)];
            
            system(BashCommand)
        end
    end
    
    
end