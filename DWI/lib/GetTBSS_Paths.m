function [AllTBSS_Paths] = GetTBSS_Paths (TBSS_Path)

list = dir(TBSS_Path);
cont = 1;

for u = 3:length(list)
    
    CondPath = [TBSS_Path '/' list(u).name];
    List2 = dir(CondPath);
    
    for v = 3:length(List2)
        AllTBSS_Paths{cont} = [CondPath '/' List2(v).name];
        cont = cont + 1;
    end
    
end

end