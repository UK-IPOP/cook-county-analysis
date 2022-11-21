
library(spatstat)
library(smacpod)
library(tidyr)
library(dplyr)

# --------- 

# xylazine fentanyl
# load datasets and combine
# drop nulls
data <- read.csv("./projected_xylazine_fentanyl.csv")

df <- tibble::as_tibble(data)

######

comp_pattern <- ppp(
    df$x_coord,
    df$y_coord,
    c(min(df$x_coord), max(df$x_coord)),
    c(min(df$y_coord), max(df$y_coord)),
    marks = factor(df$case),
    checkdup = FALSE
)

# use envelope and `kd` function from smacpod
# rmax to 50k for meters (about 30 miles)
xylazine_fent_comp <- envelope(comp_pattern, kd, nsim = 999, correction = "Ripley", rmax = 50000)
summary(xylazine_fent_comp)
plot(xylazine_fent_comp)
write.csv(xylazine_fent_comp, file = "ripleys_xylazine_fentanyl.csv")


# xylazine alcohol

# load datasets and combine
# drop nulls
data <- read.csv("./projected_xylazine_alcohol.csv")

df <- tibble::as_tibble(data)

######

comp_pattern <- ppp(
  df$x_coord,
  df$y_coord,
  c(min(df$x_coord), max(df$x_coord)),
  c(min(df$y_coord), max(df$y_coord)),
  marks = factor(df$case),
  checkdup = FALSE
)

# use envelope and `kd` function from smacpod
# rmax to 50k for meters (about 30 miles)
xylazine_alcohol_comp <- envelope(comp_pattern, kd, nsim = 999, correction = "Ripley", rmax = 50000)
summary(xylazine_alcohol_comp)
plot(xylazine_alcohol_comp)
write.csv(xylazine_alcohol_comp, file = "ripleys_xylazine_alcohol.csv")



# xylazine stimulant

# load datasets and combine
# drop nulls
data <- read.csv("./projected_xylazine_stimulant.csv")

df <- tibble::as_tibble(data)

######

comp_pattern <- ppp(
  df$x_coord,
  df$y_coord,
  c(min(df$x_coord), max(df$x_coord)),
  c(min(df$y_coord), max(df$y_coord)),
  marks = factor(df$case),
  checkdup = FALSE
)

# use envelope and `kd` function from smacpod
# rmax to 50k for meters (about 30 miles)
xylazine_stimulant_comp <- envelope(comp_pattern, kd, nsim = 999, correction = "Ripley", rmax = 50000)
summary(xylazine_stimulant_comp)
plot(xylazine_stimulant_comp)
write.csv(xylazine_stimulant_comp, file = "ripleys_xylazine_stimulant.csv")




##################

# # statndard lat/long
# comp_pattern <- ppp(
#   df$composite_longitude,
#   df$composite_latitude,
#   c(min(df$composite_longitude), max(df$composite_longitude)),
#   c(min(df$composite_latitude), max(df$composite_latitude)),
#   marks = factor(df$case_control),
#   checkdup = FALSE
# )

# # use envelope and `kd` function from smacpod
# # rmax to 50k for meters (about 30 miles)
# comp_all <- envelope(comp_pattern, kd, nsim = 999, correction = "Ripley")
# summary(comp_all)
# write.csv(output, file = "xylazine_fentanyl_standard.csv")
# plot(comp_all)


# for (x in 2019:2022) {
#   print(x)
#   filt_df <- filter(df, death_year == x)
# 
#   pattern <- ppp(
#     filt_df$x_coord,
#     filt_df$y_coord,
#     c(min(filt_df$x_coord), max(filt_df$x_coord)),
#     c(min(filt_df$y_coord), max(filt_df$y_coord)),
#     marks = factor(filt_df$case_control),
#     checkdup = FALSE
#   )
# 
#   # use envelope and `kd` function from smacpod
#   # rmax to 50k for meters (about 30 miles)
#   output <- envelope(pattern, kd, nsim = 999, correction = "Ripley")
#   # write.csv(output, file = sprintf("xylazine_fentanyl_%s.csv", x))
#   plot(output, main = sprintf("Output %s", x))
# }



