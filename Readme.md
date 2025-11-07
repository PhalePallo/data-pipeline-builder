# 📊 **Data Pipeline Builder – SQL & ETL**

## **Project Overview**

This project demonstrates a **complete data engineering workflow** including **database setup**, **ETL pipeline development**, **cloud storage integration**, and **data visualization**.

We selected an open dataset, imported it into **Azure SQL Database**, processed it through an **ETL pipeline**, and stored **raw and processed datasets securely in Azure Blob Storage**. This project showcases **SQL proficiency, Python ETL skills, cloud management, and collaborative teamwork**.

---

## **Team & Roles**

| **Role**                  | **Name**       | **Responsibilities**                                                              |
| -------------------------- | -------------- | --------------------------------------------------------------------------------- |
| **SQL Lead**               | [Lethabo]      | Database design, queries, joins, aggregations, subqueries                         |
| **ETL Developer**          | [Lesego]       | Build ETL pipeline, data cleaning, transformation, logging                        |
| **Cloud & Storage Engineer** | [Pallo]      | Azure provisioning, storage setup, database setup, access management              |
| **Dashboard Lead**         | [Thoriso]      | Build interactive dashboards using Streamlit, display pipeline metrics & insights |

---

## **Project Architecture**

**Workflow:**

Raw Data (CSV) → Azure Blob Storage (raw-data)
↓ Extract via ETL
↓ Transform & Clean (Python / pandas)
↓ Load → Azure SQL Database (projectdb)
↓ Optional: Processed data in Blob Storage (processed-data)
↓ Optional: Curated data → Dashboard (Streamlit)


---

## **Azure Setup**

### **Resource Group**
- **Name:** `data-pipeline-rg`  
- **Region:** South Africa North

### **Storage Account**
- **Name:** `projectdatastore`  
- **Containers:**
  - `raw-data` → Original CSV datasets (**private**)  
  - `processed-data` → ETL outputs (**private**)  
  - `curated-data` → Optional final outputs  

- **Redundancy:** Locally Redundant Storage (LRS)  
- **Security:** Secure transfer required, private access, SAS keys for credentials

### **Azure SQL Database**
- **Server:** `project-sql-server-sa.database.windows.net`  
- **Database:** `projectdb`  
- **Login for SQL Lead:** `sql_lead` (**read/write access**)  
- **Firewall:** Client IPs added for team members  
- **Database Tables:** Imported from CSV via **Flat File Import Wizard**

---

## **Data Access**

**Connection Details for SQL Lead**

| **Item**           | **Value / Instruction**                                     |
| ------------------ | ------------------------------------------------------------ |
| **Server**         | `project-sql-server-sa.database.windows.net`                |
| **Database**       | `projectdb`                                                 |
| **Username**       | `sql_lead`                                                  |
| **Password**       | `<strong password set>`                                     |
| **Authentication** | SQL Login                                                   |
| **Port**           | 1433 (default)                                             |

> **Note:** Ensure your **public IP** is added under **SQL Server → Networking → Firewall rules**.

---

## **Blob Storage Access**

- Raw CSVs and processed datasets are stored in **Azure Blob Storage**  
- Access via **Azure Portal**, **SAS**, or programmatically using **Python / Azure SDK**

---

## **ETL Pipeline**

### **ETL Developer Responsibilities**
- **Extract:** Read CSVs from `raw-data` container  
- **Transform:** Clean, validate, and apply business logic (**Python / pandas**)  
- **Load:** Write processed data into **projectdb** or `processed-data` container  
- **Logging:** Track pipeline execution & errors

---

## **SQL Analysis**

### **SQL Lead Responsibilities**
- Create **schema** and relationships for imported tables  
- Write queries using:  
  - **Joins:** INNER, LEFT, RIGHT  
  - **Aggregations:** COUNT, SUM, AVG, GROUP BY, HAVING  
  - **Subqueries / CTEs**  
- Perform **CRUD operations**  
- Validate data quality and ensure **ETL load correctness**

---

## **Dashboard & Visualization**

### **Dashboard Lead Responsibilities**
- Build **Streamlit app** to visualize processed data  
- Show metrics such as:
  - Total records processed  
  - Aggregated KPIs (e.g., sales, revenue, counts)  
  - ETL pipeline status and errors  
- Optional: Deploy dashboard to **Azure App Service**

---

## **Project Deliverables**

- **GitHub Repository:** Full project code and structure
  - `sql/` → Database schema, queries, and analysis  
  - `etl/` → Python ETL pipeline, logs  
  - `requirements.txt` → Python dependencies  
  - `README.md` → Project documentation  
  - `slides/` → PDF slides for presentation  
- **Azure Resources:** Configured SQL Database and Blob Storage  
- **Data:** Raw CSVs, processed outputs, and curated datasets  
- **Presentation:** Architecture diagram, SQL insights, ETL flow, dashboard screenshots

---

## **Best Practices & Notes**

- **Security:** Credentials are stored safely in `.env` (placeholders in repo). **Never commit secrets**.  
- **Version Control:** GitHub used for **team collaboration, code management, and issue tracking**.  
- **Reproducibility:** CSVs in Blob Storage + ETL scripts ensure the pipeline can run **end-to-end**.  
- **Team Collaboration:** Each member knows their role; **GitHub Issues track tasks**.
