function RemoveEddy_junkFiles(Alleddy_path)


for u = 1:length(Alleddy_path)
    
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_command_txt'],'file')
        delete([Alleddy_path{u} '/eddy.nii.gz.eddy_command_txt'])
    end    
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_movement_rms'],'file')
    delete([Alleddy_path{u} '/eddy.nii.gz.eddy_movement_rms'])
    end
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_outlier_n_sqr_stdev_map'],'file')
    delete([Alleddy_path{u} '/eddy.nii.gz.eddy_outlier_n_sqr_stdev_map'])
    end
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_outlier_n_stdev_map'],'file')
    delete([Alleddy_path{u} '/eddy.nii.gz.eddy_outlier_n_stdev_map'])
    end
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_outlier_report'],'file')
    delete([Alleddy_path{u} '/eddy.nii.gz.eddy_outlier_report'])
    end
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_outlier_map'],'file')
    delete([Alleddy_path{u} '/eddy.nii.gz.eddy_outlier_map'])      
    end
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_parameters'],'file')
    delete([Alleddy_path{u} '/eddy.nii.gz.eddy_parameters'])
    end
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_post_eddy_shell_alignment_parameters'],'file')
    delete([Alleddy_path{u} '/eddy.nii.gz.eddy_post_eddy_shell_alignment_parameters'])
    end
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_post_eddy_shell_PE_translation_parameters'],'file')
    delete([Alleddy_path{u} '/eddy.nii.gz.eddy_post_eddy_shell_PE_translation_parameters'])
    end
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_restricted_movement_rms'],'file')
    delete([Alleddy_path{u} '/eddy.nii.gz.eddy_restricted_movement_rms'])
    end
    if exist([Alleddy_path{u} '/eddy.nii.gz.eddy_values_of_all_input_parameters'],'file')
    delete([Alleddy_path{u} '/eddy.nii.gz.eddy_values_of_all_input_parameters'])
    end
    
end




end