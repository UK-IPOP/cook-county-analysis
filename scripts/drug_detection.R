######################
install.packages("pacman", repos='http://cran.us.r-project.org')

pacman::p_load(readr, lubridate, tidyverse, dplyr, stringr)

# library(readr)
# library(lubridate)
# library(tidyverse)
# library(dplyr)
# library(stringr)


# cleaning for 2nd primary cause linea 
county<- read.csv("./data/geocoded_case_archives.csv")
y<-county$primarycause_linea
z<-str_split_fixed(y,"AND|;|,",n=13)
colnames(z)<-c("z1","z2","z3","z4","z5","z6","z7","z8","z9","z10","z11","z12","z13")
z<-as.data.frame(z)

#################
#COCAINE
#####################
z$z1[grep("COCAIN",z$z1)]<-"COCAINE"
z$z2[grep("COCAIN",z$z2)]<-"COCAINE"
z$z3[grep("COCAIN",z$z3)]<-"COCAINE"
z$z4[grep("COCAIN",z$z4)]<-"COCAINE"
z$z5[grep("COCAIN",z$z5)]<-"COCAINE"
z$z6[grep("COCAIN",z$z6)]<-"COCAINE"
z$z7[grep("COCAIN",z$z7)]<-"COCAINE"
z$z8[grep("COCAIN",z$z8)]<-"COCAINE"
z$z9[grep("COCAIN",z$z9)]<-"COCAINE"
z$z10[grep("COCAIN",z$z10)]<-"COCAINE"
z$z11[grep("COCAIN",z$z11)]<-"COCAINE"
z$z12[grep("COCAIN",z$z12)]<-"COCAINE"
z$z13[grep("COCAIN",z$z13)]<-"COCAINE"

##############################
#MDA
##############################
z$z1[grep("MDA",z$z1)]<-"MDA"
z$z2[grep("MDA",z$z2)]<-"MDA"
z$z3[grep("MDA",z$z3)]<-"MDA"
z$z4[grep("MDA",z$z4)]<-"MDA"
z$z5[grep("MDA",z$z5)]<-"MDA"
z$z6[grep("MDA",z$z6)]<-"MDA"
z$z7[grep("MDA",z$z7)]<-"MDA"
z$z8[grep("MDA",z$z8)]<-"MDA"
z$z9[grep("MDA",z$z9)]<-"MDA"
z$z10[grep("MDA",z$z10)]<-"MDA"
z$z11[grep("MDA",z$z11)]<-"MDA"
z$z12[grep("MDA",z$z12)]<-"MDA"
z$z13[grep("MDA",z$z13)]<-"MDA"


#################################
#  METHYLENEDIOXYMETHAMPHETAMINE / MDMA
#################################
z$z1[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z1)]<-"MDMA"
z$z2[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z2)]<-"MDMA"
z$z3[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z3)]<-"MDMA"
z$z4[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z4)]<-"MDMA"
z$z5[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z5)]<-"MDMA"
z$z6[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z6)]<-"MDMA"
z$z7[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z7)]<-"MDMA"
z$z8[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z8)]<-"MDMA"
z$z9[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z9)]<-"MDMA"
z$z10[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z10)]<-"MDMA"
z$z11[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z11)]<-"MDMA"
z$z12[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z12)]<-"MDMA"
z$z13[grep("METHYLENEDIOXYMETHAMPHETAMINE|METHYLEN|MDMA",z$z13)]<-"MDMA"

##########################
# METHAMPHETAMINE/MAT_MINE
#############################  
z$z1[grep("METHAMPHETAMINE",z$z1)]<-"MAT_MINE"
z$z2[grep("METHAMPHETAMINE",z$z2)]<-"MAT_MINE"
z$z3[grep("METHAMPHETAMINE",z$z3)]<-"MAT_MINE"
z$z4[grep("METHAMPHETAMINE",z$z4)]<-"MAT_MINE"
z$z5[grep("METHAMPHETAMINE",z$z5)]<-"MAT_MINE"
z$z6[grep("METHAMPHETAMINE",z$z6)]<-"MAT_MINE"
z$z7[grep("METHAMPHETAMINE",z$z7)]<-"MAT_MINE"
z$z8[grep("METHAMPHETAMINE",z$z8)]<-"MAT_MINE"
z$z9[grep("METHAMPHETAMINE",z$z9)]<-"MAT_MINE"
z$z10[grep("METHAMPHETAMINE",z$z10)]<-"MAT_MINE"
z$z11[grep("METHAMPHETAMINE",z$z11)]<-"MAT_MINE"
z$z12[grep("METHAMPHETAMINE",z$z12)]<-"MAT_MINE"
z$z13[grep("METHAMPHETAMINE",z$z13)]<-"MAT_MINE"

#############################
#AMPHETAMINE
##############################
z$z1[grep("AMPHE",z$z1)]<-"AMPHETAMINE"
z$z2[grep("AMPHE",z$z2)]<-"AMPHETAMINE"
z$z3[grep("AMPHE",z$z3)]<-"AMPHETAMINE"
z$z4[grep("AMPHE",z$z4)]<-"AMPHETAMINE"
z$z5[grep("AMPHE",z$z5)]<-"AMPHETAMINE"
z$z6[grep("AMPHE",z$z6)]<-"AMPHETAMINE"
z$z7[grep("AMPHE",z$z7)]<-"AMPHETAMINE"
z$z8[grep("AMPHE",z$z8)]<-"AMPHETAMINE"
z$z9[grep("AMPHE",z$z9)]<-"AMPHETAMINE"
z$z10[grep("AMPHE",z$z10)]<-"AMPHETAMINE"
z$z11[grep("AMPHE",z$z11)]<-"AMPHETAMINE"
z$z12[grep("AMPHE",z$z12)]<-"AMPHETAMINE"
z$z13[grep("AMPHE",z$z13)]<-"AMPHETAMINE"

######################
#METHYLPHENIDATE
#####################
z$z1[grep("METHYLPH",z$z1)]<-"METHYLPHENIDATE"   
z$z2[grep("METHYLPH",z$z2)]<-"METHYLPHENIDATE"
z$z3[grep("METHYLPH",z$z3)]<-"METHYLPHENIDATE"
z$z4[grep("METHYLPH",z$z4)]<-"METHYLPHENIDATE"
z$z5[grep("METHYLPH",z$z5)]<-"METHYLPHENIDATE"
z$z6[grep("METHYLPH",z$z6)]<-"METHYLPHENIDATE"
z$z7[grep("METHYLPH",z$z7)]<-"METHYLPHENIDATE"
z$z8[grep("METHYLPH",z$z8)]<-"METHYLPHENIDATE"
z$z9[grep("METHYLPH",z$z9)]<-"METHYLPHENIDATE"
z$z10[grep("METHYLPH",z$z10)]<-"METHYLPHENIDATE"
z$z11[grep("METHYLPH",z$z11)]<-"METHYLPHENIDATE"
z$z12[grep("METHYLPH",z$z12)]<-"METHYLPHENIDATE"
z$z13[grep("METHYLPH",z$z13)]<-"METHYLPHENIDATE"

#####################
#MITRAGYNINE
######################
z$z1[grep("MITRAGY",z$z1)]<-"MITRAGYNINE"
z$z2[grep("MITRAGY",z$z2)]<-"MITRAGYNINE"
z$z3[grep("MITRAGY",z$z3)]<-"MITRAGYNINE"
z$z4[grep("MITRAGY",z$z4)]<-"MITRAGYNINE"
z$z5[grep("MITRAGY",z$z5)]<-"MITRAGYNINE"
z$z6[grep("MITRAGY",z$z6)]<-"MITRAGYNINE"
z$z7[grep("MITRAGY",z$z7)]<-"MITRAGYNINE"
z$z8[grep("MITRAGY",z$z8)]<-"MITRAGYNINE"
z$z9[grep("MITRAGY",z$z9)]<-"MITRAGYNINE"
z$z10[grep("MITRAGY",z$z10)]<-"MITRAGYNINE"
z$z11[grep("MITRAGY",z$z11)]<-"MITRAGYNINE"
z$z12[grep("MITRAGY",z$z12)]<-"MITRAGYNINE"
z$z13[grep("MITRAGY",z$z13)]<-"MITRAGYNINE"

######################
# PHENCYCLIDINE(PCP)
#####################
z$z1[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z1)]<-"PCP"
z$z2[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z2)]<-"PCP"
z$z3[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z3)]<-"PCP"
z$z4[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z4)]<-"PCP"
z$z5[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z5)]<-"PCP"
z$z6[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z6)]<-"PCP"
z$z7[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z7)]<-"PCP"
z$z8[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z8)]<-"PCP"
z$z9[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z9)]<-"PCP"
z$z10[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z10)]<-"PCP"
z$z11[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z11)]<-"PCP"
z$z12[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z12)]<-"PCP"
z$z13[grep("PHENCYCLIDINE|PCP|PHENCYCL",z$z13)]<-"PCP"

########################
#KETAMINE
###########################
z$z1[grep("KETAMINE",z$z1)]<-"KETAMINE"
z$z2[grep("KETAMINE",z$z2)]<-"KETAMINE"
z$z3[grep("KETAMINE",z$z3)]<-"KETAMINE"
z$z4[grep("KETAMINE",z$z4)]<-"KETAMINE"
z$z5[grep("KETAMINE",z$z5)]<-"KETAMINE"
z$z6[grep("KETAMINE",z$z6)]<-"KETAMINE"
z$z7[grep("KETAMINE",z$z7)]<-"KETAMINE"
z$z8[grep("KETAMINE",z$z8)]<-"KETAMINE"
z$z9[grep("KETAMINE",z$z9)]<-"KETAMINE"
z$z10[grep("KETAMINE",z$z10)]<-"KETAMINE"
z$z11[grep("KETAMINE",z$z11)]<-"KETAMINE"
z$z12[grep("KETAMINE",z$z12)]<-"KETAMINE"
z$z13[grep("KETAMINE",z$z13)]<-"KETAMINE"

