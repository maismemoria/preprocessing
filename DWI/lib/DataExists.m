

function [isOk] = DataExists(CellArrayData,nameFile,CellSubjs,data_info,ReportName,DicomRootPath)

Evaluation_ind = zeros(length(CellArrayData),1);

Header = {'Path2File','FileName','StudyName', 'SubjNum', ReportName};

CellReport = cell(length(CellArrayData),5);

for u = 1:length(CellArrayData)
    
    if strcmp(nameFile,'anat.nii.gz')
        
        Evaluation_ind(u) = exist([CellArrayData{u}],'file');
        
    else
        Evaluation_ind(u) = exist([CellArrayData{u} '/' nameFile],'file');
        
    end
    
    CellReport{u,1} = CellArrayData{u};
    CellReport{u,2} = nameFile;
    CellReport{u,3} = data_info.ProjectName;
    CellReport{u,4} = CellSubjs{u};
    
    if Evaluation_ind(u) == 0
        CellReport{u,5} = 'Not Ok';
    else
        CellReport{u,5} = 'Ok';
    end
end

ReportTable = cell2table(CellReport,'VariableNames',Header);
writetable(ReportTable,[DicomRootPath '/00_Report-' ReportName '.csv'])

isOk = all(Evaluation_ind);


end