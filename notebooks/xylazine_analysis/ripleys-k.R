
library(spatstat)
library(smacpod)
library(tidyr)
library(dplyr)

# --------- 

print("starting xylazine and fentanyl")

# load datasets and combine
# drop nulls
case_and_controls_match <- read.csv("xylazine_matched_fentanyl.csv")

case_and_controls_match$case <- as.factor(case_and_controls_match$case)

original_rows <- nrow(case_and_controls_match)
case_and_controls <- case_and_controls_match %>%
  drop_na("composite_latitude") %>%
  drop_na("composite_longitude")
filtered_rows <- nrow(case_and_controls)
cat("Ommited", original_rows - filtered_rows, "(case) rows because they contained nulls.\n")

sample_n(case_and_controls, size = 5)

cases <- filter(case_and_controls, case == 1)
controls <- filter(case_and_controls, case == 0)
cat("Total:", nrow(case_and_controls), "Cases: ", nrow(cases), " Controls: ", nrow(controls))
stopifnot(nrow(case_and_controls) == nrow(cases) + nrow(controls))

# -------------------
# cases analysis

# latitude is Y axis
# make pattern
case_pattern <- ppp(cases$composite_longitude, cases$composite_latitude, c(-89, -87), c(41, 43), checkdup = FALSE)

# visualize pattern
summary(case_pattern)

# plot Kest
# plot(Kest(case_pattern))

# plot envelopes
env1 <- envelope(case_pattern, Kest, nsim = 999)
plot(env1)

# ------------------
# replicate for controls

# latitude is Y axis
# make pattern
control_pattern <- ppp(controls$composite_longitude, controls$composite_latitude, c(-89, -87), c(41, 43), checkdup = FALSE)

# visualize pattern
summary(control_pattern)

# plot Kest
# plot(Kest(control_pattern))

# plot envelopes
plot(envelope(control_pattern, Kest, nsim = 999))

# ----------------
# compare case_and_controls

combined_pattern <- ppp(case_and_controls$composite_longitude, case_and_controls$composite_latitude, c(-89, -87), c(41, 43), marks = case_and_controls$case,  checkdup = FALSE)
marks(combined_pattern) <- case_and_controls$case

summary(combined_pattern)

# use envelope and `kd` function from smacpod
comp_env <- envelope(combined_pattern, kd, nsim = 999)
plot(comp_env)
write.csv(comp_env, "fentanyl_compared_pattern.csv", row.names = FALSE)


# -------------------------------------------------------------------------
print("starting xylazine and alcohol")

# load datasets and combine
# drop nulls
case_and_controls_match <- read.csv("xylazine_matched_alcohol.csv")

case_and_controls_match$case <- as.factor(case_and_controls_match$case)

original_rows <- nrow(case_and_controls_match)
case_and_controls <- case_and_controls_match %>%
  drop_na("composite_latitude") %>%
  drop_na("composite_longitude")
filtered_rows <- nrow(case_and_controls)
cat("Ommited", original_rows - filtered_rows, "(case) rows because they contained nulls.\n")

sample_n(case_and_controls, size = 5)

cases <- filter(case_and_controls, case == 1)
controls <- filter(case_and_controls, case == 0)
cat("Total:", nrow(case_and_controls), "Cases: ", nrow(cases), " Controls: ", nrow(controls))
stopifnot(nrow(case_and_controls) == nrow(cases) + nrow(controls))

# -------------------
# cases analysis

# latitude is Y axis
# make pattern
case_pattern <- ppp(cases$composite_longitude, cases$composite_latitude, c(-89, -87), c(41, 43), checkdup = FALSE)

# visualize pattern
summary(case_pattern)

# plot Kest
# plot(Kest(case_pattern))

# plot envelopes
plot(envelope(case_pattern, Kest, nsim = 999))

# ------------------
# replicate for controls

# latitude is Y axis
# make pattern
control_pattern <- ppp(controls$composite_longitude, controls$composite_latitude, c(-89, -87), c(41, 43), checkdup = FALSE)

# visualize pattern
summary(control_pattern)

# plot Kest
# plot(Kest(control_pattern))

# plot envelopes
plot(envelope(control_pattern, Kest, nsim = 999))

# ----------------
# compare case_and_controls

combined_pattern <- ppp(case_and_controls$composite_longitude, case_and_controls$composite_latitude, c(-89, -87), c(41, 43), marks = case_and_controls$case,  checkdup = FALSE)
marks(combined_pattern) <- case_and_controls$case

summary(combined_pattern)

# use envelope and `kd` function from smacpod
comp_env <- envelope(combined_pattern, kd, nsim = 999)
plot(comp_env)
write.csv(comp_env, "alcohol_compared_pattern.csv", row.names = FALSE)

