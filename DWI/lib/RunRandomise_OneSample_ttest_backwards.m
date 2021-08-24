function [AllRandomisePath] = RunRandomise_OneSample_ttest_backwards(AllTBSS_Paths,NumPerm)

% See for details: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/GLM#Single-Group_Paired_Difference_.28Paired_T-Test.29
% Randomise details

for u = length(AllTBSS_Paths):-1:1
    
    u
           
    AllRandomisePath{u} = [AllTBSS_Paths{u} '/stats'];    
    List = dir([AllRandomisePath{u} '/*G1-G2*']);
    
    for qq = 1:length(List)
        
        cd (AllRandomisePath{u});
        temp = split(List(qq).name,'_');
        tbssName = [temp{1} '_tbss'];
        tbss_path = [AllRandomisePath{u} '/' tbssName '_tstat1.nii.gz'];
        
        if ~exist(tbss_path,'file')
            
            BashCommand = ['randomise -i ' List(qq).name ' -o ' tbssName  ...
                ' -m mean_FA_skeleton_mask.nii.gz -1 -v 5 ' ...
                '--T2 -n ' num2str(NumPerm)];
            
            system(BashCommand)
        end
    end
    
    
end