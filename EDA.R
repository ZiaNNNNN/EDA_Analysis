url = "https://raw.githubusercontent.com/jcbonilla/BusinessAnalytics/master/BAData/JC-201709-citibike-tripdata.csv"
citibike = read.csv(url)
citibike = as.data.frame(citibike)
library(R.basic)
library(lubridate)
citibike$tripdur_z = zscore(citibike$tripduration, na.rm = TRUE)
ab_trip = subset(citibike, tripdur_z > 3, select = c(1, 2, 3, 4, 5, 8, 9, 12, 13, 15, 16, 17))

age <- function(dob, age.day = today(), units = "years", floor = TRUE) {
  calc.age = interval(dob, age.day) / duration(num = 1, units = units)
  if (floor) return(as.integer(floor(calc.age)))
  return(calc.age)
}
citibike$birth.year = as.Date(citibike$birth.year, "%Y")
citibike$age = age(citibike$birth.year)
citibike$age_z = zscore(citibike$age, na.rm = TRUE)
ab_age = subset(citibike, age_z > 3, select = c(1, 2, 3, 4, 5, 8, 9, 12, 13, 15, 17, 18))

age_80 = subset(citibike, age > 80)
nrow(age_80)

write.csv(citibike, "/Users/zianzhang/Desktop/nyu/business_analytics/HW3/citibike.csv")

url2 = "https://raw.githubusercontent.com/jcbonilla/BusinessAnalytics/master/BAData/aviation.csv"
aviation = read.csv(url2)
aviation = as.data.frame(aviation)
aviation$fetal_status = gsub("[0-9]*", "", aviation$Injury.Severity)
aviation$fetal_status = gsub("[[:punct:]]", " ", aviation$fetal_status)

aviation$Date_Year = substring(aviation$Event.Date, 8, 11) 
aviation$Date_Year = as.Date(aviation$Date_Year, "%Y")
write.csv(aviation, "/Users/zianzhang/Desktop/nyu/business_analytics/HW3/aviation_rev.csv")
