# spatial analysis

# find nearest line segment from assessed waters
# to each NWCA point

# first do just for MD
library(dplyr)
library(rgdal)
library(rgeos)
library(raster)
library(stringr)

# d303_MD <- filter(d303_attributes, STATE == "MD")

# make nwca sites into spatialpointsdataframe
# DATUM - NAD 83
# split up nars sites into chunks of 50
nars_sites1 <- nars_site_info[1:50,]

nars_site_info_sp <- SpatialPointsDataFrame(coords = cbind(nars_sites1$AA_CENTER_LON, 
                                                           nars_sites1$AA_CENTER_LAT),
                                            data = nars_sites1, 
                                            proj4string = CRS("+init=EPSG:4269"))

nars_site_info_sp <- SpatialPointsDataFrame(coords = cbind(nars_site_info$AA_CENTER_LON, 
                                                          nars_site_info$AA_CENTER_LAT),
                                           data = nars_site_info, 
                                           proj4string = CRS("+init=EPSG:4269"))

# PROJECT TO PLANAR COORDINATES
# ESRI:102003
proj1 <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
nars_site_info_sp <- spTransform(nars_site_info_sp, proj1)
assessed_waters_proj <- spTransform(assessed_waters, proj1)
rm(assessed_waters)
# CALCULATE DISTANCES BETWEEN NWCA SITES AND ASSESSED WATERS
# what are units - assume meters??
test1 <- gWithinDistance(nars_site_info_sp, assessed_waters_proj, byid = TRUE, dist = 10000)

test1 <- as.data.frame(test1)
which(test1$`1`==TRUE)

dist_nwca_assd <- gDistance(nars_site_info_sp, assessed_waters_proj, byid = TRUE)
dist_nwca_assd <- as.data.frame(dist_nwca_assd)
names(dist_nwca_assd) <- nars_site_info_sp@data$SITE_ID

# find PERMID of assessed waters for a NWCA site 
# based on closest distance
# AND distance

# FIND MIN DISTANCE
assessed_waters_proj@data$PERMID <- as.character(assessed_waters_proj@data$PERMID)
dist <- sapply(1:31, function(x) 
  dist_nwca_assd[which(dist_nwca_assd[[x]]== min(dist_nwca_assd[[x]])),x])
# FIND PERMID OF MIN DISTANCE WATER
permid_md <- sapply(1:31, function(x) 
  assessed_waters_proj@data[which(dist_nwca_assd[[x]]== min(dist_nwca_assd[[x]])),"PERMID"])

f <- as.data.frame(cbind(as.character(nars_site_info_sp@data$SITE_ID), permid_md))
f$distances <- dist_md
colnames(f)[1] <- "SITE_ID"
colnames(f)[2] <- "PERMID"

# GET CONDITION DATA
f_cond <- left_join(f, nars_condition[,c("VMMI", "VEGCOND", "SITE_ID")])
f_cond <- left_join(f_cond, assessed_waters_proj@data[, c("SRCE_DESCR", "PERMID", "DETAILURL", "ESRI_KEY")])
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