##########################
# LYSERGIC ACID DIETHYLAMIDE(LSD)
###########################
z$z1[grep("LYSERGIC|LSD",z$z1)]<-"LSD"
z$z2[grep("LYSERGIC|LSD",z$z2)]<-"LSD"
z$z3[grep("LYSERGIC|LSD",z$z3)]<-"LSD"
z$z4[grep("LYSERGIC|LSD",z$z4)]<-"LSD"
z$z5[grep("LYSERGIC|LSD",z$z5)]<-"LSD"
z$z6[grep("LYSERGIC|LSD",z$z6)]<-"LSD"
z$z7[grep("LYSERGIC|LSD",z$z7)]<-"LSD"
z$z8[grep("LYSERGIC|LSD",z$z8)]<-"LSD"
z$z9[grep("LYSERGIC|LSD",z$z9)]<-"LSD"
z$z10[grep("LYSERGIC|LSD",z$z10)]<-"LSD"
z$z11[grep("LYSERGIC|LSD",z$z11)]<-"LSD"
z$z12[grep("LYSERGIC|LSD",z$z12)]<-"LSD"
z$z13[grep("LYSERGIC|LSD",z$z13)]<-"LSD"

#####################
#BENZODIAZEPINE
#########################
z$z1[grep("BENZODIA",z$z1)]<-"BENZODIAZEPINE"
z$z2[grep("BENZODIA",z$z2)]<-"BENZODIAZEPINE"
z$z3[grep("BENZODIA",z$z3)]<-"BENZODIAZEPINE"
z$z4[grep("BENZODIA",z$z4)]<-"BENZODIAZEPINE"
z$z5[grep("BENZODIA",z$z5)]<-"BENZODIAZEPINE"
z$z6[grep("BENZODIA",z$z6)]<-"BENZODIAZEPINE"
z$z7[grep("BENZODIA",z$z7)]<-"BENZODIAZEPINE"
z$z8[grep("BENZODIA",z$z8)]<-"BENZODIAZEPINE"
z$z9[grep("BENZODIA",z$z9)]<-"BENZODIAZEPINE"
z$z10[grep("BENZODIA",z$z10)]<-"BENZODIAZEPINE"
z$z11[grep("BENZODIA",z$z11)]<-"BENZODIAZEPINE"
z$z12[grep("BENZODIA",z$z12)]<-"BENZODIAZEPINE"
z$z13[grep("BENZODIA",z$z13)]<-"BENZODIAZEPINE"

##################
#BARBITURATE
####################
z$z1[grep("BARBITU",z$z1)]<-"BARBITURATE"
z$z2[grep("BARBITU",z$z2)]<-"BARBITURATE"
z$z3[grep("BARBITU",z$z3)]<-"BARBITURATE"
z$z4[grep("BARBITU",z$z4)]<-"BARBITURATE"
z$z5[grep("BARBITU",z$z5)]<-"BARBITURATE"
z$z6[grep("BARBITU",z$z6)]<-"BARBITURATE"
z$z7[grep("BARBITU",z$z7)]<-"BARBITURATE"
z$z8[grep("BARBITU",z$z8)]<-"BARBITURATE"
z$z9[grep("BARBITU",z$z9)]<-"BARBITURATE"
z$z10[grep("BARBITU",z$z10)]<-"BARBITURATE"
z$z11[grep("BARBITU",z$z11)]<-"BARBITURATE"
z$z12[grep("BARBITU",z$z12)]<-"BARBITURATE"
z$z13[grep("BARBITU",z$z13)]<-"BARBITURATE"

##################
#HYPOXIC/ISCHEMIC
####################
z$z1[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z1)]<-"HYPOXIC/ISCHEMIC"
z$z2[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z2)]<-"HYPOXIC/ISCHEMIC"
z$z3[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z3)]<-"HYPOXIC/ISCHEMIC"
z$z4[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z4)]<-"HYPOXIC/ISCHEMIC"
z$z5[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z5)]<-"HYPOXIC/ISCHEMIC"
z$z6[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z6)]<-"HYPOXIC/ISCHEMIC"
z$z7[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z7)]<-"HYPOXIC/ISCHEMIC"
z$z8[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z8)]<-"HYPOXIC/ISCHEMIC"
z$z9[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z9)]<-"HYPOXIC/ISCHEMIC"
z$z10[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z10)]<-"HYPOXIC/ISCHEMIC"
z$z11[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z11)]<-"HYPOXIC/ISCHEMIC"
z$z12[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z12)]<-"HYPOXIC/ISCHEMIC"
z$z13[grep("HYPOXIC/ISCHEMIC|HYPOXIC|HYPOXIC-ISCHEMIC",z$z13)]<-"HYPOXIC/ISCHEMIC"

####################
#CYCLOBENZAPRINE
#####################
z$z1[grep("CYCLOBENZAP",z$z1)]<-"CYCLOBENZAPRINE"
z$z2[grep("CYCLOBENZAP",z$z2)]<-"CYCLOBENZAPRINE"
z$z3[grep("CYCLOBENZAP",z$z3)]<-"CYCLOBENZAPRINE"
z$z4[grep("CYCLOBENZAP",z$z4)]<-"CYCLOBENZAPRINE"
z$z5[grep("CYCLOBENZAP",z$z5)]<-"CYCLOBENZAPRINE"
z$z6[grep("CYCLOBENZAP",z$z6)]<-"CYCLOBENZAPRINE"
z$z7[grep("CYCLOBENZAP",z$z7)]<-"CYCLOBENZAPRINE"
z$z8[grep("CYCLOBENZAP",z$z8)]<-"CYCLOBENZAPRINE"
z$z9[grep("CYCLOBENZAP",z$z9)]<-"CYCLOBENZAPRINE"
z$z10[grep("CYCLOBENZAP",z$z10)]<-"CYCLOBENZAPRINE"
z$z11[grep("CYCLOBENZAP",z$z11)]<-"CYCLOBENZAPRINE"
z$z12[grep("CYCLOBENZAP",z$z12)]<-"CYCLOBENZAPRINE"
z$z13[grep("CYCLOBENZAP",z$z13)]<-"CYCLOBENZAPRINE"

#################
#METAXALONE
###################
z$z1[grep("METAXAL",z$z1)]<-"METAXALONE"
z$z2[grep("METAXAL",z$z2)]<-"METAXALONE"
z$z3[grep("METAXAL",z$z3)]<-"METAXALONE"
z$z4[grep("METAXAL",z$z4)]<-"METAXALONE"
z$z5[grep("METAXAL",z$z5)]<-"METAXALONE"
z$z6[grep("METAXAL",z$z6)]<-"METAXALONE"
z$z7[grep("METAXAL",z$z7)]<-"METAXALONE"
z$z8[grep("METAXAL",z$z8)]<-"METAXALONE"
z$z9[grep("METAXAL",z$z9)]<-"METAXALONE"
z$z10[grep("METAXAL",z$z10)]<-"METAXALONE"
z$z11[grep("METAXAL",z$z11)]<-"METAXALONE"
z$z12[grep("METAXAL",z$z12)]<-"METAXALONE"
z$z13[grep("METAXAL",z$z13)]<-"METAXALONE"

#################
#METHOCARBAMOL
###################
z$z1[grep("METHOCARBAMOL",z$z1)]<-"METHOCARBAMOL"
z$z2[grep("METHOCARBAMOL",z$z2)]<-"METHOCARBAMOL"
z$z3[grep("METHOCARBAMOL",z$z3)]<-"METHOCARBAMOL"
z$z4[grep("METHOCARBAMOL",z$z4)]<-"METHOCARBAMOL"
z$z5[grep("METHOCARBAMOL",z$z5)]<-"METHOCARBAMOL"
z$z6[grep("METHOCARBAMOL",z$z6)]<-"METHOCARBAMOL"
z$z7[grep("METHOCARBAMOL",z$z7)]<-"METHOCARBAMOL"
z$z8[grep("METHOCARBAMOL",z$z8)]<-"METHOCARBAMOL"
z$z9[grep("METHOCARBAMOL",z$z9)]<-"METHOCARBAMOL"
z$z10[grep("METHOCARBAMOL",z$z10)]<-"METHOCARBAMOL"
z$z11[grep("METHOCARBAMOL",z$z11)]<-"METHOCARBAMOL"
z$z12[grep("METHOCARBAMOL",z$z12)]<-"METHOCARBAMOL"
z$z13[grep("METHOCARBAMOL",z$z13)]<-"METHOCARBAMOL"

#######################
# CARISOPRODOL
##############################
z$z1[grep("CARISOPR",z$z1)]<-"CARISOPRODOL"
z$z2[grep("CARISOPR",z$z2)]<-"CARISOPRODOL"
z$z3[grep("CARISOPR",z$z3)]<-"CARISOPRODOL"
z$z4[grep("CARISOPR",z$z4)]<-"CARISOPRODOL"
z$z5[grep("CARISOPR",z$z5)]<-"CARISOPRODOL"
z$z6[grep("CARISOPR",z$z6)]<-"CARISOPRODOL"
z$z7[grep("CARISOPR",z$z7)]<-"CARISOPRODOL"
z$z8[grep("CARISOPR",z$z8)]<-"CARISOPRODOL"
z$z9[grep("CARISOPR",z$z9)]<-"CARISOPRODOL"
z$z10[grep("CARISOPR",z$z10)]<-"CARISOPRODOL"
z$z11[grep("CARISOPR",z$z11)]<-"CARISOPRODOL"
z$z12[grep("CARISOPR",z$z12)]<-"CARISOPRODOL"
z$z13[grep("CARISOPR",z$z13)]<-"CARISOPRODOL"

#####################
#TIZANIDINE
#######################
z$z1[grep("TIZANIDINE",z$z1)]<-"TIZANIDINE"
z$z2[grep("TIZANIDINE",z$z2)]<-"TIZANIDINE"
z$z3[grep("TIZANIDINE",z$z3)]<-"TIZANIDINE"
z$z4[grep("TIZANIDINE",z$z4)]<-"TIZANIDINE"
z$z5[grep("TIZANIDINE",z$z5)]<-"TIZANIDINE"
z$z6[grep("TIZANIDINE",z$z6)]<-"TIZANIDINE"
z$z7[grep("TIZANIDINE",z$z7)]<-"TIZANIDINE"
z$z8[grep("TIZANIDINE",z$z8)]<-"TIZANIDINE"
z$z9[grep("TIZANIDINE",z$z9)]<-"TIZANIDINE"
z$z10[grep("TIZANIDINE",z$z10)]<-"TIZANIDINE"
z$z11[grep("TIZANIDINE",z$z11)]<-"TIZANIDINE"
z$z12[grep("TIZANIDINE",z$z12)]<-"TIZANIDINE"
z$z13[grep("TIZANIDINE",z$z13)]<-"TIZANIDINE"

