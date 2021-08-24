function ListNames = ListFoldersNames(path)

%list
d = dir(path);
isub = [d(:).isdir];
temp = {d(isub).name};
ListNames = temp(3:end);

end
