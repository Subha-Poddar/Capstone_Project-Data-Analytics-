use db_capstone
go

select * from dbo.Loan_Approval_Prediction

--Initiating Data Normalization
--creating applicant table
CREATE TABLE Applicant (
    ApplicantID INT IDENTITY(1,1) PRIMARY KEY,
    Loan_ID VARCHAR(50) UNIQUE NOT NULL,
    Gender VARCHAR(10),
    Married VARCHAR(10),
    Dependents VARCHAR(10),
    Education VARCHAR(50),
    Self_Employed VARCHAR(10)
);

--creating loan table
CREATE TABLE Loan (
    Loan_ID VARCHAR(50) PRIMARY KEY,
    LoanAmount DECIMAL(10, 2),
    Loan_Amount_Term INT,
    Loan_Status VARCHAR(10),
    Credit_History BIT
);


--creating income table
CREATE TABLE Income (
    IncomeID INT IDENTITY(1,1) PRIMARY KEY,
    Loan_ID VARCHAR(50) FOREIGN KEY REFERENCES Loan(Loan_ID),
    ApplicantIncome DECIMAL(10, 2),
    CoapplicantIncome DECIMAL(10, 2)
);

--creating property table
CREATE TABLE Property (
    PropertyID INT IDENTITY(1,1) PRIMARY KEY,
    Loan_ID VARCHAR(50) FOREIGN KEY REFERENCES Loan(Loan_ID),
    Property_Area VARCHAR(50)
);

-- Insert into Applicant Table
INSERT INTO Applicant (Loan_ID, Gender, Married, Dependents, Education, Self_Employed)
SELECT Loan_ID, Gender, Married, Dependents, Education, Self_Employed
FROM Loan_Approval_Prediction;

-- Insert into Loan Table
INSERT INTO Loan (Loan_ID, LoanAmount, Loan_Amount_Term, Loan_Status, Credit_History)
SELECT Loan_ID, LoanAmount, Loan_Amount_Term, Loan_Status, Credit_History
FROM Loan_Approval_Prediction;

-- Insert into Income Table
INSERT INTO Income (Loan_ID, ApplicantIncome, CoapplicantIncome)
SELECT Loan_ID, ApplicantIncome, CoapplicantIncome
FROM Loan_Approval_Prediction;

-- Insert into Property Table
INSERT INTO Property (Loan_ID, Property_Area)
SELECT Loan_ID, Property_Area
FROM Loan_Approval_Prediction;

--Adding Foreign Key to Applicant table
ALTER TABLE Applicant
ADD CONSTRAINT FK_Applicant_Loan
FOREIGN KEY (Loan_ID) REFERENCES Loan(Loan_ID);

--Retriving the data from Each table
Select * from Applicant
Select * from Income
Select * from Loan
Select * from Property

--Query 1. Finding the Total Loan Amount for Each Property Area
select p.Property_Area,sum(l.LoanAmount) as Total_Loan_Amount
from Property as p
left join Loan as l
on p.Loan_ID = l.Loan_ID
group by p.Property_Area
order by sum(l.LoanAmount)

--Query 2. Average Loan Amount Based on Education and Employment Status
select a.Education, a.Self_Employed, Avg(l.LoanAmount) as Average_Loan_Amount
from Applicant as a
left join Loan as l
on  a.Loan_ID = l.Loan_ID
where a.Self_Employed is not null
group by a.Education, a.Self_Employed
order by Average_Loan_Amount desc

--Query 3. Retrieve Approved Loans for Applicants with Income Greater than the Average Income

select a.ApplicantID, i.ApplicantIncome, l.Loan_Status, l.LoanAmount
from Applicant as a
left join Income as i
on a.Loan_ID = i.Loan_ID
left join Loan as l
on a.Loan_ID = l.Loan_ID
where i.ApplicantIncome > (select avg(ApplicantIncome) from Income)
and l.Loan_Status = 1
order by i.ApplicantIncome desc;

--Query 4: Finding highest Applicant Based on Their Loan Amount

with ranked_loan_amount as(select a.ApplicantID, l.LoanAmount, DENSE_RANK() over (order by l.LoanAmount desc) as Loan_amount_rank
from Applicant as a
left join Loan as l
on a.Loan_ID = l.Loan_ID)
select * from ranked_loan_amount where Loan_amount_rank = 1;

--Query 5: top 5 applicants with the lowest credit history, ordered by loan amount, who were still approved for a loan.

select top 5 a.ApplicantID, a.Gender,a.Married,l.Credit_History, l.LoanAmount
from Applicant as a
left join Loan as l
on a.Loan_ID = l.Loan_ID
where l.Loan_Status = 1
and l.Credit_History = 0
order by l.LoanAmount desc;

--Query 6: Calculate Cumulative Loan Amount for Each Applicant (Using Window Function)

select a.ApplicantID, i.ApplicantIncome, sum(l.LoanAmount) over (order by i.ApplicantIncome) as Cumulative_Loan_Amount
from Applicant a
left join Income i
on a.Loan_ID = i.Loan_ID
left join Loan l
on a.Loan_ID = l.Loan_ID
order by i.ApplicantIncome;



select @@ServerName

select * from Loan_Approval_Prediction