##################
#HEROIN
#########################
z$z1[grep("HEROIN",z$z1)]<-"HEROIN"
z$z2[grep("HEROIN",z$z2)]<-"HEROIN"
z$z3[grep("HEROIN",z$z3)]<-"HEROIN"
z$z4[grep("HEROIN",z$z4)]<-"HEROIN"
z$z5[grep("HEROIN",z$z5)]<-"HEROIN"
z$z6[grep("HEROIN",z$z6)]<-"HEROIN"
z$z7[grep("HEROIN",z$z7)]<-"HEROIN"
z$z8[grep("HEROIN",z$z8)]<-"HEROIN"
z$z9[grep("HEROIN",z$z9)]<-"HEROIN"
z$z10[grep("HEROIN",z$z10)]<-"HEROIN"
z$z11[grep("HEROIN",z$z11)]<-"HEROIN"
z$z12[grep("HEROIN",z$z12)]<-"HEROIN"
z$z13[grep("HEROIN",z$z13)]<-"HEROIN"

######################
#METHADONE
###########################
z$z1[grep("METHADONE",z$z1)]<-"METHADONE"
z$z2[grep("METHADONE",z$z2)]<-"METHADONE"
z$z3[grep("METHADONE",z$z3)]<-"METHADONE"
z$z4[grep("METHADONE",z$z4)]<-"METHADONE"
z$z5[grep("METHADONE",z$z5)]<-"METHADONE"
z$z6[grep("METHADONE",z$z6)]<-"METHADONE"
z$z7[grep("METHADONE",z$z7)]<-"METHADONE"
z$z8[grep("METHADONE",z$z8)]<-"METHADONE"
z$z9[grep("METHADONE",z$z9)]<-"METHADONE"
z$z10[grep("METHADONE",z$z10)]<-"METHADONE"
z$z11[grep("METHADONE",z$z11)]<-"METHADONE"
z$z12[grep("METHADONE",z$z12)]<-"METHADONE"
z$z13[grep("METHADONE",z$z13)]<-"METHADONE"

#####################
#METHOXYACETYLFENTANYL/MAF
######################
z$z1[grep("METHOXYACETYL",z$z1)]<-"MAF"
z$z2[grep("METHOXYACETYL",z$z2)]<-"MAF"
z$z3[grep("METHOXYACETYL",z$z3)]<-"MAF"
z$z4[grep("METHOXYACETYL",z$z4)]<-"MAF"
z$z5[grep("METHOXYACETYL",z$z5)]<-"MAF"
z$z6[grep("METHOXYACETYL",z$z6)]<-"MAF"
z$z7[grep("METHOXYACETYL",z$z7)]<-"MAF"
z$z8[grep("METHOXYACETYL",z$z8)]<-"MAF"
z$z9[grep("METHOXYACETYL",z$z9)]<-"MAF"
z$z10[grep("METHOXYACETYL",z$z10)]<-"MAF"
z$z11[grep("METHOXYACETYL",z$z11)]<-"MAF"
z$z12[grep("METHOXYACETYL",z$z12)]<-"MAF"
z$z13[grep("METHOXYACETYL",z$z13)]<-"MAF"

#######################
#ACETYL FENTANYL
###########################
z$z1[grep("ACETYL",z$z1)]<-"ACETYL"
z$z2[grep("ACETYL",z$z2)]<-"ACETYL"
z$z3[grep("ACETYL",z$z3)]<-"ACETYL"
z$z4[grep("ACETYL",z$z4)]<-"ACETYL"
z$z5[grep("ACETYL",z$z5)]<-"ACETYL"
z$z6[grep("ACETYL",z$z6)]<-"ACETYL"
z$z7[grep("ACETYL",z$z7)]<-"ACETYL"
z$z8[grep("ACETYL",z$z8)]<-"ACETYL"
z$z9[grep("ACETYL",z$z9)]<-"ACETYL"
z$z10[grep("ACETYL",z$z10)]<-"ACETYL"
z$z11[grep("ACETYL",z$z11)]<-"ACETYL"
z$z12[grep("ACETYL",z$z12)]<-"ACETYL"
z$z13[grep("ACETYL",z$z13)]<-"ACETYL"

#######################
#PARA-FLUOROBUTYRYL FENTANYL/FIBF
#########################
z$z1[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z1)]<-"FIBF"
z$z2[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z2)]<-"FIBF"
z$z3[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z3)]<-"FIBF"
z$z4[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z4)]<-"FIBF"
z$z5[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z5)]<-"FIBF"
z$z6[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z6)]<-"FIBF"
z$z7[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z7)]<-"FIBF"
z$z8[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z8)]<-"FIBF"
z$z9[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z9)]<-"FIBF"
z$z10[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z10)]<-"FIBF"
z$z11[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z11)]<-"FIBF"
z$z12[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z12)]<-"FIBF"
z$z13[grep("FLUOROBUTYRYL|FIBF|FLUOROISOBUTYRYL|FLUROISOBUTYRYL",z$z13)]<-"FIBF"

#######################
#BUTYRYL FENTANYL/ISOBUTYRYL FENTANYL
##########################
z$z1[grep("BUTYRYL|ISOBUTYRYL",z$z1)]<-"BUTYRYL"
z$z2[grep("BUTYRYL|ISOBUTYRYL",z$z2)]<-"BUTYRYL"
z$z3[grep("BUTYRYL|ISOBUTYRYL",z$z3)]<-"BUTYRYL"
z$z4[grep("BUTYRYL|ISOBUTYRYL",z$z4)]<-"BUTYRYL"
z$z5[grep("BUTYRYL|ISOBUTYRYL",z$z5)]<-"BUTYRYL"
z$z6[grep("BUTYRYL|ISOBUTYRYL",z$z6)]<-"BUTYRYL"
z$z7[grep("BUTYRYL|ISOBUTYRYL",z$z7)]<-"BUTYRYL"
z$z8[grep("BUTYRYL|ISOBUTYRYL",z$z8)]<-"BUTYRYL"
z$z9[grep("BUTYRYL|ISOBUTYRYL",z$z9)]<-"BUTYRYL"
z$z10[grep("BUTYRYL|ISOBUTYRYL",z$z10)]<-"BUTYRYL"
z$z11[grep("BUTYRYL|ISOBUTYRYL",z$z11)]<-"BUTYRYL"
z$z12[grep("BUTYRYL|ISOBUTYRYL",z$z12)]<-"BUTYRYL"
z$z13[grep("BUTYRYL|ISOBUTYRYL",z$z13)]<-"BUTYRYL"

#######################
#DESPROPIONYL FENTANYL (4-ANPP) 
#DESPROPRIONYL
#############################
z$z1[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z1)]<-"4-ANPP"
z$z2[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z2)]<-"4-ANPP"
z$z3[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z3)]<-"4-ANPP"
z$z4[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z4)]<-"4-ANPP"
z$z5[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z5)]<-"4-ANPP"
z$z6[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z6)]<-"4-ANPP"
z$z7[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z7)]<-"4-ANPP"
z$z8[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z8)]<-"4-ANPP"
z$z9[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z9)]<-"4-ANPP"
z$z10[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z10)]<-"4-ANPP"
z$z11[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z11)]<-"4-ANPP"
z$z12[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z12)]<-"4-ANPP"
z$z13[grep("DESPROPIONYL|ANPP|DESPROPRIONYL",z$z13)]<-"4-ANPP"

###################
#CYCLOPROPYL FENTANYL
########################
z$z1[grep("CYCLOPROPYL",z$z1)]<-"CYCLOPROPYL"
z$z2[grep("CYCLOPROPYL",z$z2)]<-"CYCLOPROPYL"
z$z3[grep("CYCLOPROPYL",z$z3)]<-"CYCLOPROPYL"
z$z4[grep("CYCLOPROPYL",z$z4)]<-"CYCLOPROPYL"
z$z5[grep("CYCLOPROPYL",z$z5)]<-"CYCLOPROPYL"
z$z6[grep("CYCLOPROPYL",z$z6)]<-"CYCLOPROPYL"
z$z7[grep("CYCLOPROPYL",z$z7)]<-"CYCLOPROPYL"
z$z8[grep("CYCLOPROPYL",z$z8)]<-"CYCLOPROPYL"
z$z9[grep("CYCLOPROPYL",z$z9)]<-"CYCLOPROPYL"
z$z10[grep("CYCLOPROPYL",z$z10)]<-"CYCLOPROPYL"
z$z11[grep("CYCLOPROPYL",z$z11)]<-"CYCLOPROPYL"
z$z12[grep("CYCLOPROPYL",z$z12)]<-"CYCLOPROPYL"
z$z13[grep("CYCLOPROPYL",z$z13)]<-"CYCLOPROPYL"

#################
#CARFENTANYL/CARFENTANIL
##############################
z$z1[grep("CARFENTANYL|CARFENTANIL",z$z1)]<-"CARFENTANIL"
z$z2[grep("CARFENTANYL|CARFENTANIL",z$z2)]<-"CARFENTANIL"
z$z3[grep("CARFENTANYL|CARFENTANIL",z$z3)]<-"CARFENTANIL"
z$z4[grep("CARFENTANYL|CARFENTANIL",z$z4)]<-"CARFENTANIL"
z$z5[grep("CARFENTANYL|CARFENTANIL",z$z5)]<-"CARFENTANIL"
z$z6[grep("CARFENTANYL|CARFENTANIL",z$z6)]<-"CARFENTANIL"
z$z7[grep("CARFENTANYL|CARFENTANIL",z$z7)]<-"CARFENTANIL"
z$z8[grep("CARFENTANYL|CARFENTANIL",z$z8)]<-"CARFENTANIL"
z$z9[grep("CARFENTANYL|CARFENTANIL",z$z9)]<-"CARFENTANIL"
z$z10[grep("CARFENTANYL|CARFENTANIL",z$z10)]<-"CARFENTANIL"
z$z11[grep("CARFENTANYL|CARFENTANIL",z$z11)]<-"CARFENTANIL"
z$z12[grep("CARFENTANYL|CARFENTANIL",z$z12)]<-"CARFENTANIL"
z$z13[grep("CARFENTANYL|CARFENTANIL",z$z13)]<-"CARFENTANIL"

