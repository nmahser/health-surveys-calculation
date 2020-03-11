source('./functions.R')

getwd()
#Better way to set working directory?
setwd("..")
setwd("Desktop/Elminda/beemer")



#Make sure file name is correct. INOUT IS CSV
rawData <- read.csv("bemer.csv",sep = ",",header = TRUE)

# Define acronyms. This is the place where we decide which survey to extract from raw data
# If decided to be move on with this project, we can have user interface, such as radio buttons to decide which survey or form to include
# Little note: Beemer is a STUDY which consists of forms (ie, Patient_Instake_Form,). A form can include multiple surveys (ie, BDI)
# Understanding the distinction among Study, Form and Survey might be important moving forward
# CREATE A VECTOR FOR THE ACRONYMS NEED TO BE EXTRACTED FROM RAW DATA. INPUT IS VECTOR
studyName = "bemer"
bemerInTakeSurveys <- c("DEM","BEE","QOL","RND","LON","CHA","HAD","BDI","GPM","PSQ")


# Remove first two rows. First row is the copy of the col names
# Second row includes strings. Because of first two rows all the numeric values are exported as string
# The quick solution: Remove first two rows, write a new csv file and then export it
rawData <- rawData[-(1:2),]

# Write rawData into csv file
write.csv(rawData,"beemerNoRows.csv", na = "NA", row.names = TRUE)

noRows <- read.csv("beemerNoRows.csv",sep = ",",header = TRUE)


#Generates excel file with a sheet for each survey
divideSurveysExcel(studyName = studyName,noRowsData = noRows,acronyms = bemerInTakeSurveys)
