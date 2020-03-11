library(dplyr)
library(xlsx)

# Divide the surveys into different sheets
divideSurveysExcel <- function(studyName,noRowsData,acronyms) {
  
  # Extract RecipientLastName, RecipientFirstName
  lastName <- noRowsData["RecipientLastName"]
  firstName <- noRowsData["RecipientFirstName"]
  
  for (i in 1:length(acronyms)) {
    
    #Extract the cols belongs to each acronym
    selectedCol = noRowsData %>%
      select(starts_with(as.character(acronyms[i])))
    
    ##Add first and last name to each survey
    finalizedSheet <- cbind.data.frame(lastName,firstName,selectedCol)
    

    write.xlsx(finalizedSheet, file=paste0(studyName,"_",Sys.Date(),".xlsx"), sheetName=acronyms[i], append=TRUE, row.names=FALSE)
    
  }
}


divideSurveysList <- function(studyName,noRowsData,acronyms) {
 
  # Extract RecipientLastName, RecipientFirstName
  lastName <- noRowsData["RecipientLastName"]
  firstName <- noRowsData["RecipientFirstName"]
  
  # Initialize a list to store each survey data
  listOfSurveys <- list()
  
  for (i in 1:length(acronyms)) {
    
    #Extract the cols belongs to each acronym
    selectedCol = noRowsData %>%
      select(starts_with(as.character(acronyms[i])))
    
    ##Add first and last name to each survey
    finalizedSheet <- cbind.data.frame(lastName,firstName,selectedCol)
    
    listOfSurveys[[acronyms[i]]] <- finalizedSheet
    
  }
  
  return(listOfSurveys)
  
}


###BDI###

meanBdi <- function(bdi) {
  
  #Eliminate NA values - unanswered question
  # What if a participant didn't respond any of the questions
  mean <- sum(a,na.rm = T) / length(bdi)
  
  return(mean)
}

# Technically, the unanswered variable counted as 0 while calculating std
stdBdi <- function(bdi) {
  sumCol <- bdi %>%
    mutate(sumRow = rowSums(.,na.rm = T))
  
  std <- sd(sumCol$sumRow)
  
  return(std)
}


###PSQI###
