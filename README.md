## Hospital Management System (HMS) — Relational Database Design, Implementation & Analytics

An enterprise-grade relational database design and analytical interrogation system built for a **Hospital Management System (HMS)** using **MySQL Workbench**. This repository covers end-to-end database engineering practices including schema normalisation (3NF), relational views, analytical queries, distributed CAP theorem trade-off analysis, and SQL query performance optimization.

---

##  Project Overview & Architecture

Managing clinical and administrative healthcare data demands zero compromise on data integrity, traceability, and operational efficiency. This project implements an 8-table relational schema designed to eliminate anomalies and support complex clinical/financial analytics.

### Tech Stack & Tools
- **Database Engine:** MySQL 8.0
- **Design & GUI Tool:** MySQL Workbench
- **Modeling Standards:** Third Normal Form (3NF), Foreign Key Constraints & Referential Integrity

---

##  Relational Schema & Entity Relationship Diagram (ERD)

The database consists of **8 interconnected tables**:
1. `Department` — Hospital departments & locations
2. `Doctor` — Clinician profiles & department mapping
3. `Patient` — Patient demographics
4. `Appointment` — Junction table mediating Patient-Doctor appointments
5. `MedicalRecord` — Patient clinical diagnostic logs
6. `Medication` — Pharmaceutical inventory & pricing
7. `Prescription` — Junction table linking Medical Records to Medications
8. `Billing` — Patient financial transactions and payment statuses

### 3NF Normalisation Highlights
- **Decomposition:** Split transitive dependencies where `dept_name`, `dept_location`, and `dept_phone` were originally tied directly to `Doctor`.
- **Result:** Created a dedicated `Department` table to eliminate update, insertion, and deletion anomalies.

---

##  Repository Structure & Code Files

This repository contains all raw SQL scripts used to construct and query the system:

- **[`schema.sql`](./schema.sql)** — Complete DDL scripts for table creation, primary keys, AUTO_INCREMENT, and foreign key constraints.
- **[`sample_data.sql`](./sample_data.sql)** — DML scripts inserting realistic clinical/financial sample data across all 8 tables.
- **[`views.sql`](./views.sql)** — DDL for reusable database views (`vw_doctor_appointment_summary` & `vw_monthly_billing_trend`).
- **[`analytical_queries.sql`](./analytical_queries.sql)** — Advanced analytical SQL queries utilizing multi-table `JOIN`s, `CASE` classification statements, and `RANK()` window functions.
- **[`query_optimization.sql`](./query_optimization.sql)** — Performance optimization comparison refactoring an $O(n)$ correlated subquery into a single-pass `JOIN` + `GROUP BY` + `HAVING` aggregation supported by a B-Tree index (`idx_billing_patient`).

---

##  Analytical Views & Advanced SQL Highlights

### 1. Reusable Database Views
- `vw_doctor_appointment_summary`: Aggregates clinician consultation workloads for staff planning.
- `vw_monthly_billing_trend`: Tracks total charged vs. collected revenue for Revenue Cycle Management (RCM).

### 2. Advanced Queries Included
- **JOIN + GROUP BY:** Identifies top clinicians by distinct patient consultation volume (`COUNT(DISTINCT)`).
- **CASE Logic:** Categorises patients into financial compliance profiles (`Fully Paid`, `Partial Payer`, `Low Payer`).
- **Window Functions:** Ranks clinicians by revenue contribution within each department using `RANK() OVER (PARTITION BY dept_name ORDER BY SUM(...) DESC)`.

---

## Query Performance Optimisation

- **Problem:** Initial query calculating high-value patients used a correlated subquery, causing $O(n)$ row-by-row execution and repeated full table scans.
- **Solution:** 
  1. Created a B-Tree index on foreign key `idx_billing_patient` on `Billing(patient_id)`.
  2. Refactored correlated subquery into a `JOIN` with `GROUP BY` and `HAVING` aggregation.
- **Impact:** Transformed execution into a single-pass index-backed query built for production-scale volumes.

---

##  Distributed Systems Architecture (CAP Theorem)

Applied Brewer's CAP Theorem to evaluate the HMS distributed architecture:
- **Selected System:** **CP (Consistency + Partition Tolerance)**.
- **Rationale:** In clinical systems (e.g., drug allergy records), receiving outdated or conflicting data is life-threatening. The system strictly prioritises data consistency over availability during network partitions.
