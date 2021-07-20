## Replace the word "berry"

*20.07.2021*

ukshikmb-cl005:~/Desktop/uc-rnaseq/02_berryreplace  

I need to replace the occurence of the word berry in the names of the berries to feed it to a program allergic to berries.

    bash runReplaceBerries.sh  
	cat ~/Desktop/replaced_berries_result.txt  
	berry,number
	rasp,4
	straw,14
	blue,6

Result:  
Except for the header line, all instances of "berry" were successfully removed. I saved the result to an external location to demonstrate how we would deal with external files which can not be part of the repo due to size or privacy. It's mainly that the location where the script is designed to be run is given in the wrapper shell script of the step. In the notebook, the location has to be given anyway. The new file's location is noted down in the 00_Files.md
