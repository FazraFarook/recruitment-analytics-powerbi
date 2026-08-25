# 📊 HR Recruitment Analytics Dashboard
### Advanced Power BI Assignment | University of Colombo — BSc Applied Statistics

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-FF6B6B?style=for-the-badge)
![Star Schema](https://img.shields.io/badge/Star%20Schema-6B48FF?style=for-the-badge)

---

## 📌 Project Overview

This project is an end-to-end **HR Recruitment Analytics Dashboard** built using **MySQL** as the data source and **Microsoft Power BI** as the reporting tool. It was developed as part of the Advanced Power BI assignment for the MiHCM University Session under the ST4035 Data Science module.

The dashboard analyzes a simulated recruitment pipeline across **8 departments**, **15 job positions**, and **8 hiring channels**, covering **91 applicant records** from January 2023 to June 2024.

---

## ❓ Business Problem

> *"How efficient is our hiring process? Which departments struggle to fill roles, and where do candidates drop off in the recruitment pipeline?"*

---

## 🎯 Key Insights

| Metric | Value |
|--------|-------|
| Total Applications | 91 |
| Total Hired | 25 |
| Overall Hire Rate | 27.5% |
| Average Days to Hire | 32 days |
| Top Hiring Department | Engineering |
| Top Recruitment Source | LinkedIn (20.88%) |
| Offer Acceptance Rate | ~63% |

---

## 🗂️ Project Structure

```
recruitment-analytics/
│
├── 📄 README.md
├── 📄 recruitment_analytics.sql       ← Full MySQL script
├── 📊 PBI_Dashboard_recruitment.pbix  ← Power BI dashboard file
└── 📁 screenshots/
    ├── cover_page.png
    ├── page1_overview.png
    └── page2_department_analysis.png
```

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| MySQL / phpMyAdmin | Database creation, data insertion, SQL queries |
| Power BI Desktop | Data modeling, DAX measures, dashboard |
| ODBC Connector | MySQL → Power BI connection |
| DAX | Calculated columns and measures |

---

## 🗄️ Database Design

### Star Schema

```
                    ┌─────────────────┐
                    │   DateTable     │
                    │  (DAX created)  │
                    └────────┬────────┘
                             │
┌──────────────┐    ┌────────▼────────┐    ┌──────────────────┐
│dim_department│◄───│fact_recruitment │───►│ dim_job_position │
└──────────────┘    └────────┬────────┘    └──────────────────┘
                             │
                    ┌────────▼────────┐
                    │dim_recruitment  │
                    │    _source      │
                    └─────────────────┘
```

### Tables

| Table | Type | Rows | Description |
|-------|------|------|-------------|
| `fact_recruitment` | Fact | 91 | Core applicant records |
| `dim_department` | Dimension | 8 | Department details |
| `dim_job_position` | Dimension | 15 | Job roles and levels |
| `dim_recruitment_source` | Dimension | 8 | Hiring channels |
| `DateTable` | Date | 730 | DAX-generated calendar |

---

## 📐 DAX Measures (15 Total)

### Volume Measures
```dax
Total Applications = COUNTROWS(fact_recruitment)
Total Hired = CALCULATE(COUNTROWS(fact_recruitment), fact_recruitment[current_stage] = "Hired")
Total Rejected = CALCULATE(COUNTROWS(fact_recruitment), fact_recruitment[current_stage] = "Rejected")
Total Withdrawn = CALCULATE(COUNTROWS(fact_recruitment), fact_recruitment[current_stage] = "Withdrawn")
Total In Pipeline = CALCULATE(COUNTROWS(fact_recruitment), fact_recruitment[current_stage] IN {"Applied","Screened","Interviewed","Offered"})
```

### Rate Measures
```dax
Hire Rate % = ROUND(DIVIDE([Total Hired], [Total Applications], 0) * 100, 1)
Rejection Rate % = DIVIDE([Total Rejected], [Total Applications], 0) * 100
Withdrawal Rate % = DIVIDE([Total Withdrawn], [Total Applications], 0) * 100
```

### Time Measures
```dax
Avg Days to Hire = 
ROUND(AVERAGEX(
    FILTER(fact_recruitment, fact_recruitment[current_stage] = "Hired"),
    DATEDIFF(fact_recruitment[application_date], fact_recruitment[joining_date], DAY)), 0)

Avg Days to Offer = 
AVERAGEX(
    FILTER(fact_recruitment, fact_recruitment[offer_date] <> BLANK()),
    DATEDIFF(fact_recruitment[application_date], fact_recruitment[offer_date], DAY))
```

### Offer Measures
```dax
Offer Acceptance Rate % = DIVIDE([Total Hired], [Total Hired] + [Total Withdrawn], 0) * 100

Avg Salary Variance = 
AVERAGEX(
    FILTER(fact_recruitment, fact_recruitment[current_stage] = "Hired"),
    fact_recruitment[offered_salary_lkr] - fact_recruitment[expected_salary_lkr])
```

### Trend Measure
```dax
MoM Application Growth % = 
VAR CurrentMonth = CALCULATE([Total Applications], DATESMTD(DateTable[Date]))
VAR LastMonth = CALCULATE([Total Applications], DATEADD(DateTable[Date], -1, MONTH))
RETURN DIVIDE(CurrentMonth - LastMonth, LastMonth, 0) * 100
```

---

## 📊 Dashboard Pages

### Page 1 — Recruitment Overview
- 4 slicers (Year, Department, Job Level, Source Type)
- 5 KPI cards (Total Applications, Total Hired, Hire Rate %, Avg Days to Hire, In Pipeline)
- Line chart — Monthly application trend with drill-down
- Funnel chart — Recruitment pipeline stages
- Donut chart — Applications by source type
- Bar chart — Hires by department with conditional formatting

### Page 2 — Department Analysis (Drill-Through)
- 4 department-specific KPI cards
- Stacked bar chart with drill-down (Job Level → Position Title)
- Donut chart — Rejection reasons breakdown
- Table — Applicant details with conditional formatting
- Scatter chart — Experience vs Expected Salary

### Cover Page
- Project title and description
- Navigation buttons to each page

---

## ⚙️ Advanced Features Implemented

| Feature | Where Used |
|---------|-----------|
| ✅ Drill-through | Page 1 → Page 2 via department bar chart |
| ✅ Drill-down | Job Level → Position Title on Page 2 stacked bar |
| ✅ Conditional formatting | Bar chart gradient, table background colors |
| ✅ Tooltips | Bar chart, line chart, donut chart, scatter chart |
| ✅ Slicers | 4 slicers on Page 1 |
| ✅ Navigation buttons | Cover page and cross-page navigation |
| ✅ Star schema | 5-table model in Model view |
| ✅ Date table | DAX-generated with Year, Quarter, Month hierarchy |
| ✅ Calculated columns | Age Group, Salary Band, YearMonth |

---

## 🚀 How to Run This Project

### Prerequisites
- MySQL / phpMyAdmin (XAMPP recommended)
- Power BI Desktop (latest version)
- MySQL ODBC Connector 9.7+

### Step 1 — Set Up the Database
```sql
-- Run the full SQL script in phpMyAdmin
-- File: recruitment_analytics.sql
```

1. Open phpMyAdmin
2. Go to SQL tab
3. Paste and run `recruitment_analytics.sql`
4. Verify 4 tables created with correct row counts

### Step 2 — Set Up ODBC Connection
1. Open **ODBC Data Sources (64-bit)** on Windows
2. Add new System DSN → MySQL ODBC 9.7 Unicode Driver
3. Configure:
   - Data Source Name: `RecruitmentDB`
   - Server: `localhost`
   - Database: `recruitment_analytics`
   - User: `root`

### Step 3 — Open Power BI Dashboard
1. Open `PBI_Dashboard_recruitment.pbix`
2. If prompted to refresh → ensure XAMPP MySQL is running
3. Click **Refresh** to load latest data

---

## 📋 SQL Queries Included

The SQL script includes queries for:
- ✅ Data validation (count per stage, duplicates check)
- ✅ Data aggregation (monthly trends, department counts)
- ✅ Data joins (full applicant detail view across all tables)
- ✅ Recruitment funnel calculation (cumulative stage counts)
- ✅ Source effectiveness analysis (applications vs hires per source)

---

## ⚠️ Data Note

This project uses a **synthetic dataset** designed to simulate real-world HR recruitment scenarios. All applicant names, salary figures, and dates are fictional. The dataset was purpose-built to demonstrate the full range of Power BI analytics features required by the assignment.

---

## 👤 Author

**Fazra Farook**
BSc (Hons) Applied Statistics — University of Colombo
Student ID: S16686

---

## 📚 Module Information

| Detail | Info |
|--------|------|
| Module | ST4035 — Data Science |
| Assignment | Advanced Power BI HR Analytics |
| Session | MiHCM University Session |
| Year | 2024 |

---

## 📄 License

This project is for academic purposes only. Dataset is synthetic and does not represent any real organization or individual.
