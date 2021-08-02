import pandas as pd


DRUG_CLASSIFICATIONS: dict[str, set] = {
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
    "ETHANOL": {"ETHANOL", "ALCOHOL"},
    "OPIOID": {"OPIOID"},
    "OPIATE": {"OPIATE"},
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
}
"""Drug extraction dictionary: keys (new column labels) and values (to search for)."""


def load_data() -> pd.DataFrame:
    """Loads dataset."""
    return pd.read_csv("./data/geocoded_case_archives.csv", low_memory=False)


def join_cols(row) -> str:
    """Joins various column values."""
    return f"{row['primarycause_linea']};{row['primarycause_lineb']}{row['primarycause_linec']}{row['secondarycause']}"


def make_combined_secondary(df: pd.DataFrame) -> pd.DataFrame:
    """Makes a combined secondary column on the dataframe anmd returns a new one."""
    df["secondary_combined"] = df.apply(lambda row: join_cols(row), axis=1)
    return df


def search_handler(x, search_words):
    """Searches x for search words. Handles pd.NA values."""
    if pd.isna(x):
        return None
    if any(word.lower() in x.lower() for word in search_words):
        return True
    return False


def search_fent_drugs(row, fent_toggle: bool = True, primary_toggle: bool = True):
    """Examines various column values to identify if the record is fentanyl or nonfentanyl related."""
    non_fent_drug_cols = [
        "COCAINE",
        "MDMA",
        "MDA",
        "MAT_MINE",
        "AMPHETAMINE",
        "LSD",
        "3-FPM",
        "7-AMINO",
        "CLONAZEPAM",
        "DEL_PAM",
        "DIAZEPAM",
        "DICLAZEPAM",
        "ETIZOLAM",
        "LORAZEPAM",
        "MIDAZOLAM",
        "NORDIAZEPAM",
        "TEMAZEPAM",
        "HEROIN",
        "CODEINE",
        "METHADONE",
        "MORPHINE",
        "HYDROCODONE",
        "TRAMADOL",
        "OXYCODONE",
        "OXYMORPHONE",
        "BUPRENORPHINE",
        "MITRAGYNINE",
        "OPIOID",
        "OPIATE",
    ]
    fent_drugs_cols = [
        "MAF",
        "ACETYL",
        "FIBF",
        "BUTYRYL",
        "4-ANPP",
        "CYCLOPROPYL",
        "CARFENTANIL",
        "2-FURANYL",
        "NFL",
        "VFL",
        "ACRYL",
        "PFL",
        "FENTANYL",
    ]
    if fent_toggle:
        if primary_toggle:
            for drug_name in fent_drugs_cols:
                if row[f"{drug_name}_primary"] is True:
                    return True
            return False
        else:
            for drug_name in fent_drugs_cols:
                if row[f"{drug_name}_secondary"] is True:
                    return True
            return False
    else:
        if primary_toggle:
            for drug_name in non_fent_drug_cols:
                if row[f"{drug_name}_primary"] is True:
                    return True
            return False
        else:
            for drug_name in non_fent_drug_cols:
                if row[f"{drug_name}_secondary"] is True:
                    return True
            return False


def make_composite_fentanyl(df: pd.DataFrame):
    """Makes two new columns for fentanyl/not related cases."""
    df["fentanyl_related_primary"] = df.apply(
        lambda row: search_fent_drugs(row, fent_toggle=True, primary_toggle=True),
        axis=1,
    )
    df["fentanyl_related_secondary"] = df.apply(
        lambda row: search_fent_drugs(row, fent_toggle=False, primary_toggle=False),
        axis=1,
    )
    df["nonfentanyl_related_primary"] = df.apply(
        lambda row: search_fent_drugs(row, fent_toggle=False, primary_toggle=True),
        axis=1,
    )
    df["nonfentanyl_related_secondary"] = df.apply(
        lambda row: search_fent_drugs(row, fent_toggle=False, primary_toggle=False),
        axis=1,
    )


def write_file(df: pd.DataFrame):
    df.to_csv("./data/extracted_drugs.csv", index=False)
