
function [cout] = matlab_fnirt(in,aff_omat,cout)

cmd_fsl = ['fnirt --in=' in ' --aff=' aff_omat ' --cout=' cout];
system(cmd_fsl);

end