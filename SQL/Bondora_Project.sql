use Bondora_Project;
go

select top 10 * from bondora_loans

select count(*) as Total_Loans 
from bondora_loans

---------------------------------------------------------- Data Overview ---------------------------------------------------------

-- Total Loans
select COUNT(*) as Total_Loans
from bondora_loans

-- Overview
select count(*) as Total_loans,
count(distinct Country) as Countries,
count (distinct Gender) as Gender,
count(distinct EmploymentStatus) as Employment_Status
from bondora_loans

-- Country-wise Loan Distribution
select Country ,
count(*) as Total_Loans
from bondora_loans 
group by Country
order by Total_Loans desc

-- Average Loan Amount
select avg(AppliedAmount) as Avg_Appiled_Amount,
avg(Amount) as Funded_Amount
from bondora_loans

-- Average Intrest Rate
select avg(Interest) as Avg_Interest
from bondora_loans

----------------------------------------- Borrower Analysis --------------------------------------

-- Age Statistics of Borrowers
select min(age) as Min_Age,
max(age) as Max_Age,
Avg(age) as Avg_Age
from bondora_LOans

-- Borrower Distribution by Gender
select Gender,
count(*) as Total_Borrowers
from bondora_loans
group by gender

-- Borrower Distribution by Employment Status
select EmploymentStatus,
count(*) as Total_Borrowers
from bondora_loans
group by employmentStatus

--  Borrower Distribution by Education Level
select Education,
count(*) as Total_Borrowers
from bondora_loans
group by Education 
order by Total_Borrowers desc

-- Borrower Distribution by Occupation
select OccupationArea,
count(*) as Total_Borrowers
from bondora_loans
group by OccupationArea
order by Total_Borrowers desc

----------------------------------------- Loan Analysis -------------------------------
select * from bondora_loans

-- Loan Amount Statistics
select 
Min(Amount) as Min_Amount,
Max(Amount) as Max_Amount,
Avg(Amount) as Avg_Amount,
Sum(Amount) as Sum_Amount
from bondora_loans

-- Applied Amount vs Funded Amount
Select 
sum(AppliedAmount) as Sum_AppliedAmount,
sum(Amount) as Funded_Amount
from bondora_loans

-- Loan Duration Distribution
Select LoanDuration,
Count(*) as Total_Loans
from bondora_loans
group by LoanDuration
order by Total_Loans desc

-- Interest Rate Analysis
select 
Min(Interest) as Min_Interest,
Max(Interest) as Max_Interest,
Avg(Interest) as Avg_Interest
from bondora_loans

-- Total Funded Amount by Country
select Country,
count(*) as Total_Loans,
sum(Amount) as Total_AMount_Funded
from bondora_loans
group by Country
order by Total_AMount_Funded desc

----------------------------------------- Advanced Loan Analysis ------------------------

-- Average Loan Amount by Country
select Country,
Count(*) as Total_Loans,
Avg(Amount) as Avg_Loan_Amount 
from bondora_loans
group by Country
order by Avg_Loan_Amount desc

-- Average Interest Rate by Country
select Country,
Count(*) as Total_Loans,
Avg(Interest) as Avg_Interest
from bondora_loans
group by Country
order by Avg_Interest desc

-- Loan Amount by Employment Status
select EmploymentStatus,
Count(*) as Total_Borrowers,
Avg(Amount) as Avg_Amount,
sum(Amount) as Total_LoanAmount
from bondora_loans
group by EmploymentStatus
order by Total_LoanAmount desc

-- Loan Amount by Education Level
select Education,
Count(*) as Total_Borrowers,
Sum(Amount) as Total_Amount,
Avg(Amount) as Avg_Amount
from bondora_loans
group by Education
order by Total_Amount

-- Top 10 Highest Loan Amounts
select Top 10 LoanNumber,Country,Amount,Interest,LoanDuration
from bondora_loans
order by Amount desc

------------------------------ Risk Analysis -------------------------------------------
select * from bondora_loans

-- Average Expected Loss by Country
select Country,
Avg(ExpectedLoss) as Avg_Expected_Loss
from bondora_loans
where ExpectedLoss is not Null
Group by Country
order by Avg_Expected_Loss desc

-- Average Probability of Default by Country
select Country,
Avg(ProbabilityofDefault) as Avg_Probability 
from bondora_loans
where ProbabilityOfDefault is not null 
group by Country
order by Avg_Probability desc

-- Risk Analysis by Rating
Select Rating,
Count(*) as Total_Loans,
Avg(ProbabilityofDefault) as Avg_Probability,
Avg(ExpectedLoss) as Avg_Expected_Loss
from bondora_loans
where Rating is not null 
group by Rating

