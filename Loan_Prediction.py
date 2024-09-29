import pyodbc
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Define the connection string for Windows Authentication (Trusted Connection)
conn_str = (
    r'DRIVER={SQL Server};'
    r'SERVER=DESKTOP-OLQ2EC3\SQLEXPRESS;'
    r'DATABASE=db_capstone;'
    r'Trusted_Connection=yes;'
)

# Establish the connection
conn = pyodbc.connect(conn_str)

# SQL query to fetch the required data (modify as needed)
query = '''
    SELECT * from Loan_Approval_Prediction;
'''

# Fetch data from the database into a pandas DataFrame
df = pd.read_sql(query, conn)

# Close the connection
conn.close()

# Display the first few rows of the data
print(df.head())                 # Replace with your SQL Server password

# Replace all null (NaN) values with 0
df.fillna(0, inplace=True)

# Replace all True with 1 and False with 0 in the entire DataFrame
df.replace({True: 1, False: 0}, inplace=True)

# Convert the following columns to integers
columns_to_convert = ['Married', 'Dependents', 'Self_Employed', 'Credit_History', 'Loan_Status']

# Cast the selected columns to integers
df[columns_to_convert] = df[columns_to_convert].astype(int)

# Display the first few rows of the updated DataFrame
print(df.head())

# Check for missing values
print(df.isnull().sum())

# Descriptive statistics of numeric columns
print(df.describe())

# Displaying the shape of the data
print(df.shape)

# checking for duplicate rows
print(df.duplicated().sum())

df.info()

approval_rate = df.groupby('Property_Area')['Credit_History'].mean().reset_index()

# creating bar plot
plt.figure(figsize=(10, 6))
sns.barplot(x='Property_Area', y='Credit_History', data=approval_rate, palette='magma')
plt.title('Loan Approval Rate by Property Area')
plt.xlabel('Property Area')
plt.ylabel('Approval Rate (Credit History)')
plt.show()

#creating scatter plot
plt.figure(figsize=(8, 5))
sns.scatterplot(x='ApplicantIncome', y='LoanAmount', hue='Credit_History', data=df)
plt.title('Applicant Income vs Loan Amount by Credit History')
plt.xlabel('Applicant Income')
plt.ylabel('Loan Amount')
plt.show()

# Count loans by Property Area
df_property_area_counts = df['Property_Area'].value_counts()

# Plot
plt.figure(figsize=(8, 6))
plt.pie(df_property_area_counts, labels=df_property_area_counts.index, autopct='%1.1f%%', startangle=140, colors=['lightcoral', 'skyblue', 'lightgreen'])

# Customize the plot
plt.title('Loan Distribution by Property Area', fontsize=14)
plt.axis('equal')  # Equal aspect ratio ensures the pie is drawn as a circle.

# Show the plot
plt.tight_layout()
plt.show()


#Distribution of Loan Amounts
plt.figure(figsize=(8, 5))
sns.histplot(df['LoanAmount'], kde=True, bins=30, color='cyan')
plt.title('Distribution of Loan Amounts')
plt.xlabel('Loan Amount')
plt.ylabel('Frequency')
plt.show()

# Calculate correlation matrix
correlation = df[['ApplicantIncome', 'LoanAmount', 'Credit_History']].corr()

# Plot
plt.figure(figsize=(8, 6))
sns.heatmap(correlation, annot=True, cmap='BrBG', linewidths=0.5)

# Customize the plot
plt.title('Correlation Heatmap of Loan Data', fontsize=14)

# Show the plot
plt.tight_layout()
plt.show()


# Saving the cleaned data into the chosen folder

# Path to save the cleaned data as a CSV file (you can change the file path)
file_path = 'C:/Users/Admin/Desktop/Capstone Project_Subha Poddar/Cleaned_Loan_Approval_Prediction.csv'

# Export the cleaned DataFrame to CSV
df.to_csv(file_path, index=False)

print(f"Data has been successfully exported to {file_path}")