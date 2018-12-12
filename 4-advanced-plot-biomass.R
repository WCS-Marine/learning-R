#This script is for advanced ggplots
#Specifically reorderig the x-axis of plots

#let's reorder the x-axis by each sorting from high to low average biomass
#but WITHIN each of the managemet facets 
#this is surprisingly difficult.. hopefully a new update to R soon! 

#first we need to adapt the original dataframe
#we will add a new variable called 'order' for the order we want in the x-axis

head(biomass.mgmt)

biomass.mgmt.sort <- biomass.mgmt %>% 
  group_by(Management.rules, Site) %>% 
  summarize(avg.biomass = mean(total.biomass)) %>% 
  # 1. Arrange by
  #   i.  Management.rules
  #   ii. avg.biomass in descending order from high to low
  arrange(Management.rules, desc(avg.biomass)) %>% 
  #2. Add a new 'order' column from the row number of the sort
  #   i. 'mutate' is a dplyr function to add a new column to a dataframe
  mutate(order = row_number())
biomass.mgmt.sort

#for this ggplot, we will use the new 'order' variable as the x-axis
#we will make it a discrete factor-type variable using the 'as.factor' command
ggplot(data = biomass.mgmt.sort, 
       aes(x = as.factor(order), y = avg.biomass)) + 
  #1. set up a bar plot using the average site-level biomass
  geom_bar(stat = "identity",  aes(fill = Management.rules), 
           show.legend = FALSE) + 
  #2. facet the plot by Management
  facet_wrap(~ Management.rules, scales = "free_x") + 
  theme_bw(base_size = 14) + 
  #Replace the order labels to the Site names
  #   i. scale_x_discrete is how we edit the x-axis when it is a discrete variable
  scale_x_discrete("Site", 
                   breaks = biomass.mgmt.sort$order,
                   labels = biomass.mgmt.sort$Site)

