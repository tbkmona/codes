head(mtcars)
library(tidyverse)
install.packages("gcookbook")
library(gcookbook)

#add header is false when the data does not have column header
data <- read.csv("datafile.csv", header=FALSE)

# Manually assign the header names
names(data) <- c("Column1","Column2","Column3")

data <- read.csv("datafile.csv", stringsAsFactors=FALSE)

#scatter plots
qplot(wt, mpg, data=mtcars)
# This is equivalent to:
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()

#line graph
plot(pressure$temperature, pressure$pressure, type="l")

#line together with plot
plot(pressure$temperature, pressure$pressure, type="l")
points(pressure$temperature, pressure$pressure)
lines(pressure$temperature, pressure$pressure/2, col="red")
points(pressure$temperature, pressure$pressure/2, col="red")

#in ggplot2
qplot(temperature, pressure, data=pressure, geom="line")
# This is equivalent to:
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line()
# Lines and points together
qplot(temperature, pressure, data=pressure, geom=c("line", "point"))
# Equivalent to:
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()


#introduction to ggplot2 library(gcookbook) # For the data set simpledat
#create simple bar graph 
barplot(simpledat, beside=TRUE)

#transpose the data and plot
barplot(t(simpledat), beside=TRUE)

#A bar graph made with ggplot() and geom_bar()
ggplot(simpledat_long, aes(x=Aval, y=value, fill=Bval)) +
  geom_bar(stat="identity", position="dodge")
#A line graph made with ggplot() and geom_line()
ggplot(simpledat_long, aes(x=Aval, y=value, colour=Bval, group=Bval)) +
  geom_line()