####################
#2-FURANYL FENTANYL
#####################
z$z1[grep("FURANYL",z$z1)]<-"2-FURANYL"
z$z2[grep("FURANYL",z$z2)]<-"2-FURANYL"
z$z3[grep("FURANYL",z$z3)]<-"2-FURANYL"
z$z4[grep("FURANYL",z$z4)]<-"2-FURANYL"
z$z5[grep("FURANYL",z$z5)]<-"2-FURANYL"
z$z6[grep("FURANYL",z$z6)]<-"2-FURANYL"
z$z7[grep("FURANYL",z$z7)]<-"2-FURANYL"
z$z8[grep("FURANYL",z$z8)]<-"2-FURANYL"
z$z9[grep("FURANYL",z$z9)]<-"2-FURANYL"
z$z10[grep("FURANYL",z$z10)]<-"2-FURANYL"
z$z11[grep("FURANYL",z$z11)]<-"2-FURANYL"
z$z12[grep("FURANYL",z$z12)]<-"2-FURANYL"
z$z13[grep("FURANYL",z$z13)]<-"2-FURANYL"

#################
#NORFENTANYL/NFL
####################
z$z1[grep("NORFENTANYL",z$z1)]<-"NFL"
z$z2[grep("NORFENTANYL",z$z2)]<-"NFL"
z$z3[grep("NORFENTANYL",z$z3)]<-"NFL"
z$z4[grep("NORFENTANYL",z$z4)]<-"NFL"
z$z5[grep("NORFENTANYL",z$z5)]<-"NFL"
z$z6[grep("NORFENTANYL",z$z6)]<-"NFL"
z$z7[grep("NORFENTANYL",z$z7)]<-"NFL"
z$z8[grep("NORFENTANYL",z$z8)]<-"NFL"
z$z9[grep("NORFENTANYL",z$z9)]<-"NFL"
z$z10[grep("NORFENTANYL",z$z10)]<-"NFL"
z$z11[grep("NORFENTANYL",z$z11)]<-"NFL"
z$z12[grep("NORFENTANYL",z$z12)]<-"NFL"
z$z13[grep("NORFENTANYL",z$z13)]<-"NFL"

####################
#VALERYLFENTANYL/VFL
#######################
z$z1[grep("VALERYLFENTANYL",z$z1)]<-"VFL"
z$z2[grep("VALERYLFENTANYL",z$z2)]<-"VFL"
z$z3[grep("VALERYLFENTANYL",z$z3)]<-"VFL"
z$z4[grep("VALERYLFENTANYL",z$z4)]<-"VFL"
z$z5[grep("VALERYLFENTANYL",z$z5)]<-"VFL"
z$z6[grep("VALERYLFENTANYL",z$z6)]<-"VFL"
z$z7[grep("VALERYLFENTANYL",z$z7)]<-"VFL"
z$z8[grep("VALERYLFENTANYL",z$z8)]<-"VFL"
z$z9[grep("VALERYLFENTANYL",z$z9)]<-"VFL"
z$z10[grep("VALERYLFENTANYL",z$z10)]<-"VFL"
z$z11[grep("VALERYLFENTANYL",z$z11)]<-"VFL"
z$z12[grep("VALERYLFENTANYL",z$z12)]<-"VFL"
z$z13[grep("VALERYLFENTANYL",z$z13)]<-"VFL"

########################
#ACRYL FENTANYL
#############################
z$z1[grep("ACRYL",z$z1)]<-"ACRYL"
z$z2[grep("ACRYL",z$z2)]<-"ACRYL"
z$z3[grep("ACRYL",z$z3)]<-"ACRYL"
z$z4[grep("ACRYL",z$z4)]<-"ACRYL"
z$z5[grep("ACRYL",z$z5)]<-"ACRYL"
z$z6[grep("ACRYL",z$z6)]<-"ACRYL"
z$z7[grep("ACRYL",z$z7)]<-"ACRYL"
z$z8[grep("ACRYL",z$z8)]<-"ACRYL"
z$z9[grep("ACRYL",z$z9)]<-"ACRYL"
z$z10[grep("ACRYL",z$z10)]<-"ACRYL"
z$z11[grep("ACRYL",z$z11)]<-"ACRYL"
z$z12[grep("ACRYL",z$z12)]<-"ACRYL"
z$z13[grep("ACRYL",z$z13)]<-"ACRYL"

##########################
#PARA-FLUOROFENTANYL/PFL
##############################
z$z1[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z1)]<-"PFL"
z$z2[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z2)]<-"PFL"
z$z3[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z3)]<-"PFL"
z$z4[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z4)]<-"PFL"
z$z5[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z5)]<-"PFL"
z$z6[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z6)]<-"PFL"
z$z7[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z7)]<-"PFL"
z$z8[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z8)]<-"PFL"
z$z9[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z9)]<-"PFL"
z$z10[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z10)]<-"PFL"
z$z11[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z11)]<-"PFL"
z$z12[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z12)]<-"PFL"
z$z13[grep("PARA-FLUOROFENTANYL|PARAFLUOROFENTANYL",z$z13)]<-"PFL"

##########################
#FENTANYL
###############################
z$z1[grep("FENTANYL|FENTAYL",z$z1)]<-"FENTANYL"
z$z2[grep("FENTANYL|FENTAYL",z$z2)]<-"FENTANYL"
z$z3[grep("FENTANYL|FENTAYL",z$z3)]<-"FENTANYL"
z$z4[grep("FENTANYL|FENTAYL",z$z4)]<-"FENTANYL"
z$z5[grep("FENTANYL|FENTAYL",z$z5)]<-"FENTANYL"
z$z6[grep("FENTANYL|FENTAYL",z$z6)]<-"FENTANYL"
z$z7[grep("FENTANYL|FENTAYL",z$z7)]<-"FENTANYL"
z$z8[grep("FENTANYL|FENTAYL",z$z8)]<-"FENTANYL"
z$z9[grep("FENTANYL|FENTAYL",z$z9)]<-"FENTANYL"
z$z10[grep("FENTANYL|FENTAYL",z$z10)]<-"FENTANYL"
z$z11[grep("FENTANYL|FENTAYL",z$z11)]<-"FENTANYL"
z$z12[grep("FENTANYL|FENTAYL",z$z12)]<-"FENTANYL"
z$z13[grep("FENTANYL|FENTAYL",z$z13)]<-"FENTANYL"

###########################
#HYDROMORPHONE
#############################
z$z1[grep("HYDROMORPHONE",z$z1)]<-"HYDROMORPHONE"
z$z2[grep("HYDROMORPHONE",z$z2)]<-"HYDROMORPHONE"
z$z3[grep("HYDROMORPHONE",z$z3)]<-"HYDROMORPHONE"
z$z4[grep("HYDROMORPHONE",z$z4)]<-"HYDROMORPHONE"
z$z5[grep("HYDROMORPHONE",z$z5)]<-"HYDROMORPHONE"
z$z6[grep("HYDROMORPHONE",z$z6)]<-"HYDROMORPHONE"
z$z7[grep("HYDROMORPHONE",z$z7)]<-"HYDROMORPHONE"
z$z8[grep("HYDROMORPHONE",z$z8)]<-"HYDROMORPHONE"
z$z9[grep("HYDROMORPHONE",z$z9)]<-"HYDROMORPHONE"
z$z10[grep("HYDROMORPHONE",z$z10)]<-"HYDROMORPHONE"
z$z11[grep("HYDROMORPHONE",z$z11)]<-"HYDROMORPHONE"
z$z12[grep("HYDROMORPHONE",z$z12)]<-"HYDROMORPHONE"
z$z13[grep("HYDROMORPHONE",z$z13)]<-"HYDROMORPHONE"

############################
# MORPHINE
#################################
z$z1[grep("MORPHINE",z$z1)]<-"MORPHINE"
z$z2[grep("MORPHINE",z$z2)]<-"MORPHINE"
z$z3[grep("MORPHINE",z$z3)]<-"MORPHINE"
z$z4[grep("MORPHINE",z$z4)]<-"MORPHINE"
z$z5[grep("MORPHINE",z$z5)]<-"MORPHINE"
z$z6[grep("MORPHINE",z$z6)]<-"MORPHINE"
z$z7[grep("MORPHINE",z$z7)]<-"MORPHINE"
z$z8[grep("MORPHINE",z$z8)]<-"MORPHINE"
z$z9[grep("MORPHINE",z$z9)]<-"MORPHINE"
z$z10[grep("MORPHINE",z$z10)]<-"MORPHINE"
z$z11[grep("MORPHINE",z$z11)]<-"MORPHINE"
z$z12[grep("MORPHINE",z$z12)]<-"MORPHINE"
z$z13[grep("MORPHINE",z$z13)]<-"MORPHINE"

###################
#OXYMORPHONE
##########################
z$z1[grep("OXYMORPHONE",z$z1)]<-"OXYMORPHONE"
z$z2[grep("OXYMORPHONE",z$z2)]<-"OXYMORPHONE"
z$z3[grep("OXYMORPHONE",z$z3)]<-"OXYMORPHONE"
z$z4[grep("OXYMORPHONE",z$z4)]<-"OXYMORPHONE"
z$z5[grep("OXYMORPHONE",z$z5)]<-"OXYMORPHONE"
z$z6[grep("OXYMORPHONE",z$z6)]<-"OXYMORPHONE"
z$z7[grep("OXYMORPHONE",z$z7)]<-"OXYMORPHONE"
z$z8[grep("OXYMORPHONE",z$z8)]<-"OXYMORPHONE"
z$z9[grep("OXYMORPHONE",z$z9)]<-"OXYMORPHONE"
z$z10[grep("OXYMORPHONE",z$z10)]<-"OXYMORPHONE"
z$z11[grep("OXYMORPHONE",z$z11)]<-"OXYMORPHONE"
z$z12[grep("OXYMORPHONE",z$z12)]<-"OXYMORPHONE"
z$z13[grep("OXYMORPHONE",z$z13)]<-"OXYMORPHONE"

####################
#OXYCODONE
#########################
z$z1[grep("OXYCODONE",z$z1)]<-"OXYCODONE"
z$z2[grep("OXYCODONE",z$z2)]<-"OXYCODONE"
z$z3[grep("OXYCODONE",z$z3)]<-"OXYCODONE"
z$z4[grep("OXYCODONE",z$z4)]<-"OXYCODONE"
z$z5[grep("OXYCODONE",z$z5)]<-"OXYCODONE"
z$z6[grep("OXYCODONE",z$z6)]<-"OXYCODONE"
z$z7[grep("OXYCODONE",z$z7)]<-"OXYCODONE"
z$z8[grep("OXYCODONE",z$z8)]<-"OXYCODONE"
z$z9[grep("OXYCODONE",z$z9)]<-"OXYCODONE"
z$z10[grep("OXYCODONE",z$z10)]<-"OXYCODONE"
z$z11[grep("OXYCODONE",z$z11)]<-"OXYCODONE"
z$z12[grep("OXYCODONE",z$z12)]<-"OXYCODONE"
z$z13[grep("OXYCODONE",z$z13)]<-"OXYCODONE"

