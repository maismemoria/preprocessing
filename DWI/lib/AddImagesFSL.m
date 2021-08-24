
function AddedImgPath = AddImagesFSL(input_img_cell1,Type)

accumulate_cmd = [];

for u = 1:length(input_img_cell1)
       
    if u ~= length(input_img_cell1)
    
        img = input_img_cell1{u};
        cmd = [img ' -add '];
        accumulate_cmd = [accumulate_cmd cmd];    
    else       
        img = input_img_cell1{u};
        cmd = [img];
        accumulate_cmd = [accumulate_cmd cmd];        
    end
    
end

[directory] = fileparts(img);
outputName = [directory '/' Type '_Target_mask.nii.gz'];
AddedImgPath = outputName;
BashCommand = ['fslmaths ' accumulate_cmd ' ' outputName];
system(BashCommand)


end