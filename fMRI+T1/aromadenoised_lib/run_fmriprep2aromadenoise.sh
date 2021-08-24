#! /bin/bash

export STUDY="/media/andre/data/data_transfer/maismemoria/bids"

python -c 'import os; from fmriprep2aromadenoise import fmriprep2aromadenoise; fmriprep2aromadenoise(os.environ["STUDY"])'
