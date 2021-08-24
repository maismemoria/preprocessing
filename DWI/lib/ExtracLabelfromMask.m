function [pathToLabel] = ExtracLabelfromMask(Image_path,label_image_path,labelNum)

WorkDir = fileparts(Image_path);
Out_path = [WorkDir '/' num2str(labelNum) '_Label.nii.gz'];
pathToLabel = Out_path;

Command = ['fslmaths ' label_image_path ' -thr ' num2str(labelNum)  ' -uthr ' num2str(labelNum) ...
    ' -bin ' Out_path];

system(Command);

end