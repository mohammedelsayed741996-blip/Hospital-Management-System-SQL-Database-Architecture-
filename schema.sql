-- Create Department Table
CREATE TABLE Department (
    department_id   INT PRIMARY KEY AUTO_INCREMENT,
    dept_name       VARCHAR(100) NOT NULL,
    location        VARCHAR(100),
    phone           VARCHAR(20)
);

-- Create Doctor Table
CREATE TABLE Doctor (
    doctor_id       INT PRIMARY KEY AUTO_INCREMENT,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    specialisation  VARCHAR(100),
    email           VARCHAR(100),
    department_id   INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create Patient Table
CREATE TABLE Patient (
    patient_id      INT PRIMARY KEY AUTO_INCREMENT,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    date_of_birth   DATE,
    gender          ENUM('Male','Female','Other'),
    phone           VARCHAR(20),
    email           VARCHAR(100)
);

-- Create Appointment Table
CREATE TABLE Appointment (
    appointment_id   INT PRIMARY KEY AUTO_INCREMENT,
    patient_id       INT NOT NULL,
    doctor_id        INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status           ENUM('Scheduled','Completed','Cancelled'),
    notes            TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id)  REFERENCES Doctor(doctor_id)
);

-- Create MedicalRecord Table
CREATE TABLE MedicalRecord (
    record_id       INT PRIMARY KEY AUTO_INCREMENT,
    patient_id      INT NOT NULL,
    doctor_id       INT NOT NULL,
    diagnosis       VARCHAR(255),
    treatment       TEXT,
    record_date     DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id)  REFERENCES Doctor(doctor_id)
);

-- Create Medication Table
CREATE TABLE Medication (
    medication_id   INT PRIMARY KEY AUTO_INCREMENT,
    med_name        VARCHAR(100) NOT NULL,
    dosage_form     VARCHAR(50),
    unit_price      DECIMAL(8,2)
);

-- Create Prescription Table
CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    record_id       INT NOT NULL,
    medication_id   INT NOT NULL,
    dosage          VARCHAR(100),
    duration_days   INT,
    FOREIGN KEY (record_id)     REFERENCES MedicalRecord(record_id),
    FOREIGN KEY (medication_id) REFERENCES Medication(medication_id)
);

-- Create Billing Table
CREATE TABLE Billing (
    bill_id          INT PRIMARY KEY AUTO_INCREMENT,
    patient_id       INT NOT NULL,
    appointment_id   INT NOT NULL,
    total_amount     DECIMAL(10,2),
    paid_amount      DECIMAL(10,2),
    bill_date        DATE,
    payment_status   ENUM('Paid','Pending','Partial'),
    FOREIGN KEY (patient_id)     REFERENCES Patient(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);
