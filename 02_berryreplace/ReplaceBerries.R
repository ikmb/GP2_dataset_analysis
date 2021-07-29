library("data.table")
berrytable<-fread("../00_RawData.ln/berries.txt")
berrytable[,berry:=gsub("berry","",berry)]
fwrite(berrytable,file="../localresults.ln/replaced_berries_result.txt")
