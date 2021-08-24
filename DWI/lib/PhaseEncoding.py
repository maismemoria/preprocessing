import dicom as pydicom
import nibabel.nicom.csareader as csareader

rowcol_to_niftidim = {'COL': 'i', 'ROW': 'j'}
pedp_to_sign = {0: '-', 1: ''} 

def get_bids_phase_encoding_direction(dicom_path):
    """Return BIDS PhaseEncodingDirection string (i, j, k, i-, j-, k-) for DICOM at dicom_path.

    NOTE: work-in-progress
    """ 
    dcm = pydicom.read_file(dicom_path)
    inplane_pe_dir = dcm_pa[int('00181312', 16)].value
    csa_str = dcm[int('00291010', 16)].value
    csa_tr = csareader.read(csa_str)
    pedp = csa_tr['tags']['PhaseEncodingDirectionPositive']['items'][0]
    ij = rowcol_to_niftidim[inplane_pe_dir]
    sign = pedp_to_sign[pedp]
    return '{}{}'.format(ij, sign)