-- Debt to Income Ratio Analysis
Select 
Min(DebttoIncome) as Min_DebttoIncome,
Max(DebttoIncome) as Max_DebttoIncome,
Avg(DebttoIncome) as Avg_DebttoIncome
from bondora_loans
where DebttoIncome is not null

-- Income Analysis
Select 
Min(IncomeTotal) as Min_Income,
Max(IncomeTotal) as Max_Income,
Avg(IncomeTotal) as Avg_Income
from bondora_loans

---------------------------------------- Default Analysis -------------------------

-- Loan Status Distribution
Select status,
count(*) as Total_Loans
from bondora_loans
group by status
order by Total_Loans desc

-- Defaulted Loans by Country
select Country,
count(*) as Defaulted_Loans
from bondora_loans
where DefaultDate is not null 
group by country 
order by Defaulted_Loans desc

-- Default Rate by Rating
select Rating,
count(*) as Defaulted_Loans
from bondora_loans
where DefaultDate is not null 
and Rating is not null
group by Rating 
order by Defaulted_Loans desc

-- Default Rate by Employment Status
select EmploymentStatus,
count(*) as Defaulted_Loans
from bondora_loans
where DefaultDate is not null 
group by EmploymentStatus 
order by Defaulted_Loans desc

-- Average Loan Amount of Defaulted Loans
select Avg(Amount) as Avg_Amount 
from bondora_loans
where DefaultDate is not null

---------------------------------- Financial Analysis --------------------------------
select min(MonthlyPayment) as Min_MonthlyPayment,
max(MonthlyPayment) as Max_MonthlyPayment,
Avg(MonthlyPayment) as Avg_MonthlyPayment
from bondora_loans
where MonthlyPayment is not null

-- Monthly Payment by Country
select Country,
sum(MonthlyPayment) as Total_Monthly_Payment,
avg(MonthlyPayment) as Avg_Monthly_Payment
from bondora_loans
where MonthlyPayment is not null 
group by Country
order by Total_Monthly_Payment desc

-- Expected Return Analysis
select Min(ExpectedReturn) as Minimum_Expected_Return,
Max(ExpectedReturn) as Maximum_Expected_Return,
Avg(ExpectedReturn) As Average_Expected_Return
from bondora_loans
where ExpectedReturn is not null

-- Expected Return by Rating
select Rating,
count(*) as Total_Loans,
avg(ExpectedReturn) as Avg_Expected_Return
from bondora_loans
where Rating is not null and
ExpectedReturn is not null 
group by Rating
order by Avg_Expected_Return

-- Principal Outstanding Analysis
Select Sum(PrincipalPaymentsMade) as Total_Principal_Outstanding,
avg(PrincipalPaymentsMade) as Avg_Principal_Outstanding
from bondora_loans
where PrincipalPaymentsMade is not null

----------------------------------- Advanced SQL Analysis ----------------------------------

-- Rank Countries by Total Loan Amount
select Country,
sum(Amount) as Total_Amount,
Rank() over (order by sum(Amount) desc) as Country_Rnk
from bondora_loans
group by Country

-- Top 5 Borrowers by Loan Amount
select * from (
select LoanNumber,Country,Amount,Interest,
Row_number() over (order by amount desc) as Row_num
from bondora_loans) as RankedLoans where row_num <=5

-- Loan Amount Compared to Country Average
Select LoanNumber,Country,Amount,
Avg(Amount) over(partition by  Country) as Country_Average_Loan
from bondora_loans

-- Country wise Loan Summary Using CTE
with CountrySummary AS
(select
        Country,
        count(*) as Total_Loans,
        sum(Amount) as Total_Amount,
        avg(Amount) as Average_Amount
    from bondora_loans
    group by Country)
select *
from CountrySummary
order by Total_Amount desc

---------------------------------------- Views ------------------------------------

-- Loan Overview
create view Viwe_Loan_Overview as
select 
LoanNumber,LoanDate,Country,
Amount,Appliedamount,Interest,LoanDuration,Status  
from bondora_loans

-- Borrower Analysis
Create view view_BorrowerAnalysis as
select
    LoanNumber,
    Age,
    Gender,
    Education,
    EmploymentStatus,
    OccupationArea,
    IncomeTotal
from bondora_loans

-- Risk Analysis
Create view view_RiskAnalysis as
select 
    LoanNumber,
    Rating,
    ExpectedLoss,
    ProbabilityOfDefault,
    DebtToIncome
from bondora_loans

-- Financial Analysis
Create view view_FinancialAnalysis as
select
    LoanNumber,
    MonthlyPayment,
    PrincipalPaymentsMade,
    InterestAndPenaltyPaymentsMade,
    ExpectedReturn
from bondora_loans

select OccupationArea , count(*)
from bondora_loans
group by OccupationArea