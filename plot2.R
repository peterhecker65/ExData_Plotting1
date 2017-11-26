## Plotting Assignment 1 for Exploratory Data Analysis / Plot 2
##
## Source: https://github.com/peterhecker65/ExData_Plotting1
##

# =========================================
# Download, Unzip, Read, Filter and Format the Dataset
# =========================================

# Link to the ZIP-file containing the Dataset: Electric power consumption [20Mb]
data_url <-
    'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

# Use a temporary filename for downloading the ZIP-file
temp_file <- tempfile()

# Filename of the dataset file
data_file <- 'household_power_consumption.txt'

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
data_from_date = '1/2/2007'
data_to_date = '2/2/2007'

# Download ZIP-file
download.file(data_url, destfile = temp_file, method = 'curl')

# Read the complete dataset. Missing values are coded as ?
ds_all <- read.table(
    unz(temp_file, data_file),
    na.strings = '?',
    sep = ';',
    comment.char = '',
    header = TRUE,
    strip.white = TRUE,
    stringsAsFactors = FALSE
)

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
ds_selected = ds_all[ds_all$Date == data_from_date |
                         ds_all$Date == data_to_date,]

# Housekeeping, remove the complete dataset, we will use the only the selected dataset
rm(ds_all)

# Convert and format the Date- and Time-Field
ds_selected$Date <- as.Date(ds_selected$Date, format = '%d/%m/%Y')
ds_selected$Time <-
    strptime(paste(ds_selected$Date, ds_selected$Time), format = '%Y-%m-%d %H:%M:%S')


# =========================================
# Create Plot 2: Global Active Power (Kilowatts)
# =========================================

# Save current locale and activate English locale
current_locale <- Sys.getlocale('LC_ALL')
Sys.setlocale('LC_ALL', 'en_US')

# Draw graphics
plot(
    ds_selected$Time,
    ds_selected$Global_active_power,
    type = 'l',
    ylab = 'Global Active Power (Kilowatts)',
    xlab = ''
)

# Copy graphic to png
dev.copy(
    png,
    filename = 'plot2.png',
    width = 480,
    height = 480,
    units = 'px',
    pointsize = 12,
    bg = 'white'
)

# Shutdown the current device
dev.off()

# Restore to current locale
Sys.setlocale('LC_ALL', current_locale)
