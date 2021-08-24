
function EraseAllFiles(CellArray)

    for u = 1:length(CellArray)        
        delete([CellArray{u} '/*'])
    end

end