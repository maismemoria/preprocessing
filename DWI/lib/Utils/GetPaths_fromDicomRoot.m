function [AllEddyPaths,AllDWIPaths,AllSubjs] = GetPaths_fromDicomRoot(DicomRootPath)

list = ListFoldersNames(DicomRootPath);
cont = 1;

for u = 1:length(list)
    
    AllSubjs{cont} = list{u};
    AllDWIPaths{cont} = [DicomRootPath '/' list{u} '/Nifti/DWI'];
    AllEddyPaths{cont} = [DicomRootPath '/' list{u} '/Nifti/DWI/eddy'];
    cont = cont + 1;
    
end
