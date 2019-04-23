library(tidyverse)
library(sf)
library(tigris)
library(ggthemes)
library(gganimate)
library(janitor)
library(lubridate)

# i load the packages that i will be using throughout the process of plotting
# the animated map

sanfran <- read_csv("http://justicetechlab.org/wp-content/uploads/2018/05/San_Francisco_ShotSpotter.csv") %>% 
  
  # i read in the data as a csv file url from the Justice Tech Lab website and
  # assigned it to an appropriate name
  
  clean_names()

# to ensure that all column names are named in an accessible and useful way, i
# use clean_names to make them all snake_case and lowercase

shapes <- places("ca", class = "sf", cb = TRUE) %>%
  
  # places() is best for finding a shapefu
  
  filter(NAME == "San Francisco")

sanfran <- sanfran %>%
  mutate(hour = hour(time)) %>% 
  st_as_sf(coords = c("longitude", "latitude"), crs = st_crs(shapes))

ggplot(data = shapes) +
  geom_sf() +
  geom_sf(data = sanfran, aes(alpha = 0.4)) +
  guides(alpha = FALSE) +
  theme_map() +
  coord_sf(xlim = c(-122.55, -122.3), ylim = c(37.7, 37.85)) +
  transition_time(hour) +
  labs(title = "Aggregate Shootings in San Francisco by the Hour \nStarting from Midnight: {frame_time}",
       subtitle = "Data available for all days from January 2013 through June 2015 shows \ndramatic increase in shootings towards midnight",
       caption = "Source: Justice Tech Lab") +
  theme(plot.title = element_text(size = 20)) +
  theme(plot.subtitle = element_text(size = 15)) +
  theme(plot.caption = element_text(size = 10)) 
  
  anim_save("Shotspotter/sanfran_anim.gif", animation = last_animation())

  