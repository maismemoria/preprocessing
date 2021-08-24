
function MoveFiles(WarpedSubjsCellArray,OutputPath)

if isempty(OutputPath)
    OutputPath = 'Warped';
end

for u = 1:length(WarpedSubjsCellArray)
    
    CellArray = WarpedSubjsCellArray{u};
    
    if DataExists(CellArray)
        
        for v = 1:length(CellArray)
            
            [OldDir,FileName,~] = fileparts(CellArray{v});
            [~,DirToReplace,~] = fileparts(OldDir);
            NewDir = replace(OldDir,DirToReplace,OutputPath);
            
            movefile(CellArray{v},NewDir)
        end
        
    else
        disp('Problem with data. Check DataExists function carefully.')
        break
    end
    
end
end





