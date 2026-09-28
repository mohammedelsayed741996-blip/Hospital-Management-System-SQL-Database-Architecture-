-- Populate Department
INSERT INTO Department (dept_name, location, phone) VALUES
('Cardiology',   'Block A', '0201-1111'),
('Neurology',    'Block B', '0201-2222'),
('Orthopaedics', 'Block C', '0201-3333'),
('Paediatrics',  'Block D', '0201-4444');

SELECT * FROM Department;

-- Populate Doctor
INSERT INTO Doctor (first_name, last_name, specialisation, email, department_id) VALUES
('James',   'Carter',  'Cardiologist',  'j.carter@hospital.com',  1),
('Aisha',   'Rahman',  'Neurologist',   'a.rahman@hospital.com',  2),
('David',   'Nguyen',  'Orthopaedist',  'd.nguyen@hospital.com',  3),
('Sara',    'Collins', 'Cardiologist',  's.collins@hospital.com', 1),
('Michael', 'Brown',   'Paediatrician', 'm.brown@hospital.com',   4);

SELECT * FROM Doctor;

-- Populate Patient
INSERT INTO Patient (first_name, last_name, date_of_birth, gender, phone, email) VALUES
('Mohammed', 'Ali',    '1985-03-12', 'Male',   '07700-111', 'm.ali@email.com'),
('Emily',    'Stone',  '1992-07-25', 'Female', '07700-222', 'e.stone@email.com'),
('Raj',      'Patel',  '1978-11-05', 'Male',   '07700-333', 'r.patel@email.com'),
('Fatima',   'Hassan', '2000-01-30', 'Female', '07700-444', 'f.hassan@email.com'),
('Lucas',    'Wright', '1995-06-18', 'Male',   '07700-555', 'l.wright@email.com');

SELECT * FROM Patient;

-- Populate Appointment
INSERT INTO Appointment (patient_id, doctor_id, appointment_date, status, notes) VALUES
(1, 1, '2026-05-01 09:00:00', 'Completed', 'Routine heart check'),
(2, 2, '2026-05-03 10:30:00', 'Completed', 'Migraine follow-up'),
(3, 3, '2026-05-05 11:00:00', 'Completed', 'Knee pain assessment'),
(4, 1, '2026-05-10 14:00:00', 'Completed', 'ECG review'),
(5, 4, '2026-05-12 09:00:00', 'Scheduled', 'Child fever consultation');

SELECT * FROM Appointment;

-- Populate MedicalRecord
INSERT INTO MedicalRecord (patient_id, doctor_id, diagnosis, treatment, record_date) VALUES
(1, 1, 'Hypertension',     'Lifestyle changes and medication', '2026-05-01'),
(2, 2, 'Chronic Migraine', 'Pain management therapy',         '2026-05-03'),
(3, 3, 'Osteoarthritis',   'Physiotherapy sessions',          '2026-05-05'),
(4, 1, 'Arrhythmia',       'Beta blockers prescribed',        '2026-05-10'),
(5, 4, 'Viral Fever',      'Rest and fluids advised',         '2026-05-12');

SELECT * FROM MedicalRecord;

-- Populate Medication
INSERT INTO Medication (med_name, dosage_form, unit_price) VALUES
('Amlodipine',  'Tablet', 0.50),
('Sumatriptan', 'Tablet', 1.20),
('Ibuprofen',   'Tablet', 0.30),
('Metoprolol',  'Tablet', 0.80),
('Paracetamol', 'Tablet', 0.20);

SELECT * FROM Medication;

-- Populate Prescription
INSERT INTO Prescription (record_id, medication_id, dosage, duration_days) VALUES
(1, 1, '5mg once daily',     30),
(2, 2, '50mg when needed',   14),
(3, 3, '400mg three times',  10),
(4, 4, '25mg twice daily',   60),
(5, 5, '500mg three times',   7);

SELECT * FROM Prescription;

-- Populate Billing
INSERT INTO Billing (patient_id, appointment_id, total_amount, paid_amount, bill_date, payment_status) VALUES
(1, 1, 150.00, 150.00, '2026-05-01', 'Paid'),
(2, 2, 200.00, 100.00, '2026-05-03', 'Partial'),
(3, 3, 180.00, 180.00, '2026-05-05', 'Paid'),
(4, 4, 220.00,   0.00, '2026-05-10', 'Pending'),
(5, 5, 160.00,  80.00, '2026-05-12', 'Partial');

SELECT * FROM Billing;
