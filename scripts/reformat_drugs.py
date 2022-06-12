import numpy as np
import pandas as pd


def rollup(row: pd.Series, fields: list[str]) -> int:
    for field in fields:
        if row[field] == 1:
            return 1
    return 0


if __name__ == "__main__":
    drugs_wide = pd.read_csv("./data/drugs/merged_results.csv", low_memory=False)

    # replacing names and filling with 9s
    drug_cols = [
        col for col in drugs_wide.columns if col.endswith("_1") or col.endswith("_2")
    ]
    drugs_wide.rename(
        columns={
            c: c.replace("_1", "_primary").replace("_2", "_secondary")
            for c in drug_cols
        },
        inplace=True,
    )

    # nitazene rollup
    names = [
        "etodesnitazene",
        "isotonitazene",
        "metonitazene",
        "protonitazene",
        "flunitazene",
        "utonitazene",
    ]
    fields1 = [f"{x}_primary" for x in names]
    fields2 = [f"{x}_secondary" for x in names]
    fields = fields1 + fields2
    limited_fields = [f for f in fields if f in drugs_wide.columns]
    drugs_wide["nitazene"] = drugs_wide.apply(
        lambda row: rollup(row, limited_fields), axis=1
    )

    null_fillers = {c: 9 for c in drug_cols}
    drugs_wide = drugs_wide.fillna(null_fillers)

    drugs_wide.replace(to_replace=np.NaN, value=0, inplace=True)
    drugs_wide.to_csv("./data/output/finalized.csv", index=False)
