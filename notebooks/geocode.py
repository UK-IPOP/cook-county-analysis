from rich import pretty, print
from rich.progress import track
import pandas as pd

pretty.install()

df = pd.read_csv("../data/cleaned_addresses_full.csv")
print(df.shape)

for i, row in track(df.iterrows()):
    address = ...
