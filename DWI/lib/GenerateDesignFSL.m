

function GenerateDesignFSL(ConfigDesign,DesignCellMat,ContrastCell)

for n = 1:length(DesignCellMat)
    
    %% Design
    CT = DesignCellMat{n};
    FilePath = [ConfigDesign(n).path '/stats/design.txt'];
    NewFilePath = [ConfigDesign(n).path '/stats/design.mat'];
    
%     if ~exist(NewFilePath,'file')
        
        
        fid = fopen(FilePath,'w');
        for u = 1:size(CT,1)
            fprintf(fid,'%s\n', num2str(CT(u,:)));
        end
        fclose(fid);
        
        Command = ['Text2Vest ' FilePath ' ' NewFilePath];
        system(Command);
        
%     end
    
    
    %% Contrast
    
    CT2 = ContrastCell{n};
    FilePath = [ConfigDesign(n).path '/stats/contrasts.txt'];
    NewFilePath = [ConfigDesign(n).path '/stats/design.con'];
    
%     if ~exist(NewFilePath,'file')
        
        fid = fopen(FilePath,'w');
        for u = 1:size(CT2,1)
            fprintf(fid,'%s\n', num2str(CT2(u,:)));
        end
        fclose(fid);
        
        Command = ['Text2Vest ' FilePath ' ' NewFilePath];
        system(Command);
        
%     end
    
    
end
