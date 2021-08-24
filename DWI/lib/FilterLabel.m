function [PathToMaskedLabel] = FilterLabel(pathToLabel,Mask_path,labelNum)

WorkDir = fileparts(pathToLabel);
Out_path = [WorkDir '/' num2str(labelNum) '_LabelFilter.nii.gz'];
PathToMaskedLabel = Out_path;

Command = ['fslmaths ' pathToLabel ' -mas ' ...
    Mask_path ' -bin ' Out_path];

system(Command);
end