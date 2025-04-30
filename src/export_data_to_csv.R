# Load packages
library(countrycode)
library(here)
library(manifestoR)
library(tidyverse)

# Input ESS fieldwork period data
input <- list(
  list(
    1,
    c("AT", "BE", "CZ", "DK", 
      "FI", "FR", "DE", "GR",
      "HU", "IE", "IL", "IT",
      "LU", "NL", "NO", "PL",
      "PT", "SI", "ES", "SE",
      "CH", "GB"),
    c("2003-02-02", "2002-10-01", "2002-11-24", "2002-10-28", 
      "2002-09-09", "2003-09-15", "2002-11-20", "2003-01-29",
      "2002-10-29", "2002-12-11", "2002-10-15", "2003-01-13",
      "2003-04-14", "2002-09-01", "2002-09-16", "2002-09-30",
      "2002-09-26", "2002-10-17", "2002-11-19", "2002-09-23",
      "2002-09-09", "2002-09-24"),
    c("2003-09-30", "2003-04-30", "2003-03-09", "2003-06-19", 
      "2002-12-10", "2003-12-15", "2003-05-16", "2003-03-15",
      "2002-11-26", "2003-04-12", "2003-01-15", "2003-06-30",
      "2003-08-14", "2003-02-24", "2003-01-17", "2002-12-19", 
      "2003-01-20", "2002-11-30", "2003-02-20", "2002-12-20", 
      "2003-02-08", "2003-02-04")),
  list(
    2,
    c("AT", "BE", "CZ", "DK",
      "EE", "FI", "FR", "DE",
      "GR", "HU", "IS", "IE",
      "IT", "LU", "NL", "NO",
      "PL", "PT", "SK", "SI",
      "ES", "SE", "CH", "TR",
      "GB", "UA"),
    c("2005-01-06", "2004-10-04", "2004-10-01", "2004-10-09",
      "2004-09-30", "2004-09-20", "2004-11-27", "2004-08-26",
      "2005-01-10", "2005-04-02", "2005-04-24", "2005-01-18",
      "2006-02-02", "2004-09-13", "2004-09-11", "2004-09-15",
      "2004-10-10", "2004-10-15", "2004-10-04", "2004-10-18",
      "2004-09-27", "2004-09-29", "2004-09-15", "2005-12-17",
      "2004-09-27", "2005-01-28"),
    c("2005-04-25", "2005-01-31", "2004-12-13", "2005-01-31",
      "2005-01-19", "2004-12-17", "2005-03-04", "2005-01-16",
      "2005-03-20", "2005-05-31", "2005-12-04", "2005-06-20",
      "2006-05-29", "2005-01-26", "2005-02-19", "2005-01-15",
      "2004-12-12", "2005-03-17", "2004-12-12", "2004-11-30",
      "2005-01-31", "2005-01-19", "2005-02-28", "2006-07-01",
      "2005-03-16", "2005-03-10")),
  list(
    3,
    c("AT", "BE", "BG", "CY",
      "DK", "EE", "FI", "FR",
      "DE", "HU", "IE", "LV",
      "NL", "NO", "PL", "PT",
      "RO",  "RU", "SK", "SI", 
      "ES",  "SE", "CH", "UA", 
      "GB"),
    c("2007-07-18", "2006-10-23", "2006-11-20", "2006-10-02",
      "2006-09-19", "2006-10-25", "2006-09-18", "2006-09-19",
      "2006-09-01", "2006-11-21", "2006-09-14", "2007-06-28",
      "2006-09-16", "2006-08-21", "2006-10-02", "2006-10-12",
      "2006-12-01", "2006-09-18", "2006-12-01", "2006-10-18", 
      "2006-10-25", "2006-09-21", "2006-08-24", "2006-12-06", 
      "2006-09-05"),
    c("2007-11-05", "2007-02-19", "2007-01-01", "2006-12-10", 
      "2007-05-02", "2007-05-21", "2006-12-20", "2007-04-07",
      "2007-01-15", "2007-01-28", "2007-08-31", "2007-09-02",
      "2007-03-18", "2006-12-19", "2006-12-13", "2007-02-28",
      "2007-01-31", "2007-01-09", "2007-02-28", "2006-12-04", 
      "2007-03-04", "2007-02-03", "2007-04-02", "2007-01-12", 
      "2007-01-14")),
  list(
    4,
    c("AT", "BE", "BG", "HR",
      "CY", "CZ", "DK", "EE",
      "FI", "FR", "DE", "GR",
      "HU", "IE", "IL", "LV",
      "LT", "NL", "NO", "PL",
      "PT", "RO", "RU", "SK",
      "SI", "ES", "SE", "CH",
      "TR", "UA", "GB"),
    c("2010-11-01", "2008-11-13", "2009-03-06", "2008-12-22",
      "2008-09-29", "2009-06-08", "2008-09-01", "2008-11-05",
      "2008-09-19", "2008-09-28", "2008-08-27", "2009-07-15",
      "2009-02-20", "2009-09-11", "2008-08-31", "2009-04-02",
      "2009-10-16", "2008-09-08", "2008-08-25", "2008-11-03",
      "2008-10-09", "2008-12-02", "2008-11-08", "2008-11-17",
      "2008-10-20", "2008-09-05", "2008-09-15", "2008-08-30",
      "2008-11-02", "2009-03-01", "2008-09-01"),
    c("2011-02-28", "2009-03-20", "2009-05-31", "2009-03-31",
      "2008-12-21", "2009-07-08", "2009-01-11", "2009-03-11",
      "2009-02-05", "2009-01-31", "2009-01-31", "2009-11-20",
      "2009-04-20", "2010-03-12", "2009-03-13", "2009-09-08",
      "2010-01-12", "2009-06-28", "2009-01-20", "2009-02-15",
      "2009-03-08", "2009-01-19", "2009-04-09", "2009-02-09",
      "2009-01-20", "2009-01-31", "2009-02-03", "2009-04-17",
      "2009-05-17", "2009-04-02", "2009-01-19")),
  list(
    5,
    c("AT", "BE", "BG", "HR",
      "CY", "CZ", "DK", "EE",
      "FI", "FR", "DE", "GR",
      "HU", "IE", "IL", "LT",
      "NL", "NO", "PL", "PT",
      "RU", "SK", "SI", "ES",
      "SE", "CH", "UA", "GB"),
    c("2013-05-24", "2010-10-11", "2010-12-17", "2011-09-16", 
      "2011-01-01", "2011-01-20", "2010-09-20", "2010-10-10",
      "2010-09-13", "2010-10-15", "2010-09-15", "2011-05-06",
      "2010-10-19", "2011-09-20", "2011-01-09", "2011-04-21",
      "2010-09-27", "2010-09-09", "2010-10-01", "2010-10-11",
      "2010-12-25", "2010-10-29", "2010-10-20", "2011-04-11",
      "2010-09-27", "2010-10-02", "2011-05-13", "2010-08-31"),
    c("2013-10-10", "2011-05-06", "2011-03-28", "2011-12-14",
      "2011-06-21", "2011-03-08", "2011-03-08", "2011-05-28",
      "2010-12-30", "2011-04-06", "2011-02-03", "2011-07-05",
      "2010-12-10", "2012-01-03", "2011-06-13", "2011-08-20",
      "2011-04-02", "2011-02-15", "2011-02-06", "2011-03-23",
      "2011-05-14", "2011-02-28", "2011-01-31", "2011-07-24",
      "2011-03-01", "2011-03-23", "2011-07-30", "2011-02-28")),
  list(
    6,
    c("AL", "BE", "BG", "CY", 
      "CZ", "DK", "EE", "FI",
      "FR", "DE", "HU", "IS",
      "IE", "IL", "IT", "XK",
      "LT", "NL", "NO", "PL",
      "PT", "RU", "SK", "SI",
      "ES", "SE", "CH", "UA",
      "GB"),
    c("2012-12-01", "2012-09-10", "2013-02-09", "2012-10-01", 
      "2013-01-09", "2013-01-10", "2012-09-01", "2012-09-03",
      "2013-02-08", "2012-09-06", "2012-11-10", "2012-10-03",
      "2012-10-15", "2012-09-03", "2013-06-01", "2013-02-14",
      "2013-05-21", "2012-08-28", "2012-08-14", "2012-09-19",
      "2012-10-24", "2012-10-10", "2012-10-24", "2012-10-01",
      "2013-01-23", "2012-10-01", "2012-09-01", "2013-07-11",
      "2012-09-01"),
    c("2013-02-12", "2012-12-25", "2013-04-30", "2012-12-31", 
      "2013-03-11", "2013-04-24", "2013-01-28", "2013-02-02",
      "2013-06-30", "2013-01-22", "2013-02-17", "2013-03-23",
      "2013-02-09", "2013-03-05", "2013-12-20", "2013-03-15",
      "2013-08-25", "2013-03-30", "2013-02-08", "2013-01-08",
      "2013-03-20", "2012-12-27", "2013-03-06", "2012-12-31",
      "2013-05-14", "2013-05-05", "2013-04-22", "2013-08-09",
      "2013-02-07")),
  list(
    7,
    c("AT", "BE", "CZ", "DK",
      "EE", "FI", "FR", "DE",
      "HU", "IE", "IL", "LT",
      "NL", "NO", "PL", "PT",
      "SI", "ES", "SE", "CH",
      "GB"),
    c("2014-10-14", "2014-09-10", "2014-11-24", "2014-09-07",
      "2014-09-07", "2014-09-03", "2014-10-31", "2014-08-18",
      "2015-04-24", "2014-09-04", "2015-05-12", "2015-04-11",
      "2014-09-08", "2014-08-20", "2015-04-17", "2015-02-02",
      "2014-10-09", "2015-01-22", "2014-08-01", "2014-08-29",
      "2014-09-01"),
    c("2015-05-05", "2015-02-01", "2015-02-09", "2014-12-29",
      "2014-12-29", "2015-02-09", "2015-03-03", "2015-02-05",
      "2015-06-26", "2015-01-31", "2015-12-13", "2015-06-14",
      "2015-01-15", "2015-01-08", "2015-09-14", "2015-11-30",
      "2015-02-01", "2015-05-25", "2015-01-30", "2015-02-02",
      "2015-02-25")),
  list(
    8,
    c("AT", "BE", "CZ", "EE",
      "FI", "FR", "DE", "HU",
      "IS", "IE", "IL", "IT",
      "LT", "NL", "NO", "PL",
      "PT", "RU", "SI", "ES",
      "SE", "CH", "GB"),
    c("2016-09-19", "2016-09-14", "2016-10-24", "2016-10-01",
      "2016-09-15", "2016-11-10", "2016-08-23", "2017-05-14",
      "2016-11-02", "2016-11-25", "2016-09-10", "2017-09-11",
      "2017-10-04", "2016-09-01", "2016-08-22", "2016-11-07",
      "2016-10-20", "2017-01-03", "2016-09-21", "2017-02-16",
      "2016-08-26", "2016-09-01", "2016-09-01"),
    c("2016-12-28", "2017-01-31", "2016-12-19", "2017-01-31",
      "2017-03-08", "2017-03-11", "2017-03-26", "2017-09-16",
      "2017-06-08", "2017-05-08", "2017-02-08", "2017-11-19",
      "2017-12-28", "2017-01-31", "2017-01-17", "2017-02-22",
      "2017-06-15", "2017-03-19", "2017-01-11", "2017-06-23",
      "2017-02-10", "2017-03-02", "2017-03-20")),
  list(
    9,
    c("AL", "AT", "BE", "BG", 
      "HR", "CY", "CZ", "DK",
      "EE", "FI", "FR", "DE",
      "HU", "IS", "IE", "IT",
      "LV", "LT", "ME", "NL", 
      "NO", "PL", "PT", "RS", 
      "SK", "SI", "ES", "SE", 
      "CH", "GB"),
    c("2018-12-19", "2018-09-18", "2018-09-20", "2018-11-16",
      "2019-09-20", "2018-09-17", "2018-11-17", "2018-09-13",
      "2018-10-01", "2018-09-03", "2018-10-19", "2018-08-29",
      "2019-01-31", "2019-10-05", "2018-11-05", "2018-05-11",
      "2019-10-10", "2019-09-21", "2019-05-22", "2018-08-28",
      "2018-10-04", "2018-10-26", "2019-10-27", "2018-10-01", 
      "2019-06-14", "2018-09-24", "2019-11-08", "2018-08-30", 
      "2018-09-01", "2018-08-31"),
    c("2019-03-15", "2019-01-12", "2019-01-28", "2018-12-15",
      "2020-01-27", "2019-05-26", "2019-02-06", "2019-01-08",
      "2019-03-02", "2019-02-18", "2019-04-01", "2019-03-04",
      "2019-05-22", "2020-01-31", "2019-04-05", "2019-03-10",
      "2020-01-21", "2019-12-15", "2019-10-30", "2019-01-22",
      "2019-05-16", "2019-03-20", "2019-12-23", "2019-03-01", 
      "2019-12-07", "2019-02-01", "2020-01-27", "2019-05-23", 
      "2019-02-11", "2019-02-22")),
  list(
    10,
    c("AT", "BE", "BG", "HR",
      "CY", "CZ", "EE", "FI",
      "FR", "DE", "GR", "HU",
      "IS", "IE", "IL", "IT",
      "LV", "LT", "ME", "NL",
      "MK", "NO", "PL", "PT",
      "RS", "SK", "SI", "ES",
      "SE", "CH", "GB"),
    c("2021-08-30", "2021-10-27", "2021-06-28", "2021-05-05",
      "2022-03-09", "2021-07-07", "2021-06-07", "2021-08-31",
      "2021-08-23", "2021-10-05", "2021-11-09", "2021-06-10",
      "2021-07-28", "2021-11-23", "2022-02-01", "2021-10-25",
      "2021-11-01", "2021-07-01", "2021-11-03", "2021-10-01",
      "2021-10-23", "2021-06-10", "2022-01-26", "2021-08-16",
      "2022-01-11", "2021-05-25", "2020-09-18", "2022-01-21",
      "2021-12-10", "2021-05-04", "2021-08-15"),
    c("2021-12-05", "2022-09-03", "2021-09-30", "2021-11-26",
      "2022-08-18", "2021-09-29", "2021-12-31", "2022-01-31",
      "2021-12-31", "2022-01-04", "2022-05-23", "2021-10-16",
      "2022-02-11", "2022-12-16", "2022-07-17", "2022-04-26",
      "2022-01-31", "2021-12-15", "2022-03-30", "2022-04-03",
      "2022-03-07", "2022-05-04", "2022-05-25", "2022-03-06",
      "2022-05-25", "2021-10-21", "2021-08-26", "2022-05-31",
      "2022-01-17", "2022-05-02", "2022-09-02")),
  list(
    11,
    c("AT", "BE", "CY", "CZ",
      "HR", "FI", "FR", "DE",
      "GR", "HU", "IS", "IE",
      "IT", "LT", "NL", "NO",
      "PL", "PT", "RS", "SK",
      "SI", "ES", "SE", "CH",
      "GB"),
    c("2023-06-13", "2023-06-28", "2023-05-15", "2024-02-01",
      "2023-06-24", "2023-08-01", "2023-08-23", "2023-05-09",
      "2024-02-05", "2023-05-05", "2024-02-20", "2023-06-27",
      "2023-10-09", "2023-09-04", "2023-03-31", "2023-04-17",
      "2023-10-21", "2023-09-25", "2023-12-11", "2023-09-08",
      "2023-03-21", "2024-02-08", "2023-03-08", "2023-03-09",
      "2023-07-03"),
    c("2023-12-03", "2024-02-13", "2024-06-29", "2024-08-04",
      "2024-01-19", "2024-01-30", "2024-02-04", "2023-12-21",
      "2024-05-09", "2023-11-10", "2024-06-09", "2024-01-03",
      "2024-04-21", "2023-12-31", "2023-11-07", "2023-11-30",
      "2024-04-26", "2024-02-29", "2024-02-29", "2023-12-12",
      "2023-08-14", "2024-06-01", "2023-12-08", "2024-01-31",
      "2023-12-09")))

