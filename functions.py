#Importing the pandas library
import pandas as pd
from IPython.display import display

#Creating a function to automate the EDA process
def fast_eda(df: pd.DataFrame):
    print("Shape of the DataFrame:", df.shape)
    print("\nData types of the DataFrame:")
    display(df.dtypes)
    print("\nFirst 5 rows of the DataFrame:")
    display(df.head())
    print("\nLast 5 rows of the DataFrame:")
    display(df.tail())
    print("\nStatistical summary of the DataFrame:")
    display(df.describe())
    print("\nChecking for missing values:")
    print(df.isnull().sum())
    print("\nChecking for duplicates:")
    print(df.duplicated().sum())

#Creating a function to check the unique values of each column
def all_unique_values(df: pd.DataFrame):
    for column in df.columns:
        print(f"\n{column}:")
        display(df[column].unique())