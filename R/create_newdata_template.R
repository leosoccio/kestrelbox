# Export template Excel files for 2025 data collection
# Created: January 2, 2026
# Author: Elizabeth Eisenhauer

# Load required packages
library(openxlsx)

# Load the existing datasets
load("data/bybox.rda")
load("data/bychick.rda")

# Create template for bybox data with example rows from 2024
# Select a few example rows to show the data collector the format
bybox_examples <- head(bybox[bybox$year == 2024, ], 5)

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

# Create template for bychick data with example rows from 2024
bychick_examples <- head(bychick[bychick$year == 2024, ], 5)

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
cat("- bybox_2025_template.xlsx (5 example rows + 10 blank rows for 2025 data)\n")
cat("- bychick_2025_template.xlsx (5 example rows + 10 blank rows for 2025 data)\n")
cat("Example rows are highlighted in light yellow.\n")
cat("Data collectors should fill in the blank rows with 2025 data.\n")





