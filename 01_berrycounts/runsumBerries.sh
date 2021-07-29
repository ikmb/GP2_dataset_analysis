#!/bin/bash
#This is a shell script to replicate the whole step if need be. 
#in this script, necessary environments should be set. A complete conda environment.yml should exist in the main project directory.
#e.g. conda activate berry_env
#this script saves a result to the 01_berrycounts/ directory. 
#Data ok to be on the repo is output directly into the analysis directory 01_berrycounts. 
#Anything which is a major outcome of the project is noted down in 00_Files.md
#Anything sensitive goes to a directory outside the repo to avoid accidental commit
Rscript sumBerries.R
