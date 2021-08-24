from py_utils import *
import shutil
import os

DicomRootPath = '/home/guilherme/Insync/asus.armazenamento1@gmail.com/GoogleDrive/ProactionLab/memoria/DATA'

NewDicomRootPath = '/home/guilherme/Insync/asus.armazenamento1@gmail.com/GoogleDrive/ProactionLab/memoria/DATA_PRE'
if not ExistPath(NewDicomRootPath):
    os.mkdir(NewDicomRootPath)

Folders, *_ = ListFolders(DicomRootPath)

for fd in Folders:
    if fd[-1] == str(1):
        command = 'cp -r ' + fd + ' ' + NewDicomRootPath
        os.system(command)
        

