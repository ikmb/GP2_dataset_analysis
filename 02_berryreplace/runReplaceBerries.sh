#!/bin/bash
#This is a shell script to replicate the whole step if need be. 
#in this script, necessary environments should be set. A complete conda environment.yml should exist in the main project directory.
#e.g. conda activate berry_env
#The script exports data to a location outside the repository. Therefore it is necessary to name the machine and the user this is designed to be run on. Like:
#user@com123:/home/user/Desktop/uc-rnaseq/02_berryreplace
Rscript ReplaceBerries.R
