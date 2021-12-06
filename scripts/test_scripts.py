import join_files
import numpy as np
import pandas as pd


def test_fill_nulls():
    fake = pd.DataFrame(
        [["hi", np.nan, "Bye"], ["wow", "hello", "goodbye"]],
        columns=["first", "second_primary", "last"],
    )
    result = join_files.fill_nulls(fake)
    assert result.isna().sum().sum() == 0
