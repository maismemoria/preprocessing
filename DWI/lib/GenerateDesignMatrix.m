
function [DesignCellMat,ContrastCell] = GenerateDesignMatrix(ConfigDesign)

for u = 1:length(ConfigDesign)
   
    switch ConfigDesign(u).type
        
        case 'Single-Group-Paired-Difference'
            
            if mod(ConfigDesign(u).NumImgs,2) == 0
                Half = ConfigDesign(u).NumSubjs;
                
                D1 = eye([Half,Half]);                
                D = [D1;D1];
                
                DesignMat = [ones(ConfigDesign(u).NumImgs,1),D];
                DesignMat(Half+1:end,1) = -1;
                DesignCellMat{u} = DesignMat;
                
                ContrastMat = zeros(2,size(DesignMat,2));
                ContrastMat(1,1) = 1;
                ContrastMat(2,1) = -1;
                ContrastCell{u} = ContrastMat;
            else
                disp('Error!')
                break
            end
    end
end