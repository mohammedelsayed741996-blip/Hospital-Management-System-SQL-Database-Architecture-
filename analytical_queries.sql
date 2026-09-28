-- Query 1: Clinician Consultation Volume (JOIN + GROUP BY)
SELECT
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    dp.dept_name,
    COUNT(DISTINCT a.patient_id)           AS unique_patients_seen
FROM Doctor d
JOIN Department dp ON d.department_id = dp.department_id
JOIN Appointment a ON d.doctor_id     = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.doctor_id, doctor_name, dp.dept_name
ORDER BY unique_patients_seen DESC;


-- Query 2: Patient Billing Compliance Profile (CASE Statement)
SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    SUM(b.total_amount)                    AS total_billed,
    SUM(b.paid_amount)                     AS total_paid,
    ROUND(SUM(b.paid_amount) /
          SUM(b.total_amount) * 100, 1)    AS payment_rate_pct,
    CASE
        WHEN SUM(b.paid_amount) >= SUM(b.total_amount)       THEN 'Fully Paid'
        WHEN SUM(b.paid_amount) >= SUM(b.total_amount) * 0.5 THEN 'Partial Payer'
        ELSE                                                      'Low Payer'
    END AS payment_category
FROM Patient p
JOIN Billing b ON p.patient_id = b.patient_id
GROUP BY p.patient_id, patient_name
ORDER BY total_billed DESC;


-- Query 3: Clinician Revenue Rank by Department (Window Function - RANK)
SELECT
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    dp.dept_name,
    SUM(b.total_amount)                    AS revenue_generated,
    RANK() OVER (
        PARTITION BY dp.dept_name
        ORDER BY SUM(b.total_amount) DESC
    )                                      AS revenue_rank_in_dept
FROM Doctor d
JOIN Department  dp ON d.department_id  = dp.department_id
JOIN Appointment a  ON d.doctor_id      = a.doctor_id
JOIN Billing     b  ON a.appointment_id = b.appointment_id
GROUP BY d.doctor_id, doctor_name, dp.dept_name
ORDER BY dp.dept_name, revenue_rank_in_dept;
