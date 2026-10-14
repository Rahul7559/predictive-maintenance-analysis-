# predictive-maintenance-analysis-
Predictive maintenance analysis using Python, SQL Server, machine learning, and Power BI.

# Predictive Maintenance Analysis

## 📌 Overview

This project focuses on analyzing machine performance data to identify patterns associated with machine failures and support predictive maintenance decisions.

The project follows an end-to-end data analytics workflow, including data loading, Exploratory Data Analysis (EDA), data cleaning, SQL analysis, machine learning, and interactive dashboard development using Power BI.

The goal is to identify important factors associated with machine failures and present actionable insights through data visualization and reporting.

## 🎯 Project Objectives

- Analyze machine performance and operational data.
- Perform EDA to understand data distributions and patterns.
- Clean and preprocess data for accurate analysis.
- Use SQL queries to extract meaningful business insights.
- Apply a Random Forest model to analyze machine failure patterns.
- Develop an interactive Power BI dashboard.
- Present findings through a project report and presentation.

## 📂 Dataset

The dataset contains machine operational information and failure indicators.

**Key columns include:**
- Air Temperature
- Process Temperature
- Rotational Speed
- Torque
- Tool Wear
- Machine Type
- Machine Failure

The dataset is used to explore relationships between machine operating conditions and failure events.


## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| Python | Data analysis and preprocessing |
| Pandas & NumPy | Data manipulation |
| Matplotlib & Seaborn | Data visualization |
| Scikit-learn | Random Forest model |
| SQL Server | Data querying and analysis |
| PostgreSQL / MySQL | Alternative SQL database platforms |
| Power BI | Interactive dashboard development |
| Gamma | Presentation creation |
| Jupyter Notebook | Python development environment |
| GitHub | Project documentation and version control |


## 🔄 Project Workflow

### 1. Data Loading
- Imported the dataset into Python using Pandas.
- Reviewed the dataset structure, columns, and data types.

### 2. Exploratory Data Analysis (EDA)
- Examined dataset dimensions and statistical summaries.
- Analyzed machine failures and operational variables.
- Created visualizations to identify trends, distributions, and relationships.

### 3. Data Cleaning & Feature Engineering
- Checked for missing values and duplicate records.
- Reviewed data types and prepared data for analysis.
- Created additional features, including:
  - Temperature Difference
  - Power Proxy
- Encoded categorical variables where required.

### 4. SQL Analysis
- Queried the data using SQL Server.
- Used filtering, aggregation, grouping, joins, and other SQL operations where applicable.
- Analyzed failure counts, failure rates, machine types, and operational patterns.

### 5. Machine Learning
- Prepared the relevant features for model training.
- Trained a Random Forest model to analyze machine failure patterns.
- Examined feature importance to identify variables contributing to model predictions.

### 6. Power BI Dashboard
- Connected the prepared data to Power BI.
- Created KPI cards, charts, and interactive filters.
- Designed a dashboard to communicate key findings clearly.

### 7. Reporting & Presentation
- Prepared a project report documenting the methodology and findings.
- Created a presentation using Gamma to communicate the project workflow, analysis, and conclusions.

## 📊 Power BI Dashboard

The dashboard includes the following KPIs and visualizations:

**Key Performance Indicators (KPIs)**
- Total Machines
- Total Failures
- Failure Rate
- Average Tool Wear

**Visualizations**
- Temperature Analysis
- Torque vs. Rotational Speed
- Failure Type Analysis
- Failure by Tool Wear Band
- Failure by Machine Type

These visuals help users explore machine operating conditions and understand how failure patterns vary across different categories.

<img width="1190" height="660" alt="image" src="https://github.com/user-attachments/assets/231c2b14-ce23-4e2d-9180-3cd3b0afe8c8" />

Example:

`![Predictive Maintenance Dashboard]<img width="1190" height="660" alt="image" src="https://github.com/user-attachments/assets/b72c05b5-492b-49d1-943b-37bb2054debf" />


## 📈 Results & Insights

The analysis and modeling workflow helps investigate the relationship between machine operating conditions and failure events.

Key areas of investigation include:

- The relationship between rotational speed, torque, and machine failures.
- The impact of tool wear on failure patterns.
- Differences in failure patterns across machine types.
- The importance of operational features in Random Forest predictions.
- The use of interactive visualizations to support maintenance-related analysis.

The Random Forest feature-importance analysis highlighted rotational speed, tool wear, and torque among the important features in the model.

*Add verified numerical results, model evaluation metrics, and specific findings from your completed analysis here. Feature importance indicates predictive contribution, not necessarily causation.*

## 📁 Project Structure

```text
predictive-maintenance-analysis/
│
├── data/
│   └── README.md
│
├── notebooks/
│   └── predictive_maintenance_analysis.ipynb
│
├── sql/
│   └── analysis_queries.sql
│
├── powerbi/
│   └── predictive_maintenance_dashboard.pbix
│
├── images/
│   └── dashboard.png
│
├── reports/
│   └── project_report.pdf
│
├── presentation/
│   └── project_presentation.pptx
│
├── requirements.txt
└── README.md
```


## ▶️ How to Run

### Prerequisites
- Python 3.x
- Jupyter Notebook
- SQL Server or another supported SQL database
- Power BI Desktop

### Step 1: Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/predictive-maintenance-analysis.git
cd predictive-maintenance-analysis
```

Replace `YOUR-USERNAME` with your GitHub username.

### Step 2: Install Dependencies

```bash
pip install pandas numpy matplotlib seaborn scikit-learn jupyter
```

### Step 3: Run the Python Notebook

```bash
jupyter notebook
```

Open the predictive maintenance notebook and execute the cells in order.

### Step 4: Run the SQL Queries

- Set up the database using your SQL platform.
- Import the dataset or prepared data.
- Open the SQL script in your database client.
- Update table names and execute the queries.

### Step 5: Open the Power BI Dashboard

Open the `.pbix` file in Power BI Desktop. If prompted, update the data source settings to match your environment.

## 🚀 Future Improvements

- Evaluate the model using precision, recall, F1-score, and ROC-AUC where appropriate.
- Tune model hyperparameters and compare alternative algorithms.
- Add time-based analysis if historical machine data becomes available.
- Develop automated monitoring and maintenance alerts.
- Deploy the model through an application or API.

## 👤 Author

Rahul Mangale
Aspiring Data Analyst

Skills: Python | SQL | Power BI | Data Cleaning | EDA | Machine Learning | Data Visualization

## 📄 License

This project is intended for educational and portfolio purposes. Add an appropriate license if you want others to reuse or distribute your work.
