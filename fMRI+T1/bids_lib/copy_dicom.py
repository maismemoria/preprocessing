from py_utils import *
import os

DicomRootPath = '/media/proactionlab/HD-2Tb/Guilherme/DATA/Memoria'

NewDicomRootPath = '/media/proactionlab/HD-2Tb/Guilherme/DATA/maismemoria'
if not ExistPath(NewDicomRootPath):
    os.mkdir(NewDicomRootPath)

Folders, FdNames = ListFolders(DicomRootPath)

for fd,name in zip(Folders,FdNames):

    command = 'cp -r ' + fd + ' ' + NewDicomRootPath
    os.system(command)

    NiiFd = os.path.join(NewDicomRootPath,name,'Nifti')
    if ExistPath(NiiFd):
        command2 = 'rm -r ' + NiiFd
        os.system(command2)


        

