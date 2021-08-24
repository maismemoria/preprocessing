
import os
import csv
import json
import pandas as pd
import nibabel as nib
from py_utils import *
from memoria_bids_lib import *

# Input
DicomRootPath = "/media/proactionlab/HD-2Tb/Guilherme/DATA/DATA_func_memoria/pre"
bids_name = "bids"

# Input Information
aux_table_name = "aux_table_maismemoria-pre.csv"
aux_table = os.path.join(os.getcwd(),aux_table_name)
anat_dim = 192
func_dim = 180
dwi_dim = 79

# Check input:
if not ExistPath(DicomRootPath):
    raise NameError ('Path to dicom root directory does not exist')
if not ExistPath(aux_table):
    raise NameError ('Path to aux table file does not exist')

# Output
BidsRootPath = None

#Default Option
if BidsRootPath == None:
    BidsRootPath = os.path.join(DicomRootPath,bids_name)
    if not ExistPath(BidsRootPath):
        os.mkdir(BidsRootPath)    

# Get paths of all folders in the dicom root path
ListFdPath, ListFd = ListFolders(DicomRootPath)
# Remove Bids directory
ListFdPath.remove(BidsRootPath)
ListFd.remove(fileparts(BidsRootPath)[1])

# Read aux table
ref_table = pd.read_csv(aux_table)

# Allocate variables
subList = []
groupList = []
oID_List = []

# Iterate over folders
for f,fd in zip(ListFdPath,ListFd):   
    
    # Get the group and sesssion of the current subject
    s,group,session_num,session = MatchSubject(ref_table,fd)
        
    # Make system command to convert dicom to nifti
    command = "dcm2niix -b y -z y -v y -o " + BidsRootPath + ' ' + f
    print(command)
    os.system(command)

    # Get Nii Files
    NiiFiles = ListFiles(BidsRootPath,'*.nii.gz*')

    # Subject directory
    if int(s) < 10:
        subName = "sub-0" + str(s)
    else:
        subName = "sub-" + str(s)

    # Accumulate values to write tsv file
    subList.append(subName)
    groupList.append(group)
    oID_List.append(fd[0:-1])

    # Subject Directory
    SubjectFd = os.path.join(BidsRootPath,subName)
    if not ExistPath(SubjectFd):
        os.mkdir(SubjectFd)
    
    # Session Directory    
    SessionName = "ses-0" + str(session_num)
    SessionFd = os.path.join(SubjectFd,SessionName)
    if not ExistPath(SessionFd):
        os.mkdir(SessionFd)    

    #Anatomical Directory
    AnatFd = os.path.join(SessionFd,"anat")
    if not ExistPath(AnatFd):
        os.mkdir(AnatFd)

    # functional - resting state
    FuncFd = os.path.join(SessionFd,"func")
    if not ExistPath(FuncFd):
        os.mkdir(FuncFd)

    # diffusion
    DwiFd = os.path.join(SessionFd,"dwi")
    if not ExistPath(DwiFd):
        pass
    #    os.mkdir(DwiFd)
    
    # Iterate over files
    for nii in NiiFiles:            
        # Identify, move and rename files
        I = nib.load(nii)
        
        for dim in I.shape:        
            if dim == anat_dim:                
                # Define anat name
                anat_file = os.path.join(AnatFd,subName + "_" + SessionName + "_T1w.nii.gz")                
                # Move anat file
                os.rename(nii,anat_file)                
                #Define json anat name 
                anat_json_file = anat_file.replace(".nii.gz",".json") 
                # Move json anat file
                os.rename(nii.replace('.nii.gz','.json'),anat_json_file)
                break
            
            if dim == func_dim:
                # Define func name                
                func_file = os.path.join(FuncFd,subName + "_" + SessionName + "_task-rest_bold.nii.gz")
                # Move func file    
                os.rename(nii,func_file)
                # Define json func name
                func_json_file = func_file.replace(".nii.gz",".json")
                # Move json func file
                os.rename(nii.replace('.nii.gz','.json'),func_json_file)
                break

            if dim == dwi_dim:
                pass
                #Define dwi name
                #dwi_file

    #Delete non important nii files        
    for jf in ListFiles(BidsRootPath,'*.*'):
        os.remove(jf)

# Create the 'participants.tsv' file
WriteParticipantsTsv(subList,groupList,oID_List,BidsRootPath)

# Create task .json file
WriteTaskJson(func_json_file,BidsRootPath)

# Create dataset description json file
WriteDatasetDescriptionJson(BidsRootPath)

# Create the 'participants.json' file
WriteParticipantsJson(aux_table,BidsRootPath)

# 'Create' the README file
WriteREADME(BidsRootPath)




