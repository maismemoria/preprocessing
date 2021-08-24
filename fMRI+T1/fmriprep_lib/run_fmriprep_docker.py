
from py_utils import ListFiles, fileparts
from multiprocessing import Pool,cpu_count
import os
from math import floor

############### Input ###########################

# Path to FreeSurefer licence:
freesurfer_license_path = os.path.join(os.getcwd(),'license.txt')

# Path to bids root directory containing your data:
root = '/media/proactionlab/HD-2Tb/Guilherme/DATA/DATA_func_memoria/pre'
bids_root = os.path.join(root,'bids')

# Define which subjects as a list of strings or set 'All' to run all subjects
BidsIDs = 'All'
#BidsIDs = ['40']

# Set number of volumes that will be removed from the analysis. E.g. Ndummies = 5, removes the first 5 volumes (TRs)
Ndummies = 5

# Parallel Options: Total number of cores that will be used = nthreads * Npools

# Set number of cores will be used for each subject if cores are available. 
nthreads = 24  #if available

# Set number of cores will be used.
Npools = 1
################### Input end ####################




############ Code ########################

## Derivatives path
derivatives_path = os.path.join(bids_root,'derivatives')
if not os.path.isdir(derivatives_path):
    os.mkdir(derivatives_path)

## Freesurfer path
freesurfer_path = os.path.join(derivatives_path,'freesurfer')
if not os.path.isdir(freesurfer_path):
    os.mkdir(freesurfer_path)

# fmri workspace directory
work_path  = os.path.join(root,'work')
if not os.path.isdir(work_path):
    os.mkdir(work_path)


# Allocate memory:
cmd_list = []

# Construct fmriprep command
if BidsIDs == 'All':
    ListSubjects = ListFiles(bids_root, Filter='*sub*')

    for Subjpath in ListSubjects:

        _,subjID = fileparts(Subjpath)
        _,Label_ID = subjID.split('-')
        

        cmd_list.append('fmriprep-docker ' + bids_root + ' ' + derivatives_path + ' --participant-label ' + Label_ID + 
        ' -w ' + work_path + ' -vv ' + '--output-spaces MNI152NLin2009cAsym anat MNI152NLin6Asym fsnative ' +
        '--use-aroma'  + ' --fs-license-file ' + freesurfer_license_path + ' --fs-subjects-dir ' + freesurfer_path + 
        ' --nthreads ' + str(nthreads) + ' --dummy-scans ' + str(Ndummies))

else:
    for Label_ID in BidsIDs:
    
        cmd_list.append('fmriprep-docker ' + bids_root + ' ' + derivatives_path + ' --participant-label ' + Label_ID + 
        ' -w ' + work_path + ' -vv ' + '--output-spaces MNI152NLin2009cAsym anat MNI152NLin6Asym fsnative ' +
        '--use-aroma'  + ' --fs-license-file ' + freesurfer_license_path + ' --fs-subjects-dir ' + freesurfer_path + 
        ' --nthreads ' + str(nthreads) + ' --dummy-scans ' + str(Ndummies))


#print(cmd_list)
# Run processes in parallel:
def run_process(cmd):
    os.system(cmd)

pool = Pool(processes=Npools)
pool.map(run_process,cmd_list)


