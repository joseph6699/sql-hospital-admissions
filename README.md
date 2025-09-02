# 🏥 Hospital Admissions & Patient Flow Database

## 📖 Project Overview
This project presents a SQL Server relational database built to model hospital admissions and patient flow management. It demonstrates the full cycle of database design and implementation, including:

Schema design and normalization to ensure data integrity, Advanced SQL queries (joins, subqueries, CTEs, window functions) for analysis and reporting, Stored procedures for automated operations such as patient admissions and discharge updates, Triggers to enforce business rules and maintain consistency in healthcare records. The project showcases how structured SQL solutions can improve operational efficiency, patient tracking, and data-driven decision-making in a healthcare context  

The project models key entities:
- Patients  
- Doctors  
- Wards  
- Admissions  
- Medications  
- Test Results  

It includes **sample synthetic data** and showcases **analytics queries** relevant to healthcare (e.g., bed occupancy, readmission risk, length of stay, busiest doctors).

---

## 📂 Deliverables
- **`schema.sql`** → database schema with tables, relationships, and constraints  
- **`sample_data.sql`** → synthetic dataset for patients, doctors, admissions, medications, and test results  
- **`queries.sql`** → advanced SQL examples (joins, CTEs, window functions, aggregations)  
- **`procedures_triggers.sql`** → stored procedures for readmission risk & ward occupancy, trigger for capacity enforcement  
- **`README.md`** → project documentation  

---

## 🗂️ Database Schema (ERD)

```mermaid
erDiagram
    Patients ||--o{ Admissions : "has"
    Doctors ||--o{ Admissions : "attends"
    Wards ||--o{ Admissions : "hosts"
    Admissions ||--o{ Medications : "prescribes"
    Admissions ||--o{ TestResults : "produces"

    Patients {
        int PatientID PK
        string FirstName
        string LastName
        date DateOfBirth
        char Gender
    }

    Doctors {
        int DoctorID PK
        string FirstName
        string LastName
        string Specialty
    }

    Wards {
        int WardID PK
        string WardName
        int Capacity
    }

    Admissions {
        int AdmissionID PK
        int PatientID FK
        int DoctorID FK
        int WardID FK
        string MedicalCondition
        date AdmissionDate
        date DischargeDate
        string AdmissionType
    }

    Medications {
        int MedicationID PK
        int AdmissionID FK
        string MedicationName
        string Dosage
        string Frequency
    }

    TestResults {
        int TestID PK
        int AdmissionID FK
        string TestName
        string Result
        date TestDate
    }

How to Run

Clone this repository:

git clone https://github.com/joseph6699/sql-hospital-admissions.git
cd sql-hospital-admissions


Run the scripts in SQL Server Management Studio (SSMS) in this order:

schema.sql
sample_data.sql
queries.sql
procedures_triggers.sql

Explore the queries and stored procedures:

-- Example: Get busiest doctors
EXEC healthcare_admissions.GetWardOccupancy @WardID = 1;

-- Example: Check patient readmission risk
EXEC healthcare_admissions.GetPatientReadmissionRisk @PatientID = 1;

🔍 Example Insights
Average length of stay per ward
Readmission rates per patient
Top 3 busiest doctors
Rolling 7-day admission trends
Real-time ward occupancy vs. capacity

🛠️ Technologies

Microsoft SQL Server (T-SQL)
ERD (Entity-Relationship Modeling)
Stored Procedures & Triggers
Window Functions, CTEs, Joins, Aggregations

📌 Author
Name: Joseph Ekpendu
LinkedIn: linkedin.com/in/joseph-ekpendu-16613884
Git: https://github.com/joseph6699
MSc Data Science & Artificial Intelligence, Edge Hill University


---

### ✅ What this README gives you
- A **professional GitHub landing page** with overview, ERD diagram, and instructions.  
- Clean explanation of deliverables.  
- Shows recruiters exactly which SQL skills you’re demonstrating.  

---

👉 Next step: you can **create a new GitHub repo** (e.g., `sql-hospital-admissions`), drop in all 5 deliverables, and commit.  

Would you like me to also draft a **short CV entry** for this project (1–2 lines) that you can paste directly under *Projects* in your CV?



























