
function [pathToLabel,PathToMaskedLabel,roi_path] = ExtractROIfromMask(Image_path,label_image_path,Mask_path,labelNum,Filter)

if Filter
    
    [pathToLabel] = ExtracLabelfromMask(Image_path,label_image_path,labelNum);
    [PathToMaskedLabel] = FilterLabel(pathToLabel,Mask_path,labelNum);
    roi_path = GetRoiFromLabel(Image_path,PathToMaskedLabel,labelNum);
    
else
    
    [pathToLabel] = ExtracLabelfromMask(Image_path,label_image_path,labelNum);    
    roi_path = GetRoiFromLabel(Image_path,pathToLabel,labelNum);
    PathToMaskedLabel = [];
    
    
end

end