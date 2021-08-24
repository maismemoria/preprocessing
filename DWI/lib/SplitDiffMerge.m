
function SplitDiffMerge(AllTBSS_Paths,Options,ConfigDesign)

for u = 1:length(AllTBSS_Paths)
    AccumulateString = [];    
    % Use only for Single-Group-Paired-Difference
    switch ConfigDesign(u).type
        case 'Single-Group-Paired-Difference'
            if mod(ConfigDesign(u).NumSubjs,2) == 0
                
                StatsPath = [AllTBSS_Paths{u} '/stats'];
                BashCommand = ['fslsplit ' StatsPath '/all_FA_skeletonised.' Options.ConvertFormat ' -t'];
                cd (StatsPath)
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
                
                BashCommand = ['fslmerge -t GA_minus_GB.' Options.ConvertFormat ' ' AccumulateString];
                system(BashCommand)
                
                delete([StatsPath '/*vol*'])
                delete([StatsPath '/*Diff*'])
                
            else
                disp('Not paired data! Check TBSS directory.')
            end
    end
end
end


