function [SPlabels_unique] = consecutive_labels(SPlabels_unique) 


C = SPlabels_unique;
    
    
    cont = 1;
    while cont <= length(C)
        
        logic = C >= cont;
        menor = min(C(logic));
        ind = find(C == menor);
        
        if menor > 1
            
            x = menor - cont;
            C(ind) = menor - x;
            
        end
        
        cont = cont + 1;
        
    end
    
    SPlabels_unique = C;
    
end