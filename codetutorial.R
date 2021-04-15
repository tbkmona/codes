install.packages("ggplot2") # install package
> library(ggplot2) # load library for graph
> head(mtcars, 3) # the data. what it looks like

> # create factors with value labels
  
  mtcars$gear <- factor(
    + mtcars$gear,
    + levels=c(3,4,5),
    + labels=c("3gears","4gears","5gears"))
 mtcars$am <- factor(
    + mtcars$am,
    + levels=c(0,1),
    + labels=c("Automatic","Manual"))
  mtcars$cyl <- factor(
    + mtcars$cyl,
    + levels=c(4,6,8),
    + labels=c("4cyl","6cyl","8cyl"))
  
  
  patientID <- c(1, 2, 3, 4)
  age <- c(25, 34, 28, 52)
  diabetes <- c("Type1", "Type2", "Type1", "Type1")
   status <- c("Poor", "Improved", "Excellent", "Poor")
                
  # put them all together
     patientdata <- data.frame(patientID, age,
                                 diabetes, status)
    # output content
      patientdata
    str(patientdata)
    summary(patientdata)
    
    rownames(patientdata)
    colnames(patientdata); names(patientdata)
    
    # let's rename columns
    names(patientdata) <- c("patient",
                              "year",
                              "diabetes",
                              "status")
    
    # same effect
    colnames(patientdata) <- c("patientID",
                                 "age",
                                 "diabetes",
                                 "status")
    patientdata
    
    # getting individual columns
    patientdata$age; patientdata$status
    
    # Read the wseries dataset:
    # Skip the first 35 lines
      # Then read 23 lines of data
      # The data occurs in pairs: a year
      # and a pattern (char string)
      #
      url <- "http://lib.stat.cmu.edu/datasets/wseries"
    series <- scan(url, skip = 35, nlines = 23, what = list(year = integer(0),
                                                              pattern = character(0)))
                     
                     
                     
                                   
    series
    
    series$year # let's see the results
    # fix that by sorting the list elements according to year:
    perm <- order(series$year)
    series <- list(year = series$year[perm], pattern = series$pattern[perm])
                    
    # verify
    series$year
    series$pattern