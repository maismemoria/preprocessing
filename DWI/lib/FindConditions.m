
function [ii,jj] = FindConditions(SubjNum,rows,cols,DTIdados1)

for ii = 1:rows
    for jj = 1:cols
        
        if isnumeric(DTIdados1{ii,jj})
        
            if DTIdados1{ii,jj} == str2num(SubjNum)
                return
            end
        end
        
    end
end

ii = [];
jj = [];

end     