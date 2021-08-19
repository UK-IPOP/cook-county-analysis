from __future__ import annotations

from typing import Union
import pandas as pd
from dataclasses import dataclass
import re


@dataclass
class DRUG_CLASS:
    """Class to hold drug classifications."""

    name: str
    search_terms: set[str]
    fentanyl_related: bool
    opiate_related: bool
    cannabis_related: bool
    stimulant_related: bool
    ethanol_related: bool
    hallucinogen_related: bool
    sedative_related: bool
    inhalant_related: bool
    toxic_related: bool
    nicotine_related: bool
    polysubstance_related: bool
    drug_related: bool

    # TODO: add validation in post init

    @classmethod
    def load_from_file(cls, file_path: str) -> list[DRUG_CLASS]:
        """Load drug classifications from file."""
        df = pd.read_csv(file_path)
        return cls.from_df(df)

    @classmethod
    def from_df(cls, df: pd.DataFrame) -> list[DRUG_CLASS]:
        """Create drug classifications from dataframe."""
        drug_classifications = []
        for _, row in df.iterrows():
            drug_classifications.append(
                cls(
                    name=str(row["name"]),
                    search_terms=set(str(row["search_terms"]).split(";")),
                    fentanyl_related=bool(row["fentanyl_related"]),
                    opiate_related=bool(row["opiate_related"]),
                    cannabis_related=bool(row["cannabis_related"]),
                    stimulant_related=bool(row["stimulant_related"]),
                    ethanol_related=bool(row["ethanol_related"]),
                    hallucinogen_related=bool(row["hallucinogen_related"]),
                    sedative_related=bool(row["sedative_related"]),
                    inhalant_related=bool(row["inhalant_related"]),
                    toxic_related=bool(row["toxic_related"]),
                    nicotine_related=bool(row["nicotine_related"]),
                    polysubstance_related=bool(row["polysubstance_related"]),
                    drug_related=bool(row["drug_related"]),
                )
            )
        return drug_classifications


DRUGS: dict[str, set] = {
    "COCAINE": {"COCAIN"},
    "MDA": {"MDA"},
    "MDMA": {"METHYLENEDIOXYMETHAMPHETAMINE", "METHYLEN", "MDMA"},
    "MAT_MINE": {"METHAMPHETAMINE"},
    "AMPHETAMINE": {"AMPHE"},
    "METHYLPHENIDATE": {"METHYLPH"},
    "MITRAGYNINE": {"MITRAGY"},
    "PCP": {"PHENCYCLIDINE", "PCP", "PHENCYCL"},
    "KETAMINE": {"KETAMINE"},
    "LSD": {"LYSERGIC", "LSD"},
    "BENZODIAZEPINE": {"BENZODIA"},
    "BARBITURATE": {"BARBITU"},
    "HYPOXIC/ISCHEMIC": {"HYPOXIC/ISCHEMIC", "HYPOXIC", "HYPOXIC-ISCHEMIC"},
    "CYCLOBENZAPRINE": {"CYCLOBENZAP"},
    "METAXALONE": {"METAXAL"},
    "METHOCARBAMOL": {"METHOCARBAMOL"},
    "CARISOPRODOL": {"CARISOPR"},
    "TIZANIDINE": {"TIZANIDINE"},
    "HEROIN": {"HEROIN"},
    "METHADONE": {"METHADONE"},
    "MAF": {"METHOXYACETYL"},
    "ACETYL": {"ACETYL"},
    "FIBF": {"FLUOROBUTYRYL", "FIBF", "FLUOROISOBUTYRYL", "FLUROISOBUTYRYL"},
    "BUTYRYL": {"BUTYRYL", "ISOBUTYRYL"},
    "4-ANPP": {"DESPROPIONYL", "ANPP", "DESPROPRIONYL"},
    "CYCLOPROPYL": {"CYCLOPROPYL"},
    "CARFENTANIL": {"CARFENTANYL", "CARFENTANIL"},
    "2-FURANYL": {"FURANYL"},
    "NFL": {"NORFENTANYL"},
    "VFL": {"VALERYLFENTANYL"},
    "ACRYL": {"ACRYL"},
    "PFL": {"PARA-FLUOROFENTANYL", "PARAFLUOROFENTANYL"},
    "FENTANYL": {"FENTAYL", "FENTANYL"},
    "HYDROMORPHONE": {"HYDROMORPHONE"},
    "MORPHINE": {"MORPHINE"},
    "OXYMORPHONE": {"OXYMORPHONE"},
    "OXYCODONE": {"OXYCODONE"},
    "HYDROCODONE": {"HYDROCODONE"},
    "HYDROCODOL": {"DIHYDROCODEINE", "HYDROCODOL", "DIHYROCODEINE"},
    "CODEINE": {"CODEINE"},
    "BUPRENORPHINE": {"BUPRENORPHINE"},
    "MEPERIDINE": {"MEPERIDINE"},
    "TRAMADOL": {"TRAMADOL"},
    "TRAZODONE": {"TRAZODONE"},
    "LEVOMETHORPHAN": {"DEXTROMETHORPHAN", "LEVOMETHORPHAN", "METHORPHAN"},
    "LEVORPHANOL": {"DEXTRORPHAN", "LEVORPHANOL"},
    "U-47700": {"U-47700", "U47700", "47700"},
    "U-49900": {"U-49900", "U49900"},
    "OPIOID": {"OPIOID", "OPIATE"},
    "3-FPM": {"FLUOROPHENMETRAZINE"},
    "7-AMINO": {"AMINOCLONAZEPAM"},
    "CLONAZEPAM": {"CLONAZEPAM"},
    "DEL_PAM": {"DELORAZEPAM"},
    "DIAZEPAM": {"DIAZEPAM"},
    "DICLAZEPAM": {"DICLAZEPAM"},
    "ETIZOLAM": {"ETIZOLAM"},
    "LORAZEPAM": {"LORAZEPAM"},
    "MIDAZOLAM": {"MIDAZOLAM"},
    "NORDIAZEPAM": {"NORDIAZEPAM"},
    "TEMAZEPAM": {"TEMAZEPAM"},
    "ALCOHOL": {"ALCOHOL"},
    "ETHANOL": {"ETHANOL"},
    "COVID": {"COVID", "COVID-19", "CORONA"},
    "INHALANT": {"INHALANT"},
    "NICOTINE": {"NICOTINE"},
    "CANNABIS": {"CANNABIS"},
    "POLY": {"POLY SUB", "MULTIPLE", "VARIATIONS"},  # this one may need some reworking
}
"""Drug extraction dictionary: keys (new column labels) and values (to search for)."""


def load_data() -> pd.DataFrame:
    """Loads dataset."""
    return pd.read_csv("./data/joined_records.csv", low_memory=False)


def join_cols(row) -> str:
    """Joins various column values."""
    return f"{row['primarycause_linea']};{row['primarycause_lineb']}{row['primarycause_linec']}{row['secondarycause']}"


def make_combined_secondary(df: pd.DataFrame) -> pd.DataFrame:
    """Makes a combined secondary column on the dataframe anmd returns a new one."""
    df["secondary_combined"] = df.apply(lambda row: join_cols(row), axis=1)
    return df


def search_handler(x, search_words: set[str]) -> Union[bool, None]:
    """Searches x for search words. Handles pd.NA values."""
    if pd.isna(x):
        return None
    if any(re.search(word.lower(), x.lower()) for word in search_words):
        return True
    return False


def write_file(df: pd.DataFrame):
    df.to_csv("./data/extracted_drugs.csv", index=False)
