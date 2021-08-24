function roi_path = GetRoiFromLabel(Image_path,PathToMaskedLabel,labelNum)

WorkDir = fileparts(Image_path);
Out_path = [WorkDir '/' num2str(labelNum) '_ROI.nii.gz'];
roi_path = Out_path;

Command = ['fslmaths ' Image_path ' -mul ' PathToMaskedLabel ' ' Out_path];
system(Command);


end