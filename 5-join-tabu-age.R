#This script is to join a new .csv file about tabu age

head(biomass.mgmt)

#let's read a csv file with tabu age
getwd()
tabu.age <- read.csv("/Users/emilydarling/GitHub/WCS-Marine/learning-R/Tabu-age.csv",
                 header = TRUE, stringsAsFactors = TRUE)
tabu.age

#let's join this new csv file to our biomass file
biomass.mgmt.tabu <- biomass.mgmt %>% 
  left_join(tabu.age, by = "Site")
biomass.mgmt.tabu

#now we can repeat our avg-biomass file usinng Tabu.age as the grouping variable

biomass.mgmt.sort <- biomass.mgmt.tabu %>% 
  group_by(Tabu.age, Site) %>% 
  summarize(avg.biomass = mean(total.biomass)) %>% 
  # 1. Arrange by
  #   i.  Management.rules
  #   ii. avg.biomass in descending order from high to low
  arrange(Tabu.age, desc(avg.biomass)) %>% 
  #2. Add a new 'order' column from the row number of the sort
  #   i. 'mutate' is a dplyr function to add a new column to a dataframe
  mutate(order = row_number())
biomass.mgmt.sort

#for this ggplot, we will use the new 'order' variable as the x-axis
#we will make it a discrete factor-type variable using the 'as.factor' command
ggplot(data = biomass.mgmt.sort, 
       aes(x = as.factor(order), y = avg.biomass)) + 
  #1. set up a bar plot using the average site-level biomass
  geom_bar(stat = "identity",  aes(fill = Tabu.age), 
           show.legend = FALSE) + 
  #2. facet the plot by Management
  facet_wrap(~ Tabu.age, scales = "free_x") + 
  theme_bw(base_size = 14) + 
  #Replace the order labels to the Site names
  #   i. scale_x_discrete is how we edit the x-axis when it is a discrete variable
  scale_x_discrete("Site", 
                   breaks = biomass.mgmt.sort$order,
                   labels = biomass.mgmt.sort$Site)

