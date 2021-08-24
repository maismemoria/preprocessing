function ConfigDesign = MakeConfigDesign(AllTBSS_Paths,type)

for u = 1:length(AllTBSS_Paths)
    
   TbssPath = AllTBSS_Paths{u};
   ListFiles = dir([TbssPath '/origdata']);   
   [temp,Group1,~] = fileparts(TbssPath);
   [~,Group2,~] = fileparts(temp);
   
   ConfigDesign(u).NumImgs = (length(ListFiles)-2);
   ConfigDesign(u).NumSubjs = (length(ListFiles)-2)/2;
   ConfigDesign(u).type = type;
   ConfigDesign(u).Group = [Group2 '-' Group1];
   ConfigDesign(u).path = TbssPath;
   
end
   
    
    
    
end







