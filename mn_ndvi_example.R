
# load libraries ----------------------------------------------------------

library(tidyverse)


# read data ---------------------------------------------------------------

vi <- read_csv("vi.csv")

# another way to look at the first few values for each variable
glimpse(vi)

# take a look at the values for each
summary(vi)

# vi should be on a scale of about 0 (not green) to 1 (very green)
# but it is multiplied by 10,000 and stored in the CSV as an integer to save space
# thus you need divide ndvi by 10,000 to convert it to correct scale
vi <- mutate(vi, ndvi = ndvi / 10000)


# subset the data ---------------------------------------------------------

# for this example we will select only the data from May 2016
vi_2016_may <- filter(vi, year == 2016, yday == 122)
vi_2016_may

summary(vi_2016_may)


# map the data ------------------------------------------------------------

ggplot(
  data = vi_2016_may, 
  mapping = aes(x = x, y = y)
) +
  geom_raster(aes(fill = ndvi)) +
  coord_fixed(1.7) +                                      # fix the aspect ratio
  scale_fill_distiller(palette = "BuGn", direction = 1) + # use green palette
  labs(
    title = "NDVI in May 2016",
    x = "Longitude", 
    y = "Latitude", 
    fill = "NDVI"
  )
