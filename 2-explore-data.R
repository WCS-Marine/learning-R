# This script provides some simple summaries for the MERMAID csv file using tidyverse
# Don't forget to run the other scripts (00-install.R and 1-load-data.R)

# check that your data are ready to go
head(data)

## ---------------------------------------------------------------
#let's select a few columns to work with 
data2 <- data %>% 
  select(Site, Transect, Observer, Fish.taxon, Size, Count, Biomass_kgha)

head(data2)
names(data2)

## ---------------------------------------------------------------
# now let's make some summaries of the information
# how many fish were observed on each transect? 
transect.count <- data2 %>% 
  group_by(Site, Transect) %>% 
  summarize(n.fish = sum(Count))

head(transect.count)

#let's make a histogram
hist(transect.count$n.fish)

#summarize this information
summary(transect.count$n.fish)
skim(transect.count$n.fish)

## ---------------------------------------------------------------
# how many of EACH fish taxon were observed on the transects
# we do this by adding 'Fish.taxon' into the grouping variables
transect.count.taxon <- data2 %>% 
  group_by(Site, Transect, Fish.taxon) %>% 
  summarize(n.fish = sum(Count))

head(transect.count.taxon)

# let's arrange this from most to least observed fish taxon
transect.count.taxon <- transect.count.taxon %>% 
  arrange(desc(n.fish))

# and now summarize this information
summary(transect.count.taxon$n.fish)
skim(transect.count.taxon$n.fish)

#let's make another histogram
hist(transect.count.taxon$n.fish)

## ---------------------------------------------------------------
#let's make some summaries of total biomass by each transect and site
head(data2)

biomass <- data2 %>% 
  group_by(Site, Transect, Observer) %>% 
  summarize(total.biomass = sum(Biomass_kgha))

head(biomass)

summary(biomass$total.biomass)
skim(biomass$total.biomass)
hist(biomass$total.biomass)

