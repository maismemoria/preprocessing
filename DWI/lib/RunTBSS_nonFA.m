

function RunTBSS_nonFA(TBSS_Path)

[AllTBSS_Paths] = GetTBSS_Paths (TBSS_Path);

for u = 1:length(AllTBSS_Paths)
    
    list = ListFoldersNames(AllTBSS_Paths{u});
    
    for v = 1:length(list)
        
        if ~strcmp(list{v},'FA') && ~strcmp(list{v},'origdata') && ~strcmp(list{v},'stats')
            
            TBSS_dir = [AllTBSS_Paths{u}];
            cd(TBSS_dir)
            
            Command = ['tbss_non_FA ' list{v}];
            system(Command)
            
        end
        
        
    end
    
    
end


