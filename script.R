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
  # i picked san francisco because i want to go there at some point and i would
  # want to study the status of gunfire incidents in the area before i go there
  # to be more informed
  
  clean_names()

# to ensure that all column names are named in an accessible and useful way, i
# use clean_names to make them all snake_case and lowercase

shapes <- places("ca", class = "sf", cb = TRUE) %>%
  
  # places() is best for finding a shapefile for just one location, i specify
  # the state and the class of the file i want to have
  
  filter(NAME == "San Francisco")

# i am only looking for data for San Francisco, so i filter results only for it

sanfran <- sanfran %>%
  
  # i am making changes to the dataset, so i just assign it to itself
  
  mutate(hour = hour(time)) %>% 
  
  # i want to make an animation of the map of SF as each hour of the day goes,
  # instead of looking at all times
  
  st_as_sf(coords = c("longitude", "latitude"), crs = st_crs(shapes))

# this function will create a shapefile out of the csv file i had initially by
# using the longitude and latitude of the data i already have

ggplot(data = shapes) +
  
  # i specify the data i want to use in my geom_sf() function which will create
  # the map
  
  geom_sf() +
  
  # i will be using geom_sf which works with shapefiles
  
  geom_sf(data = sanfran, aes(alpha = 0.4)) +
  
  # now i specify the data that i want to take variables from for the map and
  # specify the opacity of the points i want that would make it easy to observe
  # all points without layering them
  
  guides(alpha = FALSE) +
  
  # i dont want the legend to come up in my graph, so i say that its false in
  # the guides() function
  
  theme_map() +
  
  # i am using theme_map() from the ggthemes package to make my map look good
  # and concise
  
  coord_sf(xlim = c(-122.55, -122.3), ylim = c(37.7, 37.85)) +
  
  # i am limiting my coordinates because i only want the map of SF show up, so i
  # find the limits and specify them for x and y-axis
  
  transition_time(hour) +
  
  # i want my animation to show the transition the number of shootings undergo
  # as each hour of the day passes in San Francisco
  
  labs(title = "Aggregate Shootings in San Francisco by the Hour \nStarting from Midnight: {frame_time}",
       subtitle = "Data available for all days from January 2013 through June 2015 shows \ndramatic increase in shootings towards midnight",
       caption = "Source: Justice Tech Lab") +
  
  # i am assigning a title, subtitle, and a caption for my graph that are as
  # informative short and concise as they could be. my subtitle summarises a key
  # point i have about the data and my caption lists the source of my data
  
  theme(plot.title = element_text(size = 20)) +
  theme(plot.subtitle = element_text(size = 15)) +
  theme(plot.caption = element_text(size = 10)) 
  
  # i am making all of my text in the graph bigger than it was by assigning the
  # title, subtitle, and caption to bigger sizes, inside a theme() function in
  # the ggthemes package

  anim_save("Shotspotter/sanfran_anim.gif", animation = last_animation())
  
  # i found that a very practical way to show an animation in a shiny app is to
  # create it in a separate script and save it as a gif in the same folder where
  # the app is by using the anim_save() function and assigning it to an
  # appropriate name, specifying that its a .gif file
  # i specify the animation that i want to save by calling for a last_animation
  # that i have plotted

  