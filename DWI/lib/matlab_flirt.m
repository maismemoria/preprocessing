
function [out,omat] = matlab_flirt(in,ref,out,omat)

fsl_cmd = ['flirt -in ' in ' -ref ' ref ' -out ' out ' -omat ' omat];
system(fsl_cmd);

end