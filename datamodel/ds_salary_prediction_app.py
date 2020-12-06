import streamlit as st
import pickle
import numpy as np
import pandas as pd
import time

df = pd.read_csv("EDA_dp.csv")

# st.write(df.head())

st.title('Computer Science Salary Predictor Application')
st.write("""

This app predicts the Salary for **computer science graduates** over 2 years based on Machine Learning Algorithms (linear regression model and decision tree), also the job salary model scrapped by job scanner team for CIS 4398.
""")

st.subheader('Company Details \n Check Glassdoor for exact values, if unsure')


