


EddyProcessed = '/home/guilherme/GoogleDrive/Proaction-Lab/Data/MemoriaEddy';

List = dir(EddyProcessed);

cont = 1;

for u = 3:length(List)
   AllSubs{cont} =  List(u).name;
   AllEddyPaths{cont} = [EddyProcessed '/' List(u).name '/Nifti/DWI/eddy'];
   cont = cont + 1;
    
end






