#This script makes a ggplot

#create biomass averages by management
names(data)

table(data$Management.rules)

#new dataset with biomass
biomass.mgmt <- data %>% 
  select(Site, Transect, Management.rules,
         Observer, Fish.taxon, Size, Count, Biomass_kgha) %>% 
  group_by(Site, Transect, Management.rules) %>% 
  summarize(total.biomass = sum(Biomass_kgha))

head(biomass.mgmt)

unique(tota)

#simple ggplot
ggplot(data = biomass.mgmt, aes(x = Management.rules, y =total.biomass)) + 
  geom_boxplot(aes(colour = Management.rules)) + 
  geom_point(aes(colour = Management.rules)) + 
  theme_bw(base_size = 18)

#t-test, is there a sigificant difference by management? 
t.test(biomass.mgmt$total.biomass ~ biomass.mgmt$Management.rules)

#let's start with some more advanced ggplots
ggplot(data = biomass.mgmt, 
       aes(x = Site, y = total.biomass, colour = Management.rules)) + 
  geom_boxplot() + 
  geom_point(alpha = 0.25, size = 4) + 
  theme_bw(base_size = 18)

#make a facet by Management.rules
last_plot() + facet_wrap(~Management.rules, scales = "free_x")







             