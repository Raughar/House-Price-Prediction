#Importing the pandas library
import pandas as pd
import numpy as np
import matplotlib.pylab as plt
import seaborn as sns
import sklearn as sk
import warnings
import re
import plotly.express as px
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.linear_model import LinearRegression
from sklearn.linear_model import Lasso
from sklearn.ensemble import RandomForestRegressor
from sklearn.neighbors import KNeighborsRegressor
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import Normalizer
from imblearn.over_sampling import RandomOverSampler
from sklearn.metrics import mean_absolute_error
from sklearn.metrics import mean_squared_error
from sklearn.metrics import r2_score
from sklearn.metrics import accuracy_score
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

#Creating a function to deal with the outliers using the IQR method
def remove_outliers(df: pd.DataFrame, column: str):
    Q1 = df[column].quantile(0.25)
    Q3 = df[column].quantile(0.75)
    IQR = Q3 - Q1
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR
    df.drop(df[(df[column] < lower_bound) | (df[column] > upper_bound)].index, inplace=True)

#Creating a function to test different models and get the metrics
def model_testing(models, X_train, X_test, y_train, y_test):
    results_dict = {'Model': [], 'MSE': [], 'RMSE': [], 'MAE': [], 'R2': []}
    for model in models:
        model.fit(X_train, y_train)
        predictions = model.predict(X_test)
        mse = mean_squared_error(y_test, predictions)
        rmse = np.sqrt(mse)
        mae = mean_absolute_error(y_test, predictions)
        r2 = r2_score(y_test, predictions)
        results_dict['Model'].append(model)
        results_dict['MSE'].append(mse)
        results_dict['RMSE'].append(rmse)
        results_dict['MAE'].append(mae)
        results_dict['R2'].append(r2)
    return pd.DataFrame(results_dict)