######################
#HYDROCODONE
########################
z$z1[grep("HYDROCODONE",z$z1)]<-"HYDROCODONE"
z$z2[grep("HYDROCODONE",z$z2)]<-"HYDROCODONE"
z$z3[grep("HYDROCODONE",z$z3)]<-"HYDROCODONE"
z$z4[grep("HYDROCODONE",z$z4)]<-"HYDROCODONE"
z$z5[grep("HYDROCODONE",z$z5)]<-"HYDROCODONE"
z$z6[grep("HYDROCODONE",z$z6)]<-"HYDROCODONE"
z$z7[grep("HYDROCODONE",z$z7)]<-"HYDROCODONE"
z$z8[grep("HYDROCODONE",z$z8)]<-"HYDROCODONE"
z$z9[grep("HYDROCODONE",z$z9)]<-"HYDROCODONE"
z$z10[grep("HYDROCODONE",z$z10)]<-"HYDROCODONE"
z$z11[grep("HYDROCODONE",z$z11)]<-"HYDROCODONE"
z$z12[grep("HYDROCODONE",z$z12)]<-"HYDROCODONE"
z$z13[grep("HYDROCODONE",z$z13)]<-"HYDROCODONE"

########################
#DIHYDROCODEINE/HYDROCODOL
#############################
z$z1[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z1)]<-"HYDROCODOL"
z$z2[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z2)]<-"HYDROCODOL"
z$z3[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z3)]<-"HYDROCODOL"
z$z4[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z4)]<-"HYDROCODOL"
z$z5[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z5)]<-"HYDROCODOL"
z$z6[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z6)]<-"HYDROCODOL"
z$z7[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z7)]<-"HYDROCODOL"
z$z8[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z8)]<-"HYDROCODOL"
z$z9[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z9)]<-"HYDROCODOL"
z$z10[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z10)]<-"HYDROCODOL"
z$z11[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z11)]<-"HYDROCODOL"
z$z12[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z12)]<-"HYDROCODOL"
z$z13[grep("DIHYDROCODEINE|HYDROCODOL|DIHYROCODEINE",z$z13)]<-"HYDROCODOL"

##########################
#CODEINE
#############################
z$z1[grep("CODEINE",z$z1)]<-"CODEINE"
z$z2[grep("CODEINE",z$z2)]<-"CODEINE"
z$z3[grep("CODEINE",z$z3)]<-"CODEINE"
z$z4[grep("CODEINE",z$z4)]<-"CODEINE"
z$z5[grep("CODEINE",z$z5)]<-"CODEINE"
z$z6[grep("CODEINE",z$z6)]<-"CODEINE"
z$z7[grep("CODEINE",z$z7)]<-"CODEINE"
z$z8[grep("CODEINE",z$z8)]<-"CODEINE"
z$z9[grep("CODEINE",z$z9)]<-"CODEINE"
z$z10[grep("CODEINE",z$z10)]<-"CODEINE"
z$z11[grep("CODEINE",z$z11)]<-"CODEINE"
z$z12[grep("CODEINE",z$z12)]<-"CODEINE"
z$z13[grep("CODEINE",z$z13)]<-"CODEINE"

########################
#BUPRENORPHINE
###############################
z$z1[grep("BUPRENORPHINE",z$z1)]<-"BUPRENORPHINE"
z$z2[grep("BUPRENORPHINE",z$z2)]<-"BUPRENORPHINE"
z$z3[grep("BUPRENORPHINE",z$z3)]<-"BUPRENORPHINE"
z$z4[grep("BUPRENORPHINE",z$z4)]<-"BUPRENORPHINE"
z$z5[grep("BUPRENORPHINE",z$z5)]<-"BUPRENORPHINE"
z$z6[grep("BUPRENORPHINE",z$z6)]<-"BUPRENORPHINE"
z$z7[grep("BUPRENORPHINE",z$z7)]<-"BUPRENORPHINE"
z$z8[grep("BUPRENORPHINE",z$z8)]<-"BUPRENORPHINE"
z$z9[grep("BUPRENORPHINE",z$z9)]<-"BUPRENORPHINE"
z$z10[grep("BUPRENORPHINE",z$z10)]<-"BUPRENORPHINE"
z$z11[grep("BUPRENORPHINE",z$z11)]<-"BUPRENORPHINE"
z$z12[grep("BUPRENORPHINE",z$z12)]<-"BUPRENORPHINE"
z$z13[grep("BUPRENORPHINE",z$z13)]<-"BUPRENORPHINE"

###########################
#MEPERIDINE
###########################
z$z1[grep("MEPERIDINE",z$z1)]<-"MEPERIDINE"
z$z2[grep("MEPERIDINE",z$z2)]<-"MEPERIDINE"
z$z3[grep("MEPERIDINE",z$z3)]<-"MEPERIDINE"
z$z4[grep("MEPERIDINE",z$z4)]<-"MEPERIDINE"
z$z5[grep("MEPERIDINE",z$z5)]<-"MEPERIDINE"
z$z6[grep("MEPERIDINE",z$z6)]<-"MEPERIDINE"
z$z7[grep("MEPERIDINE",z$z7)]<-"MEPERIDINE"
z$z8[grep("MEPERIDINE",z$z8)]<-"MEPERIDINE"
z$z9[grep("MEPERIDINE",z$z9)]<-"MEPERIDINE"
z$z10[grep("MEPERIDINE",z$z10)]<-"MEPERIDINE"
z$z11[grep("MEPERIDINE",z$z11)]<-"MEPERIDINE"
z$z12[grep("MEPERIDINE",z$z12)]<-"MEPERIDINE"
z$z13[grep("MEPERIDINE",z$z13)]<-"MEPERIDINE"

########################
#TRAMADOL
############################
z$z1[grep("TRAMADOL",z$z1)]<-"TRAMADOL"
z$z2[grep("TRAMADOL",z$z2)]<-"TRAMADOL"
z$z3[grep("TRAMADOL",z$z3)]<-"TRAMADOL"
z$z4[grep("TRAMADOL",z$z4)]<-"TRAMADOL"
z$z5[grep("TRAMADOL",z$z5)]<-"TRAMADOL"
z$z6[grep("TRAMADOL",z$z6)]<-"TRAMADOL"
z$z7[grep("TRAMADOL",z$z7)]<-"TRAMADOL"
z$z8[grep("TRAMADOL",z$z8)]<-"TRAMADOL"
z$z9[grep("TRAMADOL",z$z9)]<-"TRAMADOL"
z$z10[grep("TRAMADOL",z$z10)]<-"TRAMADOL"
z$z11[grep("TRAMADOL",z$z11)]<-"TRAMADOL"
z$z12[grep("TRAMADOL",z$z12)]<-"TRAMADOL"
z$z13[grep("TRAMADOL",z$z13)]<-"TRAMADOL"

######################
#TRAZODONE
##########################
z$z1[grep("TRAZODONE",z$z1)]<-"TRAZODONE"
z$z2[grep("TRAZODONE",z$z2)]<-"TRAZODONE"
z$z3[grep("TRAZODONE",z$z3)]<-"TRAZODONE"
z$z4[grep("TRAZODONE",z$z4)]<-"TRAZODONE"
z$z5[grep("TRAZODONE",z$z5)]<-"TRAZODONE"
z$z6[grep("TRAZODONE",z$z6)]<-"TRAZODONE"
z$z7[grep("TRAZODONE",z$z7)]<-"TRAZODONE"
z$z8[grep("TRAZODONE",z$z8)]<-"TRAZODONE"
z$z9[grep("TRAZODONE",z$z9)]<-"TRAZODONE"
z$z10[grep("TRAZODONE",z$z10)]<-"TRAZODONE"
z$z11[grep("TRAZODONE",z$z11)]<-"TRAZODONE"
z$z12[grep("TRAZODONE",z$z12)]<-"TRAZODONE"
z$z13[grep("TRAZODONE",z$z13)]<-"TRAZODONE"

#################
#DEXTROMETHORPHAN/LEVOMETHORPHAN 
#####################
z$z1[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z1)]<-"LEVOMETHORPHAN"
z$z2[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z2)]<-"LEVOMETHORPHAN"
z$z3[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z3)]<-"LEVOMETHORPHAN"
z$z4[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z4)]<-"LEVOMETHORPHAN"
z$z5[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z5)]<-"LEVOMETHORPHAN"
z$z6[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z6)]<-"LEVOMETHORPHAN"
z$z7[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z7)]<-"LEVOMETHORPHAN"
z$z8[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z8)]<-"LEVOMETHORPHAN"
z$z9[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z9)]<-"LEVOMETHORPHAN"
z$z10[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z10)]<-"LEVOMETHORPHAN"
z$z11[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z11)]<-"LEVOMETHORPHAN"
z$z12[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z12)]<-"LEVOMETHORPHAN"
z$z13[grep("DEXTROMETHORPHAN|LEVOMETHORPHAN|METHORPHAN",z$z13)]<-"LEVOMETHORPHAN"

###############
#DEXTRORPHAN/LEVORPHANOL
###################
z$z1[grep("DEXTRORPHAN|LEVORPHANOL",z$z1)]<-"LEVORPHANOL"
z$z2[grep("DEXTRORPHAN|LEVORPHANOL",z$z2)]<-"LEVORPHANOL"
z$z3[grep("DEXTRORPHAN|LEVORPHANOL",z$z3)]<-"LEVORPHANOL"
z$z4[grep("DEXTRORPHAN|LEVORPHANOL",z$z4)]<-"LEVORPHANOL"
z$z5[grep("DEXTRORPHAN|LEVORPHANOL",z$z5)]<-"LEVORPHANOL"
z$z6[grep("DEXTRORPHAN|LEVORPHANOL",z$z6)]<-"LEVORPHANOL"
z$z7[grep("DEXTRORPHAN|LEVORPHANOL",z$z7)]<-"LEVORPHANOL"
z$z8[grep("DEXTRORPHAN|LEVORPHANOL",z$z8)]<-"LEVORPHANOL"
z$z9[grep("DEXTRORPHAN|LEVORPHANOL",z$z9)]<-"LEVORPHANOL"
z$z10[grep("DEXTRORPHAN|LEVORPHANOL",z$z10)]<-"LEVORPHANOL"
z$z11[grep("DEXTRORPHAN|LEVORPHANOL",z$z11)]<-"LEVORPHANOL"
z$z12[grep("DEXTRORPHAN|LEVORPHANOL",z$z12)]<-"LEVORPHANOL"
z$z13[grep("DEXTRORPHAN|LEVORPHANOL",z$z13)]<-"LEVORPHANOL"

