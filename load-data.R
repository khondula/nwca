library(rgdal)
library(readxl)

###################
# EPA ATTAINS data
# OGC GeoPackage downloaded from
# https://www.epa.gov/exposure-assessment-models/303d-listed-impaired-waters#attains
# https://www.epa.gov/waterdata/waters-geospatial-data-downloads#305bWatersAsAssessed
#########################################
# NARS data
# Downloaded from 
# https://www.epa.gov/national-aquatic-resource-surveys/data-national-aquatic-resource-surveys
# 29 August 2016
#########################################
# read in NARS wetland data and metadata
#########################################

# SITE INFO
nars_site_info <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_siteinfo_081315.csv")
site_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/siteinfo_meta.txt")

# AA CHARACTERIZATION
nars_aa <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_assessment_04112014.csv")
aa_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/assessment_meta.txt")

# SURFACE WATER CHARACTERIZATION
# nars_swc <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_assewq_04112014.csv")
swc_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/assewq_meta.txt")

# HYDROLOGY
nars_hydr <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_hydro_04112014.csv")
hydr_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/hydro_meta.txt")

# PLANT VOUCHERS
nars_plantv <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_plantvoucher_04112014.csv")
plantv_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/plantvoucher_meta.txt")

# SOIL PROFILE
# nars_soilprofile <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_soilprof_04112014.csv")
soilprofile_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/soilprof_meta.txt")

# TREES
nars_trees <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_tree_04112014.csv")
trees_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/tree_meta.txt")

# VEG PLOT LAYOUT 
nars_vegplot <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_vegplot_04112014.csv")
vegplot_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/vegplot_meta.txt")

# VEG PLOT LOCATION 
nars_vegplotloc <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_vegplotloc_04112014.csv")
vegplotloc_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/vegplotloc_meta.txt")

# VEGETATION TYPE
nars_vegtype <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_vegtype_04112014.csv")
vegtype_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/vegtype_meta.txt")

# ALGAL TOXIN
nars_algtox <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_algt_04142014.csv")
algtox_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/algt_meta.txt")

# CHLOROPHYLL A
nars_chla <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_chla_012914.csv")
chla_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/chla_meta.txt")

# SOIL CHEMISTRY
nars_soilchem <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_soilchem_03192014.csv")
soilchem_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/soilchem_meta.txt")

# USARAM SUMMARY
nars_usaramsum <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_usaramsummary_04072014.csv")
usaramsum_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/usaramsummary_meta.txt")

# USARAM LINE DATA
nars_usaramline <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_usaramlinedata_04072014.csv")
usaramline <- read.delim("https://www.epa.gov/sites/production/files/2015-11/usaramlinedata_meta.txt")

# WATER CHEMISTRY
nars_waterchem <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_waterchem_012914.csv")
waterchem_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/waterchem_meta.txt")

# CONDITION AND STRESSOR VALUES
nars_condition <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_condstress_02052015.csv")
condition_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/condstress_meta.txt")

# PLANT TAXONOMIC INFORMATION
nars_tax <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_planttaxa_01302015.csv")
tax_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/planttaxa_meta.txt")

# PLANT CC VALUES
nars_plantcc <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_planttaxa_cc_01302015.csv")
plantcc_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/planttaxa_cc_meta.txt")

# PLANT WETLAND INDICATOR STATUS
nars_status <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_planttaxa_wis_01302015.csv")
status_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/planttaxa_wis_meta.txt")

# VEGETATION MMI VALUES
nars_mmi <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_vegmmi_01302015.csv")
mmi_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/vegmmi_meta.txt")

# REFERENCE STRESSOR INDICES
nars_refstress <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_refinputs_09022015.csv")
refstress_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/refinputs_meta.txt")

# BUFFER CHARACTERIZATION
nars_buffer <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_buffer_07072014.csv")
buffer_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/buffer_meta.txt")

# PLANT SPECIES
nars_plants <- read.csv("https://www.epa.gov/sites/production/files/2015-11/nwca2011_plant_08272014.csv")
plants_meta <- read.delim("https://www.epa.gov/sites/production/files/2015-11/plant_meta.txt")

#########################
# STREAM IMPAIRMENT DATA
#
# Downloaded shp files from EPA ATTAINS
# 303d impairment information
# 305b assessment information
#########################
# list.files("../")
# list.files(".")
# assessed_waters <- readOGR(dsn = "../rad_assd305b_20150618_shp/rad_assd305b_20150618/",
#                            layer = "rad_assd305b_l")
# saveRDS(assessed_waters, file = "rad_assd305b_l.RDS")
assessed_waters <- readRDS(file = "rad_assd305b_l.RDS")

# # listed_waters <- readOGR(dsn = "../rad_303d_20150501_shp/rad_303d_20150501/",
# #                          layer = "rad_303d_l")
# rm(listed_waters)
# rm(assessed_waters)

# IMPAIRMENT ATTRIBUTES
# list.files("../")
d303_attributes <- read_excel(path = "../attgeo_303dcaussrce_20150501.xlsx", skip = 2)
# ASSESSMENT ATTRIBUTES
b305_attributes <- read_excel(path = "../attgeo_305buses_20150618.xlsx", skip = 2)
