
function RunTBSS_Glm_v2(AllTBSS_Paths,Options)

for u = 1:length(AllTBSS_Paths)
   
    cd(AllTBSS_Paths{u})
    
    %% First step:
    BashCommand = ['tbss_1_preproc *.' Options.ConvertFormat '*'] ;
    system(BashCommand)
    
    %% Second step:
    BashCommand = 'tbss_2_reg -T';
    system(BashCommand)
    
    %% Third step:
    BashCommand = 'tbss_3_postreg -S';
    system(BashCommand)
    
    %% Fourth step:
    BashCommand = 'tbss_4_prestats 0.2';
    system(BashCommand)
            
end
end
