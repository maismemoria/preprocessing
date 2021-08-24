function DeleteCell(cell_array)

for u = 1:length(cell_array)
    delete(cell_array{u})
end

end