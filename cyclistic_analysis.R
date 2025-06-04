library(tidyverse)
library(lubridate)
setwd("C:/Users/shadd/OneDrive/Desktop/cyclistic_2023_data")
getwd()
list.files(pattern = "*.csv")
files <- list.files(pattern = "*.csv")

all_trips <- files %>%
  lapply(read_csv) %>%
  bind_rows()
files <- list.files(pattern = "*.csv")
files  # This should print the list of .csv filenames
all_trips <- files %>%
  lapply(read_csv) %>%
  bind_rows()
glimpse(all_trips)
head(all_trips)
all_trips <- distinct(all_trips)
all_trips <- all_trips %>%
  mutate(
    started_at = ymd_hms(started_at),
    ended_at = ymd_hms(ended_at),
    ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")),
    day_of_week = wday(started_at, label = TRUE),  # e.g., Mon, Tue, ...
    month = month(started_at, label = TRUE)        # e.g., Jan, Feb, ...
  )
sum(is.na(all_trips$started_at))
all_trips <- drop_na(all_trips)
all_trips <- all_trips %>%
  filter(ride_length > 1, ride_length < 1440)  # Keep rides between 1 min and 24 hrs
summary(all_trips$ride_length)
write_csv(all_trips, "cyclistic_cleaned_2023.csv")
getwd()
write_csv(all_trips, "cyclistic_cleaned_2023.csv")
getwd()

