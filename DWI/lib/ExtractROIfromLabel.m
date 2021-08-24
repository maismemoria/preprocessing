

function [pathToLabel] = ExtractROIfromLabel(Image_path,label_image_path,labelNum)

pathDir = fileparts(Image_path);

output_path = [pathDir '/' labelNum '.nii.gz'];
pathToLabel = output_path;
Command = ['fslmaths ' label_image_path ' -thr ' labelNum ' -uthr ' labelNum ' -bin ' output_path];
system(Command)

end