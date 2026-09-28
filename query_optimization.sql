-- SLOW VERSION: Correlated Subquery (O(n) Execution)
SELECT first_name, last_name
FROM Patient p
WHERE (
    SELECT SUM(b.total_amount)
    FROM Billing b
    WHERE b.patient_id = p.patient_id
) > 150;


-- OPTIMIZATION IMPROVEMENT 1: Create B-Tree Index on foreign key
CREATE INDEX idx_billing_patient ON Billing(patient_id);


-- OPTIMIZATION IMPROVEMENT 2: Rewrite using JOIN + GROUP BY + HAVING
SELECT
    p.first_name,
    p.last_name,
    SUM(b.total_amount) AS total_billed
FROM Patient p
JOIN Billing b ON p.patient_id = b.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
HAVING SUM(b.total_amount) > 150
ORDER BY total_billed DESC;
