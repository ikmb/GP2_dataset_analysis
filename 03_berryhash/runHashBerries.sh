#!/bin/bash
#This is a shell script to replicate the whole step if need be. 
#in this script, necessary environments should be set. A complete conda environment.yml should exist in the main project directory.
#e.g. conda activate berry_env
#Hash the berries for maximum flavor. Reimports data from a source outside the repo. Would usually be the cluster, or an exact filename from a data repository. The problem that the repository is not completely rerunnable in one step because of external paths has to be accepted here. The location from which the script is run becomes important. This should be noted in the personal notebook, but also here, like:
#user@com123:/home/user/Desktop/
bash HashBerries.sh
