import pandas as pd
from rich import print


df = pd.read_csv("./xylazine_matched_alcohol.csv")

locations = (
    df.groupby(["final_latitude", "final_longitude"])
    .size()
    .reset_index()
    .reset_index()
    .rename(columns={0: "count", "index": "location_num"})
    .drop(columns=["count"])
)

locations["location_num"] = locations["location_num"].apply(lambda x: f"location_{x}")

locations.to_csv("./alcohol_location_codes.csv", index=False)

locations.set_index(["final_latitude", "final_longitude"], inplace=True)

case_loc_counts = (
    df[df["case"] == 1]
    .groupby(["final_latitude", "final_longitude"])
    .count()["casenumber"]
    .reset_index()
    .rename(columns={"casenumber": "count"})
)

case_loc_counts["location_num"] = case_loc_counts.apply(
    lambda row: locations.loc[(row["final_latitude"], row["final_longitude"])],
    axis=1,
)

control_loc_counts = (
    df[df["case"] == 0]
    .groupby(["final_latitude", "final_longitude"])
    .count()["casenumber"]
    .reset_index()
    .rename(columns={"casenumber": "count"})
)

control_loc_counts["location_num"] = control_loc_counts.apply(
    lambda row: locations.loc[(row["final_latitude"], row["final_longitude"])],
    axis=1,
)

print(case_loc_counts)
print(control_loc_counts)
case_loc_counts.to_csv("./alcohol_case_location_counts.csv", index=False)
control_loc_counts.to_csv("./alcohol_control_location_counts.csv", index=False)

df = pd.read_csv("./xylazine_matched_fentanyl.csv")

locations = (
    df.groupby(["final_latitude", "final_longitude"])
    .size()
    .reset_index()
    .reset_index()
    .rename(columns={0: "count", "index": "location_num"})
    .drop(columns=["count"])
)

locations["location_num"] = locations["location_num"].apply(lambda x: f"location_{x}")
locations.to_csv("./fentanyl_location_codes.csv", index=False)

locations.set_index(["final_latitude", "final_longitude"], inplace=True)

case_loc_counts = (
    df[df["case"] == 1]
    .groupby(["final_latitude", "final_longitude"])
    .count()["casenumber"]
    .reset_index()
    .rename(columns={"casenumber": "count"})
)

case_loc_counts["location_num"] = case_loc_counts.apply(
    lambda row: locations.loc[(row["final_latitude"], row["final_longitude"])],
    axis=1,
)

control_loc_counts = (
    df[df["case"] == 0]
    .groupby(["final_latitude", "final_longitude"])
    .count()["casenumber"]
    .reset_index()
    .rename(columns={"casenumber": "count"})
)

control_loc_counts["location_num"] = control_loc_counts.apply(
    lambda row: locations.loc[(row["final_latitude"], row["final_longitude"])],
    axis=1,
)

print(case_loc_counts)
print(control_loc_counts)
case_loc_counts.to_csv("./fentanyl_case_location_counts.csv", index=False)
control_loc_counts.to_csv("./fentanyl_control_location_counts.csv", index=False)
