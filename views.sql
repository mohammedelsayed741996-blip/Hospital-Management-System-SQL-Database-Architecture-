-- View 1: Doctor Appointment Summary View
CREATE VIEW vw_doctor_appointment_summary AS
SELECT
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    dp.dept_name,
    COUNT(a.appointment_id)                AS total_appointments
FROM Doctor d
JOIN Department dp ON d.department_id = dp.department_id
JOIN Appointment a  ON d.doctor_id    = a.doctor_id
GROUP BY d.doctor_id, doctor_name, dp.dept_name;

SELECT * FROM vw_doctor_appointment_summary;

-- View 2: Monthly Billing Trend View
CREATE VIEW vw_monthly_billing_trend AS
SELECT
    DATE_FORMAT(bill_date, '%Y-%m') AS billing_month,
    COUNT(bill_id)                  AS total_bills,
    SUM(total_amount)               AS total_charged,
    SUM(paid_amount)                AS total_collected,
    SUM(total_amount - paid_amount) AS outstanding_balance
FROM Billing
GROUP BY billing_month
ORDER BY billing_month;

SELECT * FROM vw_monthly_billing_trend;
