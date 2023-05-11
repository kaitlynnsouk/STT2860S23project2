# Script to read, tidy, and save Powerball numbers data
# Authors: Kaitlynn, Ava, Brittney
# Created: 2023-04-24
# Updated: 2023-06-05

# --------------------------------------------------
# packages

library(tidyverse)
library(readxl)

# -------------------------------------------------------
# read Powerball data from the Excel file in data_raw

powerball <- read_excel("~/git_repos/STT2860S23project2/data_raw/powerballdata.xlsx") %>%
  rename(
    drawdate = `Draw Date`,
    numbers = `Winning Numbers`,
    multiplier = Multiplier
  )

# -------------------------------------------------------
# Format, tidy, and reshape the dataset

powerball_tidy <- powerball %>%
  separate_wider_delim(
    numbers,
    delim = " ",
    names = c("w1", "w2", "w3", "w4", "w5", "powerball")
  ) %>%
  mutate(
    w1 = as.numeric(w1),
    w2 = as.numeric(w2),
    w3 = as.numeric(w3),
    w4 = as.numeric(w4),
    w5 = as.numeric(w5),
    powerball = as.numeric(powerball)
  ) %>% 
  pivot_longer(cols = c("w1", "w2", "w3", "w4", "w5", "powerball"),
               names_to = "draw",
               values_to = "number")
  
# -------------------------------------------------------
# write tidied dataset to data_tidy folder

save(powerball_tidy, file = "~/git_repos/STT2860S23project2/data_tidy/powerball_tidy.xlsx")