#####################
#U-47700
###########################
z$z1[grep("U-47700|U47700|47700",z$z1)]<-"U-47700"
z$z2[grep("U-47700|U47700|47700",z$z2)]<-"U-47700"
z$z3[grep("U-47700|U47700|47700",z$z3)]<-"U-47700"
z$z4[grep("U-47700|U47700|47700",z$z4)]<-"U-47700"
z$z5[grep("U-47700|U47700|47700",z$z5)]<-"U-47700"
z$z6[grep("U-47700|U47700|47700",z$z6)]<-"U-47700"
z$z7[grep("U-47700|U47700|47700",z$z7)]<-"U-47700"
z$z8[grep("U-47700|U47700|47700",z$z8)]<-"U-47700"
z$z9[grep("U-47700|U47700|47700",z$z9)]<-"U-47700"
z$z10[grep("U-47700|U47700|47700",z$z10)]<-"U-47700"
z$z11[grep("U-47700|U47700|47700",z$z11)]<-"U-47700"
z$z12[grep("U-47700|U47700|47700",z$z12)]<-"U-47700"
z$z13[grep("U-47700|U47700|47700",z$z13)]<-"U-47700"

##########################
#U-49900
################################
z$z1[grep("U-49900|U49900",z$z1)]<-"U-49900"
z$z2[grep("U-49900|U49900",z$z2)]<-"U-49900"
z$z3[grep("U-49900|U49900",z$z3)]<-"U-49900"
z$z4[grep("U-49900|U49900",z$z4)]<-"U-49900"
z$z5[grep("U-49900|U49900",z$z5)]<-"U-49900"
z$z6[grep("U-49900|U49900",z$z6)]<-"U-49900"
z$z7[grep("U-49900|U49900",z$z7)]<-"U-49900"
z$z8[grep("U-49900|U49900",z$z8)]<-"U-49900"
z$z9[grep("U-49900|U49900",z$z9)]<-"U-49900"
z$z10[grep("U-49900|U49900",z$z10)]<-"U-49900"
z$z11[grep("U-49900|U49900",z$z11)]<-"U-49900"
z$z12[grep("U-49900|U49900",z$z12)]<-"U-49900"
z$z13[grep("U-49900|U49900",z$z13)]<-"U-49900"

########################
#ETHANOL/ALCOHOL
########################
z$z1[grep("ETHANOL|ALCOHOL",z$z1)]<-"ETHANOL"
z$z2[grep("ETHANOL|ALCOHOL",z$z2)]<-"ETHANOL"
z$z3[grep("ETHANOL|ALCOHOL",z$z3)]<-"ETHANOL"
z$z4[grep("ETHANOL|ALCOHOL",z$z4)]<-"ETHANOL"
z$z5[grep("ETHANOL|ALCOHOL",z$z5)]<-"ETHANOL"
z$z6[grep("ETHANOL|ALCOHOL",z$z6)]<-"ETHANOL"
z$z7[grep("ETHANOL|ALCOHOL",z$z7)]<-"ETHANOL"
z$z8[grep("ETHANOL|ALCOHOL",z$z8)]<-"ETHANOL"
z$z9[grep("ETHANOL|ALCOHOL",z$z9)]<-"ETHANOL"
z$z10[grep("ETHANOL|ALCOHOL",z$z10)]<-"ETHANOL"
z$z11[grep("ETHANOL|ALCOHOL",z$z11)]<-"ETHANOL"
z$z12[grep("ETHANOL|ALCOHOL",z$z12)]<-"ETHANOL"
z$z13[grep("ETHANOL|ALCOHOL",z$z13)]<-"ETHANOL"

######################
#OPIOID
#######################
z$z1[grep("OPIOID",z$z1)]<-"OPIOID"
z$z2[grep("OPIOID",z$z2)]<-"OPIOID"
z$z3[grep("OPIOID",z$z3)]<-"OPIOID"
z$z4[grep("OPIOID",z$z4)]<-"OPIOID"
z$z5[grep("OPIOID",z$z5)]<-"OPIOID"
z$z6[grep("OPIOID",z$z6)]<-"OPIOID"
z$z7[grep("OPIOID",z$z7)]<-"OPIOID"
z$z8[grep("OPIOID",z$z8)]<-"OPIOID"
z$z9[grep("OPIOID",z$z9)]<-"OPIOID"
z$z10[grep("OPIOID",z$z10)]<-"OPIOID"
z$z11[grep("OPIOID",z$z11)]<-"OPIOID"
z$z12[grep("OPIOID",z$z12)]<-"OPIOID"
z$z13[grep("OPIOID",z$z13)]<-"OPIOID"

#######################
#OPIATE
######################
z$z1[grep("OPIATE",z$z1)]<-"OPIATE"
z$z2[grep("OPIATE",z$z2)]<-"OPIATE"
z$z3[grep("OPIATE",z$z3)]<-"OPIATE"
z$z4[grep("OPIATE",z$z4)]<-"OPIATE"
z$z5[grep("OPIATE",z$z5)]<-"OPIATE"
z$z6[grep("OPIATE",z$z6)]<-"OPIATE"
z$z7[grep("OPIATE",z$z7)]<-"OPIATE"
z$z8[grep("OPIATE",z$z8)]<-"OPIATE"
z$z9[grep("OPIATE",z$z9)]<-"OPIATE"
z$z10[grep("OPIATE",z$z10)]<-"OPIATE"
z$z11[grep("OPIATE",z$z11)]<-"OPIATE"
z$z12[grep("OPIATE",z$z12)]<-"OPIATE"
z$z13[grep("OPIATE",z$z13)]<-"OPIATE"

####################
#3-FLUOROPHENMETRAZINE[3-FPM]
###################
z$z1[grep("FLUOROPHENMETRAZINE",z$z1)]<-"3-FPM"
z$z2[grep("FLUOROPHENMETRAZINE",z$z2)]<-"3-FPM"
z$z3[grep("FLUOROPHENMETRAZINE",z$z3)]<-"3-FPM"
z$z4[grep("FLUOROPHENMETRAZINE",z$z4)]<-"3-FPM"
z$z5[grep("FLUOROPHENMETRAZINE",z$z5)]<-"3-FPM"
z$z6[grep("FLUOROPHENMETRAZINE",z$z6)]<-"3-FPM"
z$z7[grep("FLUOROPHENMETRAZINE",z$z7)]<-"3-FPM"
z$z8[grep("FLUOROPHENMETRAZINE",z$z8)]<-"3-FPM"
z$z9[grep("FLUOROPHENMETRAZINE",z$z9)]<-"3-FPM"
z$z10[grep("FLUOROPHENMETRAZINE",z$z10)]<-"3-FPM"
z$z11[grep("FLUOROPHENMETRAZINE",z$z11)]<-"3-FPM"
z$z12[grep("FLUOROPHENMETRAZINE",z$z12)]<-"3-FPM"
z$z13[grep("FLUOROPHENMETRAZINE",z$z13)]<-"3-FPM"

##################
#7-AMINOCLONAZEPAM   
#################
z$z1[grep("AMINOCLONAZEPAM",z$z1)]<-"7-AMINO"
z$z2[grep("AMINOCLONAZEPAM",z$z2)]<-"7-AMINO"
z$z3[grep("AMINOCLONAZEPAM",z$z3)]<-"7-AMINO"
z$z4[grep("AMINOCLONAZEPAM",z$z4)]<-"7-AMINO"
z$z5[grep("AMINOCLONAZEPAM",z$z5)]<-"7-AMINO"
z$z6[grep("AMINOCLONAZEPAM",z$z6)]<-"7-AMINO"
z$z7[grep("AMINOCLONAZEPAM",z$z7)]<-"7-AMINO"
z$z8[grep("AMINOCLONAZEPAM",z$z8)]<-"7-AMINO"
z$z9[grep("AMINOCLONAZEPAM",z$z9)]<-"7-AMINO"
z$z10[grep("AMINOCLONAZEPAM",z$z10)]<-"7-AMINO"
z$z11[grep("AMINOCLONAZEPAM",z$z11)]<-"7-AMINO"
z$z12[grep("AMINOCLONAZEPAM",z$z12)]<-"7-AMINO"
z$z13[grep("AMINOCLONAZEPAM",z$z13)]<-"7-AMINO"

##################
#CLONAZEPAM[Klonopin]
#################
z$z1[grep("CLONAZEPAM",z$z1)]<-"CLONAZEPAM"
z$z2[grep("CLONAZEPAM",z$z2)]<-"CLONAZEPAM"
z$z3[grep("CLONAZEPAM",z$z3)]<-"CLONAZEPAM"
z$z4[grep("CLONAZEPAM",z$z4)]<-"CLONAZEPAM"
z$z5[grep("CLONAZEPAM",z$z5)]<-"CLONAZEPAM"
z$z6[grep("CLONAZEPAM",z$z6)]<-"CLONAZEPAM"
z$z7[grep("CLONAZEPAM",z$z7)]<-"CLONAZEPAM"
z$z8[grep("CLONAZEPAM",z$z8)]<-"CLONAZEPAM"
z$z9[grep("CLONAZEPAM",z$z9)]<-"CLONAZEPAM"
z$z10[grep("CLONAZEPAM",z$z10)]<-"CLONAZEPAM"
z$z11[grep("CLONAZEPAM",z$z11)]<-"CLONAZEPAM"
z$z12[grep("CLONAZEPAM",z$z12)]<-"CLONAZEPAM"
z$z13[grep("CLONAZEPAM",z$z13)]<-"CLONAZEPAM"

######################
#DELORAZEPAM
#########################
z$z1[grep("DELORAZEPAM",z$z1)]<-"DEL_PAM"
z$z2[grep("DELORAZEPAM",z$z2)]<-"DEL_PAM"
z$z3[grep("DELORAZEPAM",z$z3)]<-"DEL_PAM"
z$z4[grep("DELORAZEPAM",z$z4)]<-"DEL_PAM"
z$z5[grep("DELORAZEPAM",z$z5)]<-"DEL_PAM"
z$z6[grep("DELORAZEPAM",z$z6)]<-"DEL_PAM"
z$z7[grep("DELORAZEPAM",z$z7)]<-"DEL_PAM"
z$z8[grep("DELORAZEPAM",z$z8)]<-"DEL_PAM"
z$z9[grep("DELORAZEPAM",z$z9)]<-"DEL_PAM"
z$z10[grep("DELORAZEPAM",z$z10)]<-"DEL_PAM"
z$z11[grep("DELORAZEPAM",z$z11)]<-"DEL_PAM"
z$z12[grep("DELORAZEPAM",z$z12)]<-"DEL_PAM"
z$z13[grep("DELORAZEPAM",z$z13)]<-"DEL_PAM"

