function [AllRandomisePath] = RunRandomise(AllTBSS_Paths,NumPerm)

for u = 1:length(AllTBSS_Paths)
    
    u
    
    AllRandomisePath{u} = [AllTBSS_Paths{u} '/stats'];
    
    if isempty(dir([AllRandomisePath{u} '/*tbss*']))
    
        cd (AllRandomisePath{u});

        BashCommand = ['randomise -i all_FA_skeletonised.nii.gz -o tbss ' ...
            '-m mean_FA_skeleton_mask.nii.gz -d design.mat -t design.con ' ...
            '--T2 -n ' num2str(NumPerm)];

        system(BashCommand)
    end
    
end
