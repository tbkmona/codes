# lets read CompanyRevenues.csv data
# interactive select
companiesData <- read.csv(file.choose(), header = TRUE, stringsAsFactors = FALSE)
view(companiesData)
  
  # eliminate the last row
  mmtData <- companiesData[1:17,]
  
  view(mmtData)
  colnames(mmtData)
  
  # load tidyverse
  library(tidyverse)
  
  # dropping off school children column
 # mmtData2 = subset(mmtData, select = -c(x,z) )
  
  mmtData2 = subset(mmtData, select = -c(SCHOOL.CHILDREN) )
  view(mmtData2)
  str(mmtData2) # inspect data

mmtData2$REVENUE <- factor(mmtData2$REVENUE, ordered = TRUE)

  # add a new column called revenuebus
mmtData3 <- mutate(mmtData2, revenuebus = REVENUE/OPS..BUSES)

# rename column names
colnames(mmtData2) <- c()

#saving my new file
write.csv(mmtData2, file = "Monthly_stats.csv")

#my new data frame
df <- data.frame(color = c("blue", "black","blue", "blue", "black"), value = 1:5)

df

#To explore the basic data manipulation verbs of dplyr, well use
#nyc flights13::flights. This data frame contains all 336,776 flights
#that departed from New York City in 2013. The data comes from
#the US Bureau of Transportation Statistics, and is documented in ?flights.

install.packages("nycflights13")
library("nycflights13")
?flights

View(flights)
str(flights)
dim(flights)

#always load tideyverse
library(tidyverse)

# filter on equality
filter(df, color == "blue")

#filter on match
filter(df, value %in% c(1,4))

#execute and return results for January 1 flights and save the results as Jan1
Jan1 <- filter(flights, month == 1, day == 1)

#do same for december 25
Dec25 <- filter(flights, month == 25, day == 25)

view(Jan1)
dim(Jan1)

# finds all flights that departed in November or December
# note: | for 'or'
filter(flights, month == 11 | month == 12)

# a short-hand
nov_dec <- filter(flights, month %in% c(11, 12))

# find flights that werent delayed (on arrival or departure) by more than two hours
  filter(flights, !(arr_delay > 120 | dep_delay > 120))
# or
filter(flights, arr_delay <= 120, dep_delay <= 120)

# tibble == data.frame + cool stuff
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

#Find all fights that
#1 Had an arrival delay of two or more hours
#2 Flew to Houston (IAH or HOU)
#3 Were operated by United, American, or Delta
#4 Departed in summer (July, August, and September)
#5 Arrived more than two hours late, but didnt leave late
#6 Were delayed by at least an hour, but made up over 30minutes in flight
#7 Departed between midnight and 6am (inclusive)


#REODER BY COLOR
arrange(df, color)

#arrange by color in descending order
arrange(df, desc(color))
arrange(flights, year, month, day)
# Use desc() to re-order by a
# column in descending order:
arrange(flights, desc(arr_delay))

#Sort flights to find the most delayed flights.
#Find the flights that left earliest.
#Sort flights to find the fastest flights.
#Which flights traveled the longest? Which traveled the shortest?

#PICK COLUMNS BY NAMES
select(df, color)
#ELIMINATE SOME COLUMNS
select(df, -color)

# Select columns by name
select(flights, year, month, day)
# Select all columns between year and day (inclusive)
select(flights, year:day)
# Select all columns except those from year to day (inclusive)
  select(flights, -(year:day))
# with everything() helper
select(flights, time_hour, air_time, everything())

vars <- c("year", "month", "day", "dep_delay", "arr_delay")
vars
select(flights, contains("TIME"))

#MUTATE
#mutate() always adds new columns at the end of your dataset.

mutate(df, double = 2 * value)
mutate(df, double = 2 * value, quadruple = 2 * double)

# smaller dataset for the purpose
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
# take a look
View(flights_sml)

# add new variables
mutate(flights_sml, gain = arr_delay - dep_delay, 
       speed = distance / air_time * 60)
# even refer to columns just created
mutate(flights_sml, gain = arr_delay - dep_delay, hours = air_time / 60, 
       gain_per_hour = gain / hours)

# to keep only the new variables: transmute()
transmute(flights, gain = arr_delay - dep_delay, hours = air_time / 60,
            gain_per_hour = gain / hours)

# modular arithmetic
transmute(flights, dep_time,
            hour = dep_time %/% 100, # integer division
            minute = dep_time %% 100 # remainder
            )

#Summarise on one column
summarise(df, total = sum(value))

#Grouped summaries
by_color <- group_by(df, color) 
summarise(by_color, total = sum(value))

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

# grouped by date for the average delay per date
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

#The 'pipe' operator in action

delays <- flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)) %>%
  filter(count > 20, dest != "HNL")

data(iris)
iris[, 1:4] %>% # select first 4 columns
  head() %>% # show 1st 6 rows of 4 columns
  rowSums() # row sums of 6 rows of 4 cols

#From dataset mtcars, select variables mpg and gear
data(mtcars)
mtcars %>%
  select(mpg,gear)

#Take only those cars (observations) with mileage of more than 20 miles per gallon.
data(mtcars)
mtcars %>%
  select(mpg, gear) %>%
  filter(mpg > 20)

#Group the data by gear.
data(mtcars)
mtcars %>%
  select(mpg, gear) %>%
  filter(mpg > 20) %>%
  group_by(gear)

#Give a summary of how many cars have how many gears.
data(mtcars)
mtcars %>%
  select(mpg, gear) %>%
  filter(mpg > 20) %>%
  group_by(gear) %>%
  summarise(n = n())

# has a lot of missing values (NA)
flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))

# fortunately, all aggregation functions have an na.rm argument
  flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay, na.rm = TRUE))

#In this case, where missing values represent canceled flights,
  #we could also tackle the problem by first removing the canceled flights.
  
  not_cancelled <- flights %>%
    filter(!is.na(dep_delay), !is.na(arr_delay))
  
  not_cancelled %>%
    group_by(year, month, day) %>%
    summarise(mean = mean(dep_delay))