######################
#DIAZEPAM [Valium]
#########################
z$z1[grep("DIAZEPAM",z$z1)]<-"DIAZEPAM"
z$z2[grep("DIAZEPAM",z$z2)]<-"DIAZEPAM"
z$z3[grep("DIAZEPAM",z$z3)]<-"DIAZEPAM"
z$z4[grep("DIAZEPAM",z$z4)]<-"DIAZEPAM"
z$z5[grep("DIAZEPAM",z$z5)]<-"DIAZEPAM"
z$z6[grep("DIAZEPAM",z$z6)]<-"DIAZEPAM"
z$z7[grep("DIAZEPAM",z$z7)]<-"DIAZEPAM"
z$z8[grep("DIAZEPAM",z$z8)]<-"DIAZEPAM"
z$z9[grep("DIAZEPAM",z$z9)]<-"DIAZEPAM"
z$z10[grep("DIAZEPAM",z$z10)]<-"DIAZEPAM"
z$z11[grep("DIAZEPAM",z$z11)]<-"DIAZEPAM"
z$z12[grep("DIAZEPAM",z$z12)]<-"DIAZEPAM"
z$z13[grep("DIAZEPAM",z$z13)]<-"DIAZEPAM"

######################
#DICLAZEPAM
#########################
z$z1[grep("DICLAZEPAM",z$z1)]<-"DICLAZEPAM"
z$z2[grep("DICLAZEPAM",z$z2)]<-"DICLAZEPAM"
z$z3[grep("DICLAZEPAM",z$z3)]<-"DICLAZEPAM"
z$z4[grep("DICLAZEPAM",z$z4)]<-"DICLAZEPAM"
z$z5[grep("DICLAZEPAM",z$z5)]<-"DICLAZEPAM"
z$z6[grep("DICLAZEPAM",z$z6)]<-"DICLAZEPAM"
z$z7[grep("DICLAZEPAM",z$z7)]<-"DICLAZEPAM"
z$z8[grep("DICLAZEPAM",z$z8)]<-"DICLAZEPAM"
z$z9[grep("DICLAZEPAM",z$z9)]<-"DICLAZEPAM"
z$z10[grep("DICLAZEPAM",z$z10)]<-"DICLAZEPAM"
z$z11[grep("DICLAZEPAM",z$z11)]<-"DICLAZEPAM"
z$z12[grep("DICLAZEPAM",z$z12)]<-"DICLAZEPAM"
z$z13[grep("DICLAZEPAM",z$z13)]<-"DICLAZEPAM"

######################
#ETIZOLAM
#########################
z$z1[grep("ETIZOLAM",z$z1)]<-"ETIZOLAM"
z$z2[grep("ETIZOLAM",z$z2)]<-"ETIZOLAM"
z$z3[grep("ETIZOLAM",z$z3)]<-"ETIZOLAM"
z$z4[grep("ETIZOLAM",z$z4)]<-"ETIZOLAM"
z$z5[grep("ETIZOLAM",z$z5)]<-"ETIZOLAM"
z$z6[grep("ETIZOLAM",z$z6)]<-"ETIZOLAM"
z$z7[grep("ETIZOLAM",z$z7)]<-"ETIZOLAM"
z$z8[grep("ETIZOLAM",z$z8)]<-"ETIZOLAM"
z$z9[grep("ETIZOLAM",z$z9)]<-"ETIZOLAM"
z$z10[grep("ETIZOLAM",z$z10)]<-"ETIZOLAM"
z$z11[grep("ETIZOLAM",z$z11)]<-"ETIZOLAM"
z$z12[grep("ETIZOLAM",z$z12)]<-"ETIZOLAM"
z$z13[grep("ETIZOLAM",z$z13)]<-"ETIZOLAM"

######################
#LORAZEPAM[Ativan]
#########################
z$z1[grep("LORAZEPAM",z$z1)]<-"LORAZEPAM"
z$z2[grep("LORAZEPAM",z$z2)]<-"LORAZEPAM"
z$z3[grep("LORAZEPAM",z$z3)]<-"LORAZEPAM"
z$z4[grep("LORAZEPAM",z$z4)]<-"LORAZEPAM"
z$z5[grep("LORAZEPAM",z$z5)]<-"LORAZEPAM"
z$z6[grep("LORAZEPAM",z$z6)]<-"LORAZEPAM"
z$z7[grep("LORAZEPAM",z$z7)]<-"LORAZEPAM"
z$z8[grep("LORAZEPAM",z$z8)]<-"LORAZEPAM"
z$z9[grep("LORAZEPAM",z$z9)]<-"LORAZEPAM"
z$z10[grep("LORAZEPAM",z$z10)]<-"LORAZEPAM"
z$z11[grep("LORAZEPAM",z$z11)]<-"LORAZEPAM"
z$z12[grep("LORAZEPAM",z$z12)]<-"LORAZEPAM"
z$z13[grep("LORAZEPAM",z$z13)]<-"LORAZEPAM"

######################
#MIDAZOLAM [Versed]
#########################
z$z1[grep("MIDAZOLAM",z$z1)]<-"MIDAZOLAM"
z$z2[grep("MIDAZOLAM",z$z2)]<-"MIDAZOLAM"
z$z3[grep("MIDAZOLAM",z$z3)]<-"MIDAZOLAM"
z$z4[grep("MIDAZOLAM",z$z4)]<-"MIDAZOLAM"
z$z5[grep("MIDAZOLAM",z$z5)]<-"MIDAZOLAM"
z$z6[grep("MIDAZOLAM",z$z6)]<-"MIDAZOLAM"
z$z7[grep("MIDAZOLAM",z$z7)]<-"MIDAZOLAM"
z$z8[grep("MIDAZOLAM",z$z8)]<-"MIDAZOLAM"
z$z9[grep("MIDAZOLAM",z$z9)]<-"MIDAZOLAM"
z$z10[grep("MIDAZOLAM",z$z10)]<-"MIDAZOLAM"
z$z11[grep("MIDAZOLAM",z$z11)]<-"MIDAZOLAM"
z$z12[grep("MIDAZOLAM",z$z12)]<-"MIDAZOLAM"
z$z13[grep("MIDAZOLAM",z$z13)]<-"MIDAZOLAM"

######################
#NORDIAZEPAM
#########################
z$z1[grep("NORDIAZEPAM",z$z1)]<-"NORDIAZEPAM"
z$z2[grep("NORDIAZEPAM",z$z2)]<-"NORDIAZEPAM"
z$z3[grep("NORDIAZEPAM",z$z3)]<-"NORDIAZEPAM"
z$z4[grep("NORDIAZEPAM",z$z4)]<-"NORDIAZEPAM"
z$z5[grep("NORDIAZEPAM",z$z5)]<-"NORDIAZEPAM"
z$z6[grep("NORDIAZEPAM",z$z6)]<-"NORDIAZEPAM"
z$z7[grep("NORDIAZEPAM",z$z7)]<-"NORDIAZEPAM"
z$z8[grep("NORDIAZEPAM",z$z8)]<-"NORDIAZEPAM"
z$z9[grep("NORDIAZEPAM",z$z9)]<-"NORDIAZEPAM"
z$z10[grep("NORDIAZEPAM",z$z10)]<-"NORDIAZEPAM"
z$z11[grep("NORDIAZEPAM",z$z11)]<-"NORDIAZEPAM"
z$z12[grep("NORDIAZEPAM",z$z12)]<-"NORDIAZEPAM"
z$z13[grep("NORDIAZEPAM",z$z13)]<-"NORDIAZEPAM"

#########################
# TEMAZEPAM[Restoril]
#########################
z$z1[grep("TEMAZEPAM",z$z1)]<-"TEMAZEPAM"
z$z2[grep("TEMAZEPAM",z$z2)]<-"TEMAZEPAM"
z$z3[grep("TEMAZEPAM",z$z3)]<-"TEMAZEPAM"
z$z4[grep("TEMAZEPAM",z$z4)]<-"TEMAZEPAM"
z$z5[grep("TEMAZEPAM",z$z5)]<-"TEMAZEPAM"
z$z6[grep("TEMAZEPAM",z$z6)]<-"TEMAZEPAM"
z$z7[grep("TEMAZEPAM",z$z7)]<-"TEMAZEPAM"
z$z8[grep("TEMAZEPAM",z$z8)]<-"TEMAZEPAM"
z$z9[grep("TEMAZEPAM",z$z9)]<-"TEMAZEPAM"
z$z10[grep("TEMAZEPAM",z$z10)]<-"TEMAZEPAM"
z$z11[grep("TEMAZEPAM",z$z11)]<-"TEMAZEPAM"
z$z12[grep("TEMAZEPAM",z$z12)]<-"TEMAZEPAM"
z$z13[grep("TEMAZEPAM",z$z13)]<-"TEMAZEPAM"


#detecting each drug presence on the primary cause when opioid=true
fun.detect<-function(x, text="COCAINE") {
  result<-c()
  for(i in 1:nrow(x)){
    result[i]<-ifelse(any(str_detect(x[i,], pattern=text) %in% TRUE), 1, 0)
  }
  result
}

