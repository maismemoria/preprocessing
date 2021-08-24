import os
from py_utils import *
import pandas as pd
import json

# This function finds the group of the given subject 
def MatchSubject(ref_table,o_subj):

    boolean_table = ref_table.isin([int(o_subj)])
    Header = ref_table.columns.values.tolist()

    for u in range(1,len(Header)):
        indx = boolean_table.index[boolean_table.iloc[:,u]==True].tolist()
        if not isempty(indx):
            break
    group = ref_table.iloc[indx[0],0]
    session = Header[u]
    session_num = u
    return (indx[0] + 1,group,session_num,session)    

########################################################

# Create the 'participants.tsv' file
def WriteParticipantsTsv(subList,groupList,oID_List,BidsRootPath):
    df_tsv = pd.DataFrame()
    df_tsv['participant_id'] = subList
    df_tsv['group'] = groupList
    df_tsv['original_id'] = oID_List
    df_tsv = df_tsv.drop_duplicates()
    df_tsv = df_tsv.sort_values(by=['participant_id'])
    out_tsv = os.path.join(BidsRootPath,'participants.tsv')
    df_tsv.to_csv(out_tsv,index=False,sep='\t')

    if ExistPath(out_tsv):
        print("Participants tsv file created. Path: " + out_tsv)
        return 
    else:
        print("Could not create Participants tsv file.")
        return 

########################################################

# Create task .json file
def WriteTaskJson(jsonfile,BidsRootPath):    
    with open(jsonfile,'r') as openfile:
        json_object = json.load(openfile)

    dict1 = {
    "TaskName" : "rest",
    "RepetitionTime" : json_object["RepetitionTime"]
    }

    json_object = json.dumps(dict1, indent = 2) 
    out_json = os.path.join(BidsRootPath,"task-rest_bold.json")
    with open(out_json, "w") as outfile: 
        outfile.write(json_object)
    
    if ExistPath(out_json):
        print("Task json file created. Path: " + out_json)
        return 
    else:
        print("Could not create task json file.")
        return

########################################################

# Write dataset description json file
def WriteDatasetDescriptionJson(BidsRootPath):
    dict1 = {
    "Name": "MaisMemoria",
    "BIDSVersion": "1.1.1",
    "DatasetType": "raw",
    "Authors": [
        "ProactionLab"
        ]
    }
    json_object = json.dumps(dict1, indent = 2) 
    out_json = os.path.join(BidsRootPath,"dataset_description.json")
    with open(out_json, "w") as outfile: 
        outfile.write(json_object)
    
    if ExistPath(out_json):
        print("Dataset description json file created. Path: " + out_json)
        return 
    else:
        print("Could not create dataset description json file.")
        return False


########################################################

def WriteParticipantsJson(aux_table,BidsRootPath):
    
    dict1 = {
        "group": {
            "Description": "experimental group the participant belonged to",
            "Levels": {
                "WL": "Waitlisted: no stimulaton",
                "SHAM": "Sham stimulation",
                "DLPFC": "Stmiulation to DLPFC",
                "CEREB": "Stimulation to cerebellum"
            }
        },

        "original_id" : {
            "Description": "Original ID of the participants (not considering the last digit). As described in table: " + aux_table
        }        
    }

    json_object = json.dumps(dict1, indent = 2) 
    out_json = os.path.join(BidsRootPath,"participants.json")
    with open(out_json, "w") as outfile: 
        outfile.write(json_object)
    
    if ExistPath(out_json):
        print("Participants json file created. Path: " + out_json)
        return 
    else:
        print("Could not create participants json file.")
        return False

# Write README file. Note that this README was written in advance. The function below only copies it to the right directory.
def WriteREADME(BidsRootPath):
    readmeFile = os.path.join(os.getcwd(),"README")
    command = 'cp ' + readmeFile + ' ' + BidsRootPath
    os.system(command)

