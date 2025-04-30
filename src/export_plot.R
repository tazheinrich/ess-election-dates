library(here)
library(patchwork)
library(tidyverse)

df <- read_csv(file = here("data/ess_election_dates.csv"))


# Create a list of plots, one for each essround
plots <- lapply(unique(df$essround), function(round) {
  ggplot(df %>% filter(essround == round),
         aes(x = field_start,
             xend = field_end,
             y = factor(cntry),
             yend = factor(cntry))) +
    geom_segment(linewidth = 1) +
    geom_vline(xintercept = election_date_last_before_fieldwork) +
    scale_y_discrete(limits = rev(levels(factor(df$cntry)))) +
    scale_x_date(labels = scales::date_format("%Y-%m"),
                 breaks = "3 months") +
    labs(x = "Date", 
         y = "Country", 
         title = paste("Survey Round", round)) +
    theme(legend.position = "none")
})

# Combine the plots in a 3x4 matrix
combined_plot <- wrap_plots(plots, ncol = 1)  # Adjust ncol as needed for 3x4 matrix


# Export plot
ggsave(filename = here("output/ess_fieldwork_periods.png"),
       plot = combined_plot,
       width = 10,    # Width of the plot in inches
       height = 40,   # Height of the plot in inches
       dpi = 300)     # Resolution in DPI (dots per inch)

# Display the combined plot
combined_plot

library(dplyr)
library(ggplot2)
library(scales)

df_de <- df %>%
  filter(essround == 1) %>%
  mutate(essround_fct = factor(cntry),
         # compute midpoint and duration of each fieldwork period
         mid_date = as.Date((as.numeric(field_start) + as.numeric(field_end)) / 2, origin = "1970-01-01"),
         duration = as.numeric(field_end - field_start))

ggplot() +
  # survey period bars
  geom_tile(data = df_de,
            aes(x = mid_date,
                y = essround_fct,
                width = duration,
                height = 0.6),
            fill = "steelblue") +
  
  # vertical election lines per round
  geom_segment(data = df_de,
               aes(x = election_date_last_before_fieldwork,
                   xend = election_date_last_before_fieldwork,
                   y = as.numeric(essround_fct) - 0.3,
                   yend = as.numeric(essround_fct) + 0.3),
               color = "red",
               linewidth = 1) +
  
  scale_y_discrete(limits = levels(df_de$essround_fct)) +
  scale_x_date(labels = date_format("%Y-%m"),
               breaks = "2 years") +
  labs(x = "Date", 
       y = "Survey Round", 
       title = "Survey Periods and Election Dates") +
  theme_minimal() +
  theme(legend.position = "none")
