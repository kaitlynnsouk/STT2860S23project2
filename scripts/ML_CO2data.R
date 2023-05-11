# Script to read, tidy, and save Mauna Loa CO2 data
# Authors: Kaitlynn, Ava, Brittney
# Created: 2023-04-24
# Updated: 2023-06-05

# --------------------------------------------------
# packages

library(readr)
library(tidyverse)

# --------------------------------------------------
# read the Mauna Loa data from the web

mlco2 <- read_table(file = "https://gml.noaa.gov/webdata/ccgg/trends/co2/co2_mm_mlo.txt",
                    comment = "#",
                    col_names = c("year", "month", "dec_date", "co2", "co2_adj", "num_days", "sd_days",                                  "uncertainty"),
                    col_types = "iinnninn",
                    na = c("-1", "-9.99", "-0.99"))

# --------------------------------------------------
# Format, tidy, and reshape the dataset

tidy_mlco2 <- mlco2 %>%
  mutate(year_month = paste(year, month, sep = "-")) %>%
  pivot_longer(cols = c("co2", "co2_adj"),
               names_to = "CO2",
               values_to = "co2_amount") %>%
  select(-c(year, month))

# --------------------------------------------------
# save the tidied data as .rds to data_tidy

save(tidy_mlco2, file = "~/git_repos/STT2860S23project2/data_tidy/mlco2_tidy.rds")

