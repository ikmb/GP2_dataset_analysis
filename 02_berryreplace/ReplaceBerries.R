library("data.table")
berrytable<-fread("../00_RawData/berries.txt")
berrytable[,berry:=gsub("berry","",berry)]
fwrite(berrytable,file="~/Desktop/replaced_berries_result.txt")
