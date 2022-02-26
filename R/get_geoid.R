# DEPRECATED
# DELETE
# USE geospatialized::get_geoid()











# options(tigris_use_cache = TRUE)
#
# stopifnot("No US Census API key found. Go to https://www.census.gov/data/developers.html,
#           click on the Request a Key icon, and use the tidycensus::census_api_key()
#           command to install a US Census API key in the current user .Renviron" =
#             Sys.getenv("CENSUS_API_KEY") != "")
#
#
# data(list = "fips_codes", package = "tidycensus")
#
#
#
# sentance_case <- function(x) paste0(toupper(substr(x, 1, 1)), tolower(substring(x, 2)))
#
#
#
# get_acs_variable_catalog <- function(year = 2019,
#                                      dataset = "acs5",
#                                      label_filter = "*",
#                                      concept_filter = "*") {
#   tidycensus::load_variables(year, dataset, cache = TRUE) %>%
#     dplyr::filter(grepl(label_filter, label, ignore.case = TRUE)) %>%
#     dplyr::filter(grepl(concept_filter, concept, ignore.case = TRUE)) %>%
#     dplyr::mutate(label = stringr::str_replace_all(label, c(
#       "!!" = " ",
#       "Estimate" = "",
#       ":" = ""
#     )),
#     concept = sentance_case(concept)
#     )
# }
#
# # Examples
# # get_acs_variable_catalog() %>% View()
# # get_acs_variable_catalog(label_filter = "transportation", concept_filter = "vehicle") %>% View()
#
#
# get_state_fips_codes <- function(x) {
#   data("fips_codes", package = "tidycensus")
#   x <- tolower(x)
#   tidycensus::fips_codes %>%
#     dplyr::filter(tolower(state_name) %in% x) %>%
#     dplyr::distinct(state_code) %>%
#     dplyr::pull(state_code)
# }
#
# states_needed <- get_state_fips_codes("Oregon")
#
#
# get_acs_geometry <- function(states_needed) {
#   acs_geometry <- list()
#
#   # get geometry from ACS total population variable
#   acs_geometry$block_groups <- tidycensus::get_acs(geography = 'block group',
#                     variables = 'B01003_001',
#                     state = states_needed,
#                     geometry = TRUE) %>%
#     sf::st_transform(crs = 4326)
#
#   acs_geometry$census_tracts <- tidycensus::get_acs(geography = 'tract',
#                               variables = 'B01003_001',
#                               state = states_needed,
#                               geometry = TRUE) %>%
#     sf::st_transform(crs = 4326)
#
#
#   acs_geometry$counties <- tidycensus::get_acs(geography = 'county',
#                     variables = 'B01003_001',
#                     state = states_needed,
#                     geometry = TRUE) %>%
#     sf::st_transform(crs = 4326)
#
#   acs_geometry$states <- tidycensus::get_acs(geography = 'state',
#                         variables = 'B01003_001',
#                         state = states_needed,
#                         geometry = TRUE) %>%
#     sf::st_transform(crs = 4326)
#
#   return(acs_geometry)
# }
#
# # rename acs_census_tracts and others acs_geometry$census_tract
# acs_geometry <- get_acs_geometry(states_needed)
#
#
#
# lon = -122.718111
# lat = 45.508776
#
#
#
#
# get_block_group <- function(lon,  lat, block_group_geometry = acs_geometry$block_groups) {
#   pt <- data.frame(lon, lat) %>%
#     sf::st_as_sf(coords = c("lon", "lat"),
#                  crs = sf::st_crs(block_group_geometry))
#   # ensure only one row is returned
#   census_row = unlist(sf::st_within(pt, block_group_geometry))[1]
#   return(acs_geometry$block_groups[census_row, ]$GEOID)  }
#
# library(leaflet)
# library(stringr)
# # add constant for OSMI_HC_Kendall_Goto_M1:
# target_lon = -122.718111
# target_lat = 45.508776
#
# target_location <- data.frame(lon = target_lon,
#                        lat = target_lat) %>%
#   sf::st_as_sf(coords = c("lon", "lat"), crs = 4326, agr = "constant")
#
# target_block_group <- get_block_group(target_lon, target_lat)
# target_census_tract <- str_sub(as.character(target_block_group), 1, 11)
# target_county <- str_sub(as.character(target_block_group), 1, 5)
# target_state <- str_sub(as.character(target_block_group), 1, 2)
#
#
#
#
# leaflet(width = "100%") %>%
#   addProviderTiles(provider = "CartoDB.Positron") %>%
#   addPolygons(
#     data =   filter(acs_geometry$states, str_sub(GEOID, 1, 2) == target_state),
#     popup = ~ paste(GEOID,  NAME),
#     smoothFactor = 0,
#     weight = 6,
#     fillOpacity = 0,
#     color = "#333333") %>%
#   addPolygons(
#     data =   filter(acs_geometry$counties, str_sub(GEOID, 1, 5) == target_county),
#     popup = ~ paste(GEOID,  NAME),
#     smoothFactor = 0,
#     weight = 4,
#     fillOpacity = 0,
#     color = "#0000ff") %>%
#   addPolygons(
#     data =   filter(acs_geometry$census_tracts, str_sub(GEOID, 1, 11) == target_census_tract),
#     popup = ~ paste(GEOID,  NAME),
#     smoothFactor = 0,
#     weight = 3,
#     fillOpacity = 0,
#     color = "#004400",
#   fillColor = "#f5deb3") %>%
#   addPolygons(
#     data =   filter(acs_geometry$block_groups,GEOID == target_block_group),
#     popup = ~ paste(GEOID,  NAME),
#     smoothFactor = 0,
#     weight = 1.5,
#     fillOpacity =0,
#     color = "#000000",
#     fillColor = "#ffffff") %>%
#   addMarkers(data = target_location,
#              popup = paste(unlist(target_location), collapse = ", ")) %>%
#   setView(target_lon, target_lat, zoom = 14)
#
