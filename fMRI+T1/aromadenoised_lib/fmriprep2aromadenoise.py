#!/usr/bin/env python3

def fmriprep2aromadenoise(bidsdir):

   import time
   import os, glob
   import numpy as np
   from nibabel import load
   #from nipype.utils.config import NUMPY_MMAP                 MODIFIED GUILHERME
   from nipype.interfaces.afni import TProject
   from nipype.interfaces.fsl.utils import FilterRegressor
   from niworkflows.interfaces.utils import _tpm2roi
   from nilearn.input_data import NiftiLabelsMasker # pip install nilearn==0.5.0a0
   
   
#   bidsdir = '/home/andre/data_transfer/bids'
   rootoutdir = bidsdir + '/derivatives/aromadenoised'
   
   # select all files to be denoised
   alldatapath  = glob.glob(bidsdir+'/derivatives/fmriprep'+
              '/*/*/func/*space-MNI152NLin2009cAsym_desc-preproc*.nii*') 
   
   # overwrite contents previouly calculated
   overwrite = True
   
   bandpass = [.009,9999]
   
   for ii in range(0,len(alldatapath)): #range(0,len(alldatapath)): 
      
      t = time.time()
      #get stuff for current case
      datapath = alldatapath[ii]
      
      datapathparts = datapath.split(os.path.sep)
      anatdir = os.path.sep+os.path.join(*datapathparts[0:-3],'anat')
      funcdir  = os.path.dirname(datapath)
      datafilename = os.path.basename(datapath).split('.')[0]
      dataext = os.path.basename(datapath)[len(datafilename):]
      dataid = os.path.basename(datapath).split('space-')[0]
      space = os.path.basename(datapath).split('space-')[1].split('_')[0]
      
      print ('------------------------------------------------------------\n'+
             '  DENOISING '+dataid[:-1]+'\n'+
             '------------------------------------------------------------\n')
            
      tpmcsfpath = glob.glob(anatdir+os.path.sep+'*'+space+'*CSF*ni*')[0]
      tpmcsffilename = os.path.basename(tpmcsfpath).split('.')[0]
      tpmcsfext = os.path.basename(tpmcsfpath)[len(tpmcsffilename):]
      
      tpmwmpath = glob.glob(anatdir+os.path.sep+'*'+space+'*WM*ni*')[0]
      tpmwmfilename = os.path.basename(tpmwmpath).split('.')[0]
      tpmwmext = os.path.basename(tpmwmpath)[len(tpmwmfilename):]
      
      anatmaskpath = glob.glob(anatdir+os.path.sep+'*'+space+'*mask*ni*')[0]
      funcmaskpath = glob.glob(funcdir+os.path.sep+dataid+'*'+space+'*mask.ni*')[0]

      outdir = rootoutdir + os.path.sep+os.path.join(*datapathparts[-4:-2])
      # make subject output directory, if none exists
      if not os.path.isdir(outdir): os.makedirs(outdir)
      
      #*_, timepoints = load(datapath, mmap=NUMPY_MMAP).shape MODIFIED GUILHERME
      *_, timepoints = load(datapath).shape
      
      #select columns of confound tsv to reduce based upon
      
      tmparomapath = (outdir+os.path.sep+'_tmparoma_'+datafilename+dataext)
      
      physconfpath = (outdir+os.path.sep+dataid+'pos-aroma_phys-confounds_regressors.tsv')      
      
      
      wmmaskpath = (outdir+os.path.sep+tpmwmfilename+'_roi'+tpmwmext)
      
      csfmaskpath = (outdir+os.path.sep+tpmcsffilename+'_roi'+tpmcsfext)   
      
      melodicpath = glob.glob(funcdir+os.path.sep+'*MELODIC*')[0]
      
      aromanoise = list(np.loadtxt(glob.glob(funcdir+os.path.sep+
                        '*AROMAnoiseICs*')[0],delimiter=',').astype('int'))
      
      # Performs the non-aggressive AROMA remotion for MNI2009
      if (not os.path.isfile(tmparomapath) or overwrite):
         FilterRegressor(design_file=melodicpath, filter_columns=aromanoise,
                         in_file=datapath, mask=funcmaskpath,
                         out_file=tmparomapath).run()
      
      if (not os.path.isfile(wmmaskpath) or overwrite):
         _tpm2roi(erosion_mm=0, mask_erosion_mm=30, in_tpm=tpmcsfpath,
                  in_mask=anatmaskpath, newpath=outdir)

         _tpm2roi(erosion_prop=0.6, mask_erosion_prop=0.6**3, in_tpm=tpmwmpath,
                  in_mask=anatmaskpath, newpath=outdir)
         
         csfts = NiftiLabelsMasker(labels_img=csfmaskpath, detrend=False,
                                   standardize=False).fit_transform(tmparomapath)
         
         wmts = NiftiLabelsMasker(labels_img=wmmaskpath, detrend=False,
                                  standardize=False).fit_transform(tmparomapath)
         
   #      gsts = NiftiLabelsMasker(labels_img=funcmaskpath, detrend=False,
   #                               standardize=False).fit_transform(tmparomapath)
   #      
   #      physconf_aroma = np.concatenate((csfts, wmts, gsts), axis=1)
         
         physconf_aroma = np.concatenate((csfts, wmts), axis=1)
         
         # header='CSF\tWhiteMatter\tGlobalSignal' for saving gsts
         np.savetxt(physconfpath, physconf_aroma,
                    header='CSF\tWhiteMatter',
                    comments='', delimiter='\t')
         
               
         outdatapath = outdir+os.path.sep+datafilename+'_02P-aroma-denoised'+dataext
         
         # Performs the regression to remove the Phys conf using ANFI
         if (not os.path.isfile(outdatapath) or overwrite):
            if os.path.isfile(outdatapath):
               os.remove(outdatapath)
            
            tproject = TProject()
            tproject.inputs.in_file = tmparomapath
            tproject.inputs.polort = 2 # 0th, 1st, 2nd-order terms
            tproject.inputs.automask = True
            tproject.inputs.bandpass = tuple(bandpass)
            tproject.inputs.ort = physconfpath 
            tproject.inputs.out_file= outdatapath   
            tproject.run()
        
            print ('==> DONE '+ dataid)      
      
         else:
            print ('Regression for Physiological confounds '+
                   'removing was not performed!!!')
         
      elapsed = time.time() - t
      
      print ('Elapsed time (s): '+str(np.round(elapsed,1))+'\n\n')
  