#COCAINE
COCAINE<-fun.detect(z,text="COCAINE")
#  METHYLENEDIOXYMETHAMPHETAMINE / MDMA
MDMA<-fun.detect(z,text="MDMA")
# MDA
MDA<-fun.detect(z,text="MDA")
# METHAMPHETAMINE/METHA
METHAMPHETAMINE<-fun.detect(z,text="MAT_MINE")
#AMPHETAMINEMETHYLPHENIDATE
AMPHETAMINE<-fun.detect(z,text="AMPHETAMINE")
METHYLPHENIDATE<-fun.detect(z,text="METHYLPHENIDATE")
#MITRAGYNINE
MITRAGYNINE<-fun.detect(z,text="MITRAGYNINE")
# PHENCYCLIDINE(PCP)
PCP<-fun.detect(z,text="PCP")
#KETAMINE
KETAMINE<-fun.detect(z,text="KETAMINE")
# LYSERGIC ACID DIETHYLAMIDE(LSD)
LSD<-fun.detect(z,text="LSD")
#BENZODIAZEPINE
BENZODIAZEPINE<-fun.detect(z,text = "BENZODIAZEPINE")
#BARBITURATE
BARBITURATE<-fun.detect(z,text="BARBITURATE")
#HYPOXIC/ISCHEMIC
HYPOXIC<-fun.detect(z,text="HYPOXIC/ISCHEMIC")
#CYCLOBENZAPRINE
CYCLOBENZAPRINE<-fun.detect(z,text="CYCLOBENZAPRINE")
#METAXALONE
METAXALONE<-fun.detect(z,text="METAXALONE")
#METHOCARBAMOL
METHOCARBAMOL<-fun.detect(z,text="METHOCARBAMOL")
# CARISOPRODOL
CARISOPRODOL<-fun.detect(z,text="CARISOPRODOL")
#TIZANIDINE
TIZANIDINE<-fun.detect(z,text="TIZANIDINE")
#HEROIN
HEROIN<-fun.detect(z,text="HEROIN")
#METHADONE
METHADONE<-fun.detect(z,text="METHADONE")
#METHOXYACETYLFENTANYL/MAF
MAF<-fun.detect(z,text="MAF")
#ACETYL FENTANYL
ACETYL<-fun.detect(z,text="ACETYL")
#PARA-FLUOROBUTYRYL FENTANYL/FIBF
FIBF<-fun.detect(z,text="FIBF")
#BUTYRYL FENTANYL/ISOBUTYRYL FENTANYL
BUTYRYL<-fun.detect(z,text="BUTYRYL")
#DESPROPIONYL FENTANYL (4-ANPP) 
#DESPROPRIONYL
ANPP_4<-fun.detect(z,text="4-ANPP")
#CYCLOPROPYL FENTANYL
CYCLOPROPYL<-fun.detect(z,text="CYCLOPROPYL")
#CARFENTANYL/CARFENTANIL
CARFENTANIL<-fun.detect(z,text="CARFENTANIL")
#2-FURANYL FENTANYL
FURANYL_2<-fun.detect(z,text="2-FURANYL")
#NORFENTANYL/NFL
NORFENTANYL<-fun.detect(z,text="NFL")
#VALERYLFENTANYL/VFL
VALERYLFENTANYL<-fun.detect(z,text="VFL")
#ACRYL FENTANYL
ACRYL<-fun.detect(z,text="ACRYL")
#PARA-FLUOROFENTANYL/PFL
PFL<-fun.detect(z,text="PFL")
#FENTANYL
FENTANYL<-fun.detect(z,text="FENTANYL")
#HYDROMORPHONE
#############################
HYDROMORPHONE<-fun.detect(z,text="HYDROMORPHONE")
# MORPHINE
MORPHINE<-fun.detect(z,text="MORPHINE")
#OXYMORPHONE
OXYMORPHONE<-fun.detect(z,text="OXYMORPHONE")
#OXYCODONE
OXYCODONE<-fun.detect(z,text="OXYCODONE")
#HYDROCODONE
HYDROCODONE<-fun.detect(z,text="HYDROCODONE")
#DIHYDROCODEINE/HYDROCODOL
HYDROCODOL<-fun.detect(z,text="HYDROCODOL")
#CODEINE
CODEINE<-fun.detect(z,text="CODEINE")
#BUPRENORPHINE
BUPRENORPHINE<-fun.detect(z,text="BUPRENORPHINE")
#MEPERIDINE
MEPERIDINE<-fun.detect(z,text="MEPERIDINE")
#TRAMADOL
TRAMADOL<-fun.detect(z,text="TRAMADOL")
#TRAZODONE
TRAZODONE<-fun.detect(z,text="TRAZODONE")
#DEXTROMETHORPHAN/LEVOMETHORPHAN 
LEVOMETHORPHAN<-fun.detect(z,text="LEVOMETHORPHAN")
#DEXTRORPHAN/LEVORPHANOL
LEVORPHANOL<-fun.detect(z,text="LEVORPHANOL")
#U-47700
U_47700<-fun.detect(z,text="U-47700")
#U-49900
U_49900<-fun.detect(z,text="U-49900")
#ETHANOL
ETHANOL<-fun.detect(z,text="ETHANOL")
#OPIOID
OPIOID<-fun.detect(z,text="OPIOID")
#OPIATE
OPIATE<-fun.detect(z,text="OPIATE")
#3-fluorophenmetrazine [3-FPM]
FPM_3<-fun.detect(z,text="3-FPM")
#7-AMINOCLONAZEPAM
AMINOCLONAZEPAM_7<-fun.detect(z,text="7-AMINO")
#CLONAZEPAM [Klonopin]
CLONAZEPAM<-fun.detect(z,text="CLONAZEPAM")
#DELORAZEPAM
DELORAZEPAM<-fun.detect(z,text="DEL_PAM")
#DIAZEPAM[Valium]
########################
DIAZEPAM<-fun.detect(z,text="DIAZEPAM")
#DICLAZEPAM
DICLAZEPAM<-fun.detect(z,text="DICLAZEPAM")
#ETIZOLAM
ETIZOLAM<-fun.detect(z,text="ETIZOLAM")
#LORAZEPAM [Ativan]
LORAZEPAM<-fun.detect(z,text="LORAZEPAM")
#MIDAZOLAM [Versed]
MIDAZOLAM<-fun.detect(z,text="MIDAZOLAM")
#NORDIAZEPAM
NORDIAZEPAM<-fun.detect(z,text="NORDIAZEPAM")
#TEMAZEPAM[Restoril]

TEMAZEPAM<-fun.detect(z,text="TEMAZEPAM")

#making a csv format file 
drug<-cbind(COCAINE,MDMA,MDA,OPIOID,OPIATE,METHAMPHETAMINE,AMPHETAMINE,METHYLPHENIDATE,MITRAGYNINE,
            PCP,KETAMINE,LSD,BENZODIAZEPINE,BARBITURATE,HYPOXIC,CYCLOBENZAPRINE,METAXALONE,
            METHOCARBAMOL,CARISOPRODOL,TIZANIDINE,HEROIN,METHADONE,MAF,ACETYL,FIBF,BUTYRYL,
            ANPP_4,CYCLOPROPYL,CARFENTANIL,FURANYL_2,NORFENTANYL,VALERYLFENTANYL,ACRYL,
            PFL,FENTANYL,HYDROMORPHONE,MORPHINE,OXYMORPHONE,OXYCODONE,HYDROCODONE,
            HYDROCODOL,CODEINE,BUPRENORPHINE,MEPERIDINE,TRAMADOL,TRAZODONE,LEVOMETHORPHAN,
            LEVORPHANOL,U_47700,U_49900,ETHANOL,FPM_3,AMINOCLONAZEPAM_7,CLONAZEPAM,
            DELORAZEPAM,DIAZEPAM,DICLAZEPAM,ETIZOLAM,LORAZEPAM,MIDAZOLAM,NORDIAZEPAM,
            TEMAZEPAM)

fentanyl_all<-cbind(MAF,ACETYL,FIBF,BUTYRYL,ANPP_4,CYCLOPROPYL,CARFENTANIL,
                    FURANYL_2,NORFENTANYL,VALERYLFENTANYL,ACRYL,PFL,FENTANYL)


fun_count<-function(x){
  result<-c()
  for(i in 1:nrow(x)){
    result[i]<-ifelse(any(x[i,]>0) %in% TRUE,1,0)
  }
  result
}

#count all types of fentanyl as fentanyl 
fentanyl_All<-fun_count(fentanyl_all)

#primary cause 
primary_cause<-county$primarycause_linea
primary_id<-county$casenumber
Death_Date<-county$death_date
drug2<-data.frame(primary_id,primary_cause,Death_Date,drug,fentanyl_All)

fun_count1<-function(x){
  result<-c()
  for(i in 1:nrow(x)){
    result[i]<-ifelse(any(x[i,]>0) %in% TRUE,1,0)
  }
  result
}

fentanyl<-data.frame(drug2$fentanyl_All,drug2$CARFENTANIL,drug2$ANPP_4,drug2$U_47700)

count1<-fun_count1(fentanyl)

nonfentanyl1<-data.frame(drug2$COCAINE,drug2$MDMA,drug2$MDA,drug2$METHAMPHETAMINE,
                        drug2$AMPHETAMINE,drug2$LSD,drug2$FPM_3,drug2$AMINOCLONAZEPAM_7,
                        drug2$CLONAZEPAM,drug2$DELORAZEPAM,drug2$DIAZEPAM,
                        drug2$DICLAZEPAM,drug2$ETIZOLAM,drug2$LORAZEPAM,
                        drug2$MIDAZOLAM,drug2$NORDIAZEPAM,drug2$TEMAZEPAM)

nonfentanyl2<-data.frame(drug2$HEROIN,drug2$CODEINE,drug2$METHADONE,
                        drug2$MORPHINE,drug2$HYDROCODONE,drug2$TRAMADOL,
                        drug2$OXYCODONE,drug2$OXYMORPHONE,drug2$BUPRENORPHINE,
                        drug2$MITRAGYNINE,drug2$OPIOID,drug2$OPIATE)

nonfentanyl<-data.frame(nonfentanyl1,nonfentanyl2)

count3<-fun_count1(nonfentanyl)

fent<-data.frame(count1,count3,drug2$primary_id,drug2$primary_cause,
                fentanyl,nonfentanyl)

index<-which(fent$count1==1&fent$count3==1)
fent$count3[index]<-0

colnames(fent)<-c("Fentanyl-Involved Fatal Overdoses", 
                  "Nonfentanyl Opioid and Polydrug Fatal Overdoses",
                  "primary_id","primary_cause", "FENTANYL",
                  "CARFENTANIL","ANPP_4","U_47700","COCAINE","MDMA","MDA",
                  "METHAMPHETAMINE","AMPHETAMINE","LSD","FPM_3","AMINOCLONAZEPAM_7","CLONAZEPAM",
                  "DELORAZEPAM","DIAZEPAM","DICLAZEPAM","ETIZOLAM","LORAZEPAM","MIDAZOLAM",
                  "NORDIAZEPAM", "TEMAZEPAM","HEROIN", "CODEINE","METHADONE","MORPHINE",
                  "HYDROCODONE","TRAMADOL","OXYCODONE","OXYMORPHONE","BUPRENORPHINE","MITRAGYNINE",
                  "OPIOID", "OPIATE")


write_csv(fent,file="./data/drug_classifications.csv")
