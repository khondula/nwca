# map
# plot on map with location of assessed waters

library(leaflet)
library(magrittr)

leaflet() %>% 
  addProviderTiles("Esri.WorldImagery") %>%
  addMarkers(data = nars_site_info, lng = ~AA_CENTER_LON, lat = ~AA_CENTER_LAT) %>%
  addWMSTiles(
    "https://watersgeo.epa.gov/arcgis/services/OWRAD_NP21/305B_NP21/MapServer/WMSServer?",
    layers = "1",
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "")
