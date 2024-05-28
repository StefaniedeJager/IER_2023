library(readxl)

# Read the Excel file
data <- read_excel("/Users/stefaniedejager/Desktop/Introduction to Engineering Research/Day2vsDay6.xlsx")

# Explore the data
head(data)    # View the first few rows of the data
summary(data) # Get a summary of the data

attach(data)
#boxplot(Normal, Zero, General)
#boxplot(Tnormal, Tzero, Tgeneral, Znormal, Zzero, Zgeneral)

#Comment and uncomment the right t-test
#Uncomment these if you are performing an analyses between the different training days
#t.test(Tnormal, Znormal, paired = TRUE)
#t.test(Tzero, Zzero, paired = TRUE)
#t.test(Tgeneral, Zgeneral, paired = TRUE)
#t.test(Tnormal, Zgeneral, paired = TRUE)

#Uncomment these if you are performing an analyses between different conditions on one training day
t.test(Normal, Zero, paired = TRUE)
t.test(Normal, General, paired = TRUE)
t.test(Zero, General, paired = TRUE)