# Convert to data frame
fieldwork_dates <- map_dfr(input, function(x) {
  tibble(
    essround = x[[1]],
    cntry = x[[2]],
    field_start = as.Date(x[[3]]),
    field_end = as.Date(x[[4]])
  )
})

# Set api key for Manifesto Project
api_key_file = here("manifesto_apikey.txt")
mp_setapikey(api_key_file)

# Load Manifesto Project data
election_dates_mp <- mp_maindataset() %>%
  # Rename countries to avoid error when converting them to ISO2c
  mutate(countryname = case_when(countryname == "Northern Ireland" ~ "United Kingdom",
                                 countryname == "German Democratic Republic" ~ "Germany",
                                 TRUE ~ countryname),
         cntry = countrycode(countryname, "country.name", "iso2c"),
         source = paste("Manifesto Project", datasetversion, sep = " "),
         election_date = edate) %>%
  select(cntry, election_date, source) %>%
  distinct()

# Find election date during fieldwork period
elections_during <- fieldwork_dates %>% 
  inner_join(election_dates_mp, by = "cntry", relationship = "many-to-many") %>% 
  filter(election_date >= field_start & election_date <= field_end) %>%   
  group_by(essround, cntry, field_start, field_end, source) %>% 
  summarize(election_date_during_fieldwork = min(election_date), .groups = "drop")

