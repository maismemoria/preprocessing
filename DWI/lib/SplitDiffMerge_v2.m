
function SplitDiffMerge_v2(AllTBSS_Paths,Options,ConfigDesign)

% See: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/GLM#Single-Group_Paired_Difference_.28Paired_T-Test.29
% Randomise details

mainpath = pwd;

for u = 1:length(AllTBSS_Paths)
    AccumulateString = [];
    % Use only for Single-Group-Paired-Difference
    switch ConfigDesign(u).type
        case 'Single-Group-Paired-Difference'
            if mod(ConfigDesign(u).NumImgs,2) == 0
                StatsPath = [AllTBSS_Paths{u} '/stats'];
                
                List = dir([StatsPath '/*skeletonised*']);
                
                for qq = 1:length(List)
                    cd (StatsPath)
                    temp = split(List(qq).name,'_');                    
                    NewFile = [temp{2} '_G1-G2.' Options.ConvertFormat]; 
                    
                    if ~exist([StatsPath '/' NewFile],'file')
                    
                        BashCommand = ['fslsplit ' StatsPath '/' List(qq).name ' -t'];
                        
                        system(BashCommand)
                        
                        AllVolumes = dir([StatsPath '/*vol*']);
                        HalfSizeVol = length(AllVolumes)/2;
                        
                        for v = 1:HalfSizeVol
                            
                            Time1_Volume = [StatsPath '/' AllVolumes(v).name];
                            Time2_Volume = [StatsPath '/' AllVolumes(v+HalfSizeVol).name];
                            DiffOut = [StatsPath '/Diff_' num2str(v) '.' Options.ConvertFormat];
                            BashCommand = ['fslmaths ' Time1_Volume ' -sub ' ...
                                Time2_Volume ' ' DiffOut];
                            
                            system(BashCommand)
                            
                            if v ~= 1
                                AccumulateString = [AccumulateString ' ' DiffOut];
                            else
                                AccumulateString = [DiffOut];
                            end
                            
                        end
                        
                        
                        BashCommand = ['fslmerge -t ' NewFile ' ' AccumulateString];
                        system(BashCommand)
                        
                        delete([StatsPath '/*vol*'])
                        delete([StatsPath '/*Diff*'])
                    end
                    
                end
                
            else
                disp('Not paired data! Check TBSS directory.')
            end
    end
end
cd (mainpath)

end


