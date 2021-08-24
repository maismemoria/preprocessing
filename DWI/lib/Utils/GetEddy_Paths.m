function [AllEddyPaths] = GetEddy_Paths (DicomRootPath)

list = dir(DicomRootPath);
cont = 1;

for u = 3:length(list)
    
    AllEddyPaths{cont} = [DicomRootPath '/' list(u).name '/Nifti/DWI/eddy'];
    cont = cont + 1;
    
end