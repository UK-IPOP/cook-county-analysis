import pandas as pd


df = pd.read_csv("./xylazine_matched_alcohol.csv")
df[df["case_control"] == "xylazine"].dropna().to_csv("alcohol_cases.csv", index=False)
df[df["case_control"] == "alcohol"].dropna().to_csv("alcohol_controls.csv", index=False)

df = pd.read_csv("./xylazine_matched_fentanyl.csv")
df[df["case_control"] == "xylazine"].dropna().to_csv("fentanyl_cases.csv", index=False)
df[df["case_control"] == "fentanyl"].dropna().to_csv(
    "fentanyl_controls.csv", index=False
)
