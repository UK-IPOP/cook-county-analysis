# this finds all files in the data directory and deletes them 
# with exception of the ones explicitly excepted
# NOTE: directories not included so the landuse shapes will remain
find data -type f,d -not -name 'data' -not -name 'CookCounty_Pharmacies.csv' -not -name 'landuse_data_dictionary.csv' -note -name 'output.csv' -delete