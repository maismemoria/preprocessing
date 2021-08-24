function [SubjsCellArrayNifti,ImageTypeCell,functionalSubjsCellNifti,structuralSubjsCellNifti] = GetNiftiFiles(OutputPath)

cont = 1;
cont2 = 1;
cont3 = 1;
for u = 1:length(OutputPath)
    
    [temp,~,~] = fileparts(OutputPath{u});
    [~,ImageType,~] = fileparts(temp);
    
    ListImages = dir([OutputPath{u} '/*.nii']);
    [SubjsCellArrayNifti{1,cont}] = GetPaths (ListImages,OutputPath{u});
    ImageTypeCell{1,cont} = ImageType;
    cont = cont + 1;
    
    if isempty(regexp(ImageType,'MPRAGE'))
        [functionalSubjsCellNifti{1,cont2}] = GetPaths (ListImages,OutputPath{u});
        cont2 = cont2 + 1;
    else
        [structuralSubjsCellNifti{1,cont3}] = GetPaths (ListImages,OutputPath{u});
        cont3 = cont3 + 1;
    end   
        
end

end