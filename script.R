library(tidyverse)
library(sf)
library(tigris)
library(ggthemes)
library(gganimate)
library(janitor)
library(lubridate)

sanfran <- read_csv("http://justicetechlab.org/wp-content/uploads/2018/05/San_Francisco_ShotSpotter.csv") %>% 
  clean_names()

shapes <- places("ca", class = "sf", cb = TRUE) %>%
  filter(NAME == "San Francisco")

sanfran <- sanfran %>%
  mutate(hour = hour(time)) %>% 
  st_as_sf(coords = c("longitude", "latitude"), crs = st_crs(shapes))

ggplot(data = shapes) +
  geom_sf() +
  geom_sf(data = sanfran, aes(alpha = 0.4)) +
  theme(legend.position = "none") +
  theme_map() +
  coord_sf(xlim = c(-122.55, -122.3), ylim = c(37.7, 37.85)) +
  transition_time(hour) +
  labs(title = "Shootings in San Francisco by the Hour Starting from Midnight {frame_time}",
       subtitle = "Data from January 2013 through June 2015 shows increase in shootings at _",
       caption = "Source: Justice Tech Lab") 
  anim_save(sanfran_anim, animation = last_animation())

  