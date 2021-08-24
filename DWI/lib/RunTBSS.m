
function RunTBSS (TBSS_Path,data_info,mainpath)

cd(TBSS_Path)

%% First step:
BashCommand = ['tbss_1_preproc *.' data_info.ConvertFormat '*'] ;
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

cd(mainpath)

end

