library("data.table")
berrytable <- fread("../00_RawData.ln/berries.txt")
berrysum <- sum(berrytable$number)
write(berrysum, file = "berrysum_result.txt")