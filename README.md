# Capstone_Project_Data_Analytics(Loan_Approval_Prediction_Analysis)

### Project Overview

This project focuses on loan prediction by processing, analyzing, and visualizing a dataset through SQL, Python, and Power BI. The workflow consists of database normalization, data cleaning, visualization, and report generation, aiming to predict loan approval based on applicant information.

### Dataset Description

The dataset, sourced from [Kaggle](https://www.kaggle.com/datasets/altruistdelhite04/loan-prediction-problem-dataset), contains information about loan applicants, including their demographic and financial details, loan amounts, and approval status. The key features include:
- **Loan_ID**: Unique identifier for each loan.
- **Gender**: Applicant's gender.
- **Married**: Marital status of the applicant.
- **Dependents**: Number of dependents.
- **Education**: Education level of the applicant.
- **Self_Employed**: Employment status.
- **LoanAmount**: Loan amount requested.
- **Loan_Amount_Term**: Term of the loan in months.
- **Credit_History**: Credit history of the applicant.
- **Property_Area**: Type of property area.
- **Loan_Status**: Status of loan approval (Y or N).

### Objective

The primary objective of this project is to predict whether a loan will be approved or not, based on the applicant's information. This involves:
1. Normalizing the dataset and storing it in a relational database.
2. Cleaning the data for inconsistencies or missing values.
3. Visualizing key trends and patterns to aid in understanding loan approval factors.
4. Creating an interactive dashboard to present the results.

### Workflow

1. **Data Normalization & SQL Queries (MS SQL Server)- Platform: MS SQL Server**:
   - The dataset was imported into MS SQL Server and normalized into tables such as `Applicant`, `Loan`, `Income`, and `Property`.
   - An entity-relationship diagram was created, and foreign keys were added to establish relationships.
   - Multiple SQL queries were executed for data retrieval and analysis.

2. **Data Cleaning & Visualization (Python)- Platform: Visual Studio Code**:
   - Data was fetched from SQL Server using `Pyodbc`.
   - Cleaning steps involved handling missing data and correcting inconsistencies.
   - Visualizations were created using `matplotlib`, and `Seaborn` to analyze relationships between variables like income, loan amount, and credit history.

3. **Report & Dashboard Creation (Power BI)- Platform: Power BI**:
   - Cleaned data was imported into Power BI for interactive reporting.
   - DAX functions and measures were created to calculate metrics like Total loan amount, Total Income and so on.
   - Visualizations included bar charts, line graphs, and AI-based visuals (Key Influencers) to understand the factors influencing loan approval.
   - Custom navigation, tooltips, and slicers were used to enhance the user experience in the dashboard.

### Key Insights

- **Credit History**: Applicants with a positive credit history were significantly more likely to have their loans approved.
- **Income**: Higher applicant and co-applicant incomes positively impacted loan approval chances.
- **Property Area**: Semi-urban property areas saw a higher rate of loan approval compared to Rural and Urban areas.
- **Loan Amount**: Extremely high loan amounts correlated with lower approval rates, likely due to increased risk for lenders.

### Conclusion

This project successfully demonstrates how loan approval can be predicted using a combination of SQL, Python, and Power BI. By cleaning, normalizing, and visualizing the data, key patterns and trends were identified, providing valuable insights into factors that influence loan approvals. The interactive Power BI dashboard allows users to explore these insights dynamically, helping stakeholders make informed decisions based on data-driven results.
