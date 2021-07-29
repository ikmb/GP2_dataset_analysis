#!/usr/bin/env bash
#purpose of the script
#This is a shell script to replicate the whole step if need be. 
#in this script, necessary environments should be set. A complete conda environment.yml should exist in the main project directory.
#Data ok to be on the repo is output directly into the analysis directory
#Anything which is a major outcome of the project is noted down in 00_Files.md
#Anything sensitive goes to a directory outside the repo to avoid accidental commit
conda activate FRUIT_env

#your commands start here
#Rscript script.R
#...
