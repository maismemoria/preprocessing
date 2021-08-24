
function [TargetMask] = CreateTargetMasks_memoria(Image_path,label_image_path,Mask_path,labelNumVec,Type,Clobber)

[directory] = fileparts(Image_path);
outputName = [directory '/' Type '_Target_mask.nii.gz'];
TargetMask = outputName;

% if ~exist(outputName,'file') && Clobber ~= true

if Clobber
    
    outputName = [directory '/' Type '_Target_mask.nii.gz'];
    
    for u = 1:length(labelNumVec)
        
        labelNum = labelNumVec(u);
        [pathToLabel,PathToMaskedLabel,roi_path] = ExtractROIfromMask(Image_path,label_image_path,Mask_path,labelNum,1);
        
    end
    
    datapath = fileparts(Image_path);
    [Label_cell1,Label_cell2,Label_cell3] = GetLabelsPaths(datapath);
    
    TargetMask = AddImagesFSL(Label_cell1,Type);
    
    DeleteCell(Label_cell1);
    DeleteCell(Label_cell2);
    DeleteCell(Label_cell3);
end

end