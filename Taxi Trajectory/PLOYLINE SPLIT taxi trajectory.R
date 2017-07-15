install.packages("readr")
install.packages("rjson")

library("readr")
library("rjson")

test  <- read_csv("/home/eman/Kaggle Competitions/train.csv.zip")

positions <- function(row) as.data.frame(do.call(rbind, fromJSON(row$POLYLINE)))
last_position <- function(row) tail(positions(row), 1)

submission <- test["TRIP_ID"]

for (i in 1:nrow(test)) {
  pos <- last_position(test[i,])
  submission[i, "LATITUDE"] <- pos[2]
  submission[i, "LONGITUDE"] <- pos[1]
}
submission[,1]

if (is.na(submission) || submission == '')
{
  print ("YES")
}
is.na(submission) ## yup is contains NAs 

write_csv(submission, "/home/eman/Kaggle Competitions/last_location_benchmark.csv")

