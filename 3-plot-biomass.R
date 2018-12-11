#This script makes a ggplot

#create biomass averages by management
name(data)

biomass.mgmt <- data %>% 
  select(Site, Transect, Management.rules,
         Observer, Fish.taxon, Size, Count, Biomass_kgha) %>% 
  group_by(Site, Transect, Management.rules) %>% 
  summarize(total.biomass = sum(Biomass_kgha))

head(biomass.mgmt)

ggplot(data = biomass.mgmt, aes(x = Management.rules, y =total.biomass)) + 
  geom_boxplot(aes(colour = Management.rules)) + 
  geom_point(aes(colour = Management.rules)) + 
  theme_bw(base_size = 18)

t.test(biomass.mgmt$total.biomass ~ biomass.mgmt$Management.rules)
             