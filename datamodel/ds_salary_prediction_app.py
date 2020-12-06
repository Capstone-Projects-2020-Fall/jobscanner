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

Rating = st.slider('Glassdoor Rating of the Company',min_value=1.0, max_value=5.0, step=0.1)

# st.subheader('Number of Competitors')

No_of_Competitors = st.slider('Number of Competitors',min_value=0.0, max_value=4.0, step=1.0)

# st.subheader('Company Age')

Age = st.slider('Age of the Company', step=1.0, min_value=0.0,max_value=330.0)

## description length
# st.subheader("Choose Approximate length of job description")

desc_length = st.slider('Choose Approximate length of job description',min_value=110.0, max_value=15121.0, step=10.0)

# st.subheader("Choose Revenue of the company")
Revenue_1,Revenue_Less_than_10_million,Revenue_Unknown_Non_Applicable, Revenue_1_to_5_billion,Revenue_10_to_50_billion, Revenue_10_to_50_million,Revenue_100_to_500_billion,Revenue_100_to_500_million, Revenue_5_to_10_billion,Revenue_50_to_100_billion,Revenue_50_to_100_million,Revenue_500_million_to_1_billion,Revenue_500_billion = 0,0,0,0,0,0,0,0,0,0,0,0,0


list_of_revenue = list(df['Revenue'].unique())
for i in range(len(list_of_revenue)):
    if list_of_revenue[i] == "-1":
        list_of_revenue[i] = "₹1 to ₹5 billion (INR)"
        break

revenue = st.selectbox('Revenue', list_of_revenue,index=0)

if revenue == "₹1 to ₹5 million (INR)":
    Revenue_1 = 1
elif revenue =="Less than ₹10 million (INR)":
    Revenue_Less_than_10_million = 1
elif revenue == "Unknown / Non-Applicable":
    Revenue_Unknown_Non_Applicable = 1 #dont use and operator
elif revenue == '₹1 to ₹5 billion (INR)':
    Revenue_1_to_5_billion = 1
elif revenue == "₹10 to ₹50 billion (INR)":#5
    Revenue_10_to_50_billion = 1
elif revenue == "₹10 to ₹50 million (INR)":
    Revenue_10_to_50_million = 1
elif revenue == "₹100 to ₹500 billion (INR)":
    Revenue_100_to_500_billion = 1
elif revenue == "₹10 to ₹500 million (INR)":
    Revenue_100_to_500_million = 1
elif revenue == "₹5 to ₹10 billion (INR)":
    Revenue_5_to_10_billion = 1
elif revenue == "₹50 to ₹100 billion (INR)":
    Revenue_50_to_100_billion = 1
elif revenue == "₹50 to ₹100 million (INR)":
    Revenue_50_to_100_million = 1
elif revenue == "₹500 million to ₹1 billion (INR)":
    Revenue_500_million_to_1_billion = 1
elif revenue == "₹500+ billion (INR)":#13
    Revenue_500_billion = 1

