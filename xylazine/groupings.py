import pandas as pd

cases_with_distances = pd.read_csv("xylazine/cases_with_distances.csv")
controls_with_distances = pd.read_csv("xylazine/controls_with_distances.csv")

sampled_cases = cases_with_distances.sample(len(cases_with_distances))
sampled_controls = controls_with_distances.sample(3 * int(len(cases_with_distances)))
combined: pd.DataFrame = pd.concat([sampled_cases, sampled_controls], ignore_index=True)  # type: ignore


def categorize_age(age: float) -> str:
    if pd.isna(age):
        return "Unknown"
    if age < 18:
        return "Under 18"
    elif 18 <= age <= 24:
        return "18-24"
    elif 25 <= age <= 34:
        return "25-34"
    elif 35 <= age <= 44:
        return "35-44"
    elif 45 <= age <= 54:
        return "45-54"
    elif 55 <= age <= 64:
        return "55-64"
    elif age >= 65:
        return "65+"
    else:
        raise ValueError("Unexpected age: {}".format(age))


combined["age_category"] = combined["age"].apply(categorize_age)


results = combined.groupby(
    ["case_control", "age_category", "latino", "race", "gender"]
).describe()["avg_distance"]

print(results)
