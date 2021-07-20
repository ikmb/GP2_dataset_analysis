# README

## Table of Contents

| File Name | Description |
| -- | -- |
|00_rawdata.md | Getting the raw data |
|01_AnalysisStepOne.md | counting berries|

## 00_RawData generation

*20.07.2021*  
ukshikmb-cl005:~/Desktop/uc-rnaseq/00_RawData  
I generated the berry data by thinking about delicious berries and typed them in by hand.  
Code:  
	touch berries.txt  
add berry numbers with editor and save  

Result:  
We now have a table of berries in 00_RawData/berries.txt  

## 01_AnalysisStepOne

*20.07.2021*  
ukshikmb-cl005:~/Desktop/uc-rnaseq/01_AnalysisStepOne  
I wanted to know the total number of berries, because a fruit salad needs at least 20 items to be considered a fruit salad according to Fruitlov and Bananas 2021 (PubFruitID). I typed the R-script sumBerries.R executed and saved the result to berrysum_result.txt.  
Code:  
	Rscript sumBerries.R  
inspect result file berrysum_result.txt with editor  

Result:  
The total number of berries is 24 so our berries are sufficient for a small fruit salad.  
