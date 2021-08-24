
function Relabel_atlas(filepath)

NiiData = load_untouch_nii(filepath);

data = NiiData.img;
data_vec = data(:);

[UniqueLabels,ia,ib] = unique(data_vec,'stable');

[UniqueLabels_consecutive] = consecutive_labels(UniqueLabels+1);

data_vec(:) = UniqueLabels_consecutive(ib);

data = reshape(data_vec,size(data,1),size(data,2),size(data,3));

NiiData.img = data;
save_untouch_nii(NiiData,filepath)

end