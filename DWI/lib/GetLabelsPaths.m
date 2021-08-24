function [Label_cell1,Label_cell2,Label_cell3] = GetLabelsPaths (datapath)

list1 = dir([datapath '/*_LabelFilter*']);
list2 = dir([datapath '/*_Label.nii*']);
list3 = dir([datapath '/*_ROI.nii*']);

Label_cell1 = cell(length(list1),1);
Label_cell2 = cell(length(list2),1);
Label_cell3 = cell(length(list3),1);

for u = 1:length(list1)
   Label_cell1{u} = [datapath '/' list1(u).name];    
end

for u = 1:length(list2)
   Label_cell2{u} = [datapath '/' list2(u).name];    
end

for u = 1:length(list3)
   Label_cell3{u} = [datapath '/' list3(u).name];    
end


end