# Find last election before fieldwork period
last_elections <- fieldwork_dates %>% 
  inner_join(election_dates_mp, by = "cntry", relationship = "many-to-many") %>% 
  filter(election_date < field_start) %>% 
  group_by(essround, cntry, field_start, field_end, source) %>% 
  summarize(election_date_last_before_fieldwork = max(election_date, na.rm = TRUE), .groups = "drop")

# Merge fieldwork periods with election dates
df <- fieldwork_dates %>% 
  left_join(last_elections, by = c("essround", "cntry", "field_start", "field_end")) %>% 
  left_join(elections_during, by = c("essround", "cntry", "field_start", "field_end")) %>% 
  mutate(
    election_flag = case_when(
      !is.na(election_date_last_before_fieldwork) & !is.na(election_date_during_fieldwork) ~ TRUE,
      !is.na(election_date_last_before_fieldwork) &  is.na(election_date_during_fieldwork) ~ FALSE
    ),
    source = coalesce(source.x, source.y)
  ) %>% 
  select(-c(source.x, source.y))

# Define file name including extension
file_name = "ess_election_dates.csv"

# Define file path for exporting
file_path = paste(here(), "data", file_name, sep="/")

# Function to validate ESS data
validate_ess_data <- function(data) {
  errors <- c()
  
  # Check for missing values
  required_columns <- c("cntry", "essround", "field_start", "field_end")
  
  missing_summary <- sapply(data[required_columns], function(col) sum(is.na(col)))
  missing_cols <- names(missing_summary[missing_summary > 0])
  
  if (length(missing_cols) > 0) {
    errors <- c(errors, paste0("Missing values in mandatory columns: ", paste(missing_cols, collapse = ", ")))
  }
  
  # Check election_flag logic
  flag_false_with_date <- data %>%
    filter(election_flag == FALSE & !is.na(election_date_during_fieldwork)) %>%
    select(cntry, essround)
  
  if (nrow(flag_false_with_date) > 0) {
    rows <- paste0("(", flag_false_with_date$cntry, ", R", flag_false_with_date$essround, ")", collapse = "; ")
    errors <- c(errors, paste("Rows with election_flag == FALSE but non-NA election_date_during:", rows))
  }
  
  flag_true_without_date <- data %>%
    filter(election_flag == TRUE & is.na(election_date_during_fieldwork)) %>%
    select(cntry, essround)
  
  if (nrow(flag_true_without_date) > 0) {
    rows <- paste0("(", flag_true_without_date$cntry, ", R", flag_true_without_date$essround, ")", collapse = "; ")
    errors <- c(errors, paste("Rows with election_flag == TRUE but missing election_date_during:", rows))
  }
  
  # Check date ordering
  date_order_errors <- data %>%
    filter(
      field_start >= field_end |
        election_date_last_before_fieldwork >= field_start |
        (election_flag == TRUE & (
          election_date_during_fieldwork <= field_start | election_date_during_fieldwork >= field_end
        ))
    ) %>%
    select(cntry, essround)
  
  if (nrow(date_order_errors) > 0) {
    rows <- paste0("(", date_order_errors$cntry, ", R", date_order_errors$essround, ")", collapse = "; ")
    errors <- c(errors, paste("Date ordering issues for: ", rows))
  }
  
  # Check uniqueness
  duplicate_keys <- data %>%
    group_by(cntry, essround) %>%
    filter(n() > 1) %>%
    select(cntry, essround) %>%
    distinct()
  
  if (nrow(duplicate_keys) > 0) {
    rows <- paste0("(", duplicate_keys$cntry, ", R", duplicate_keys$essround, ")", collapse = "; ")
    errors <- c(errors, paste("Duplicate entries for cntry & essround: ", rows))
  }
  
  return(list(success = length(errors) == 0, messages = errors))
}

# Separate export function
export_validated_ess_data <- function(data, export_path = file_path) {
  validation <- validate_ess_data(data)
  
  if (validation$success) {
    write.csv(data, export_path, row.names = FALSE)
    message("Data validation successful. Exported to: ", export_path)
  } else {
    message("Data validation failed with the following issues:")
    for (msg in validation$messages) {
      message("  - ", msg)
    }
  }
}

# Run validation + export
export_validated_ess_data(df)
