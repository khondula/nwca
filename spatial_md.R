# spatial analysis

# find nearest line segment from assessed waters
# to each NWCA point

# first do just for MD
library(dplyr)
library(rgdal)
library(rgeos)
library(raster)
library(stringr)

nars_sites_MD <- filter(nars_site_info, STATE == "MD")
rm(nars_site_info)
# d303_MD <- filter(d303_attributes, STATE == "MD")

# make nwca sites into spatialpointsdataframe
# DATUM - NAD 83
nars_sites_MD_sp <- SpatialPointsDataFrame(coords = cbind(nars_sites_MD$AA_CENTER_LON, 
                                                          nars_sites_MD$AA_CENTER_LAT),
                                           data = nars_sites_MD, 
                                           proj4string = CRS("+init=EPSG:4269"))

# clip listed waters to MD
# listed_waters_MD <- listed_waters[listed_waters@data$GEOGSTATE == "MD",]
# clip assessed waters to MD
assd_waters_MD <- assessed_waters[assessed_waters@data$GEOGSTATE == "MD",]

# project nwca sites to listed waters proj
# nars_sites_MD_sp <- spTransform(nars_sites_MD_sp, proj4string(listed_waters_MD))

# PROJECT TO PLANAR COORDINATES
# listed_waters_MD <- spTransform(listed_waters_MD, CRS("+proj=utm +north +zone=18 +datum=WGS84"))
nars_sites_MD_sp <- spTransform(nars_sites_MD_sp, CRS("+proj=utm +north +zone=18 +datum=WGS84"))
assd_waters_MD <- spTransform(assd_waters_MD, CRS("+proj=utm +north +zone=18 +datum=WGS84"))

# CALCULATE DISTANCES BETWEEN NWCA SITES AND ASSESSED WATERS
# what are units - assume meters??
dist_nwca_assd_md <- gDistance(nars_sites_MD_sp, assd_waters_MD, byid = TRUE)
dist_nwca_assd_md <- as.data.frame(dist_nwca_assd_md)
names(dist_nwca_assd_md) <- nars_sites_MD_sp@data$SITE_ID

# dplyr::summarise_each(dist_nwca_assd_md, funs(min))

# find PERMID of assessed waters for a NWCA site 
# based on closest distance
# AND distance


# sapply(1:ncol(dist_nwca_assd_md), function(x) )
# FIND MIN DISTANCE
assd_waters_MD@data$PERMID <- as.character(assd_waters_MD@data$PERMID)
dist_md <- sapply(1:31, function(x) 
  dist_nwca_assd_md[which(dist_nwca_assd_md[[x]]== min(dist_nwca_assd_md[[x]])),x])
permid_md <- sapply(1:31, function(x) 
  assd_waters_MD@data[which(dist_nwca_assd_md[[x]]== min(dist_nwca_assd_md[[x]])),"PERMID"])
f <- as.data.frame(cbind(as.character(nars_sites_MD_sp@data$SITE_ID), permid_md))
f$distances <- dist_md
colnames(f)[1] <- "SITE_ID"
colnames(f)[2] <- "PERMID"

# GET CONDITION DATA
f_cond <- left_join(f, nars_condition[,c("VMMI", "VEGCOND", "SITE_ID")])
f_cond <- left_join(f_cond, assd_waters_MD@data[, c("SRCE_DESCR", "PERMID", "DETAILURL", "ESRI_KEY")])
# f_cond <- left_join(f_cond, d303_attributes)
head(f_cond)
# assd_waters_MD@data$SRCE_DESCR
# The state-reported attainment status of the water. The Water Status is calculated based on a review of all assessed designated uses. If all designated uses are fully supporting then the Water Status is "Good". If one designated use is not supporting, not attainable, or is partially supporting, then the Water Status is "Impaired". If the water is neither "Good" nor "Impaired" and at least one designated use is threatened, then the Water Status is "Threatened". For waters where no designated uses were assessed then the Water Status is NULL.
distances_md <- gDistance(nars_sites_MD_sp, listed_waters_MD, byid = TRUE)
distances_md <- as.data.frame(distances_md)
colnames(distances_md) <- nars_sites_MD_sp@data$SITE_ID

which(distances_md[[1]]== min(distances_md[[1]]))
distances_md[18,1]
row.names(distances_md)[18]
listed_waters_MD@data[18,]
nars_sites_MD_sp@data[1,"SITE_ID"]

# find row ID of min value in each column
apply(distances_md, 2, FUN=min)
apply(dist_nwca_assd_md, 2, FUN=min)
head(assd_waters_MD@data)
# dist_calcs <- gWithinDistance(nars_sites_MD_sp, spgeom2=listed_waters_MD, 
#                               dist, byid=FALSE,
#                 hausdorff=FALSE, densifyFrac=NULL)

# make buffer of 200m around each point from nwca
# find line objects from impaired waters that are within 
# clip assessed waters to MD


