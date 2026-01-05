# Export template Excel files for 2025 data collection
# Created: January 2, 2026
# Author: Elizabeth Eisenhauer

# Load required packages
library(openxlsx)

# Load the existing datasets
load("data/bybox.rda")
load("data/bychick.rda")

# Create template for bybox data with example rows from 2024
# Select example rows that demonstrate all unique values for key variables
bybox_2024 <- bybox[bybox$year == 2024, ]

# Create a selection strategy to get diverse examples
# Get one example for each unique combination of key variables
set.seed(123) # For reproducibility

# Get examples showing different combinations of key variables
bybox_examples <- rbind(
  # did_not_check = 0, occupied = 1, failure = 0
  bybox_2024[bybox_2024$did_not_check == 0 & bybox_2024$occupied == 1 & 
             bybox_2024$failure == 0 & !is.na(bybox_2024$occupied), ][1, ],
  # did_not_check = 0, occupied = 1, failure = 1
  bybox_2024[bybox_2024$did_not_check == 0 & bybox_2024$occupied == 1 & 
             bybox_2024$failure == 1 & !is.na(bybox_2024$failure), ][1, ],
  # did_not_check = 0, occupied = 0
  bybox_2024[bybox_2024$did_not_check == 0 & bybox_2024$occupied == 0 & 
             !is.na(bybox_2024$occupied), ][1, ],
  # did_not_check = 1
  bybox_2024[bybox_2024$did_not_check == 1, ][1, ],
  # Different mount types
  bybox_2024[bybox_2024$mount_type == "steel pole" & !is.na(bybox_2024$mount_type), ][1, ],
  bybox_2024[bybox_2024$mount_type == "public u-pole" & !is.na(bybox_2024$mount_type), ][1, ],
  bybox_2024[bybox_2024$mount_type == "private u-pole" & !is.na(bybox_2024$mount_type), ][1, ],
  bybox_2024[bybox_2024$mount_type == "other" & !is.na(bybox_2024$mount_type), ][1, ],
  # Different study areas
  bybox_2024[bybox_2024$study_area == "Lancaster" & !is.na(bybox_2024$study_area), ][1, ],
  bybox_2024[bybox_2024$study_area == "NJ" & !is.na(bybox_2024$study_area), ][1, ]
)

# Remove any duplicate rows and NAs
bybox_examples <- unique(bybox_examples[complete.cases(bybox_examples$box_id), ])

# Store the box_ids and year to use for matching bychick data
example_box_ids <- bybox_examples$box_id
example_year <- bybox_examples$year

# Add "EXAMPLE" prefix to box_id for example rows
bybox_examples$box_id <- paste0("EXAMPLE", bybox_examples$box_id)

# Create a template dataframe for 2025 with empty rows
bybox_2025_template <- data.frame(
  box_id = NA_integer_,
  year = 2025L,
  did_not_check = NA_integer_,
  occupied = NA_integer_,
  failure = NA_integer_,
  young_count = NA_integer_,
  young_count_2nd_brood = NA_integer_,
  unbanded_young_count = NA_integer_,
  mount_type = NA_character_,
  study_area = NA_character_,
  latitude = NA_real_,
  longitude = NA_real_
)

# Add 10 empty rows for data entry
bybox_2025_template <- bybox_2025_template[rep(1, 10), ]

# Combine examples and template
bybox_export <- rbind(bybox_examples, bybox_2025_template)

# Create template for bychick data using matching box_id * year combinations
# Filter bychick data to match the same box_id and year from bybox examples
bychick_2024 <- bychick[bychick$year == 2024, ]
bychick_examples <- bychick_2024[bychick_2024$box_id %in% example_box_ids, ]

# If no matches found, get some examples anyway
if (nrow(bychick_examples) == 0) {
  bychick_examples <- head(bychick_2024, 5)
}

# Add "EXAMPLE" prefix to box_id for example rows
bychick_examples$box_id <- paste0("EXAMPLE", bychick_examples$box_id)

# Create a template dataframe for 2025 with empty rows
bychick_2025_template <- data.frame(
  box_id = NA_integer_,
  year = 2025L,
  age = NA_integer_,
  weight = NA_integer_,
  band_date = NA_character_,
  fledge_date = NA_character_,
  sex = NA_character_,
  study_area = NA_character_
)

# Add 10 empty rows for data entry
bychick_2025_template <- bychick_2025_template[rep(1, 10), ]

# Combine examples and template
bychick_export <- rbind(bychick_examples, bychick_2025_template)

# Create Excel workbook for bybox
wb_bybox <- createWorkbook()
addWorksheet(wb_bybox, "bybox_2025")
writeData(wb_bybox, "bybox_2025", bybox_export)

# Add some formatting and instructions
addStyle(wb_bybox, "bybox_2025", 
         style = createStyle(fgFill = "#DCE6F1", textDecoration = "bold"),
         rows = 1, cols = 1:12, gridExpand = TRUE)

addStyle(wb_bybox, "bybox_2025",
         style = createStyle(fgFill = "#FFFFCC"),
         rows = 2:6, cols = 1:12, gridExpand = TRUE)

# Save bybox Excel file
saveWorkbook(wb_bybox, "data-raw/bybox_2025_template.xlsx", overwrite = TRUE)

# Create Excel workbook for bychick
wb_bychick <- createWorkbook()
addWorksheet(wb_bychick, "bychick_2025")
writeData(wb_bychick, "bychick_2025", bychick_export)

# Add some formatting and instructions
addStyle(wb_bychick, "bychick_2025",
         style = createStyle(fgFill = "#DCE6F1", textDecoration = "bold"),
         rows = 1, cols = 1:8, gridExpand = TRUE)

addStyle(wb_bychick, "bychick_2025",
         style = createStyle(fgFill = "#FFFFCC"),
         rows = 2:6, cols = 1:8, gridExpand = TRUE)

# Save bychick Excel file
saveWorkbook(wb_bychick, "data-raw/bychick_2025_template.xlsx", overwrite = TRUE)

cat("Excel templates created successfully!\n")
cat("- bybox_2025_template.xlsx (", nrow(bybox_examples), " example rows + 10 blank rows for 2025 data)\n")
cat("- bychick_2025_template.xlsx (", nrow(bychick_examples), " example rows + 10 blank rows for 2025 data)\n")
cat("\nExample rows are highlighted in light yellow and show all unique values for:\n")
cat("  - did_not_check, occupied, failure, mount_type, study_area\n")
cat("  - Same box_id * year combinations in both files\n")
cat("\nData collectors should fill in the blank rows with 2025 data.\n")

# note: manually removed EXAMPLE321 from bychick. because no chicks. probably should not be in that dataset

