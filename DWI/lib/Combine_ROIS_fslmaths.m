clear all
close all
clc

data_dir = '/home/guilherme/GoogleDrive/Proaction-Lab/PythonWorkspace/DiffusionDevelop/Test150739';
cd (data_dir)

List = dir([data_dir '/*.nii*']);

AllNames = {List(:).name};
AllPrefix = cell(length(AllNames),1);

for u = 1:length(AllNames)   
        PrefixName = strsplit(AllNames{u},'_');        
        AllPrefix{u} = PrefixName{1};    
end
    
UniquePrefix = unique(AllPrefix);    

for u = 1:length(UniquePrefix)
    
    SpecificList = dir([data_dir '/*' UniquePrefix{u} '*']);
    
    PartialCommand = [];
    
    for v = 1:length(SpecificList)
        
        name = [SpecificList(v).name ' '];
        addition = '-add ';
        
        if v ~= length(SpecificList)        
            PartialCommand = [PartialCommand name addition];            
        else        
            PartialCommand = [PartialCommand name 'LabelsFS_' UniquePrefix{u}];            
        end
        
    end
        
    BashCommand = ['fslmaths ' PartialCommand];
    system(BashCommand)
    
end
    





% function Add_ROIS_fslmaths




% end