
for u = 1:length(EddyPath)
    movefile([EddyPath{u} '/*bv*'], DWIPath{u})
end