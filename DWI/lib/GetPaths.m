
function [SubjsCellArray] = GetPaths (ListImages,Directory)

cont = 1;
SubjsCellArray = cell(length(ListImages),1);

for u = 1:length(ListImages)
           
    SubjsCellArray{cont} = [Directory '/' ListImages(u).name];    
    cont = cont + 1;
    
end

end