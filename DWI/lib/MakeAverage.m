function [mask_path] = MakeAverage(Image_path,Type)

path_folder=fileparts(Image_path);
output_path = [path_folder '/' 'mean_' Type '_skeleton.nii.gz' ];
mask_path = output_path;

if ~exist(output_path,'file')
    Command = ['fslmaths ' Image_path ' -Tmean ' output_path  ];
    system(Command);
end

end