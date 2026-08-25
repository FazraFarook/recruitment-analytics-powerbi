DROP DATABASE IF EXISTS recruitment_analytics;
CREATE DATABASE recruitment_analytics;
USE recruitment_analytics;

-- DIMENSION TABLE 1: dim_department
CREATE TABLE dim_department (
    department_id   INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    department_head VARCHAR(100),
    location        VARCHAR(100)
);

INSERT INTO dim_department (department_name, department_head, location) VALUES
('Engineering',        'Alan Brooks',    'Colombo'),
('Marketing',          'Sara Perera',    'Kandy'),
('Human Resources',    'Nimal Fernando', 'Colombo'),
('Finance',            'Priya Dias',     'Colombo'),
('Sales',              'Rajan Kumar',    'Gampaha'),
('Operations',         'Lisa De Silva',  'Colombo'),
('IT & Infrastructure','Kevin Mendis',   'Colombo'),
('Customer Support',   'Amara Jayasinghe','Kandy');

-- DIMENSION TABLE 2: dim_job_position
CREATE TABLE dim_job_position (
    position_id    INT PRIMARY KEY AUTO_INCREMENT,
    position_title VARCHAR(100) NOT NULL,
    job_level      VARCHAR(50),   -- Entry / Mid / Senior / Lead
    employment_type VARCHAR(50)   -- Full-Time / Part-Time / Contract
);

INSERT INTO dim_job_position (position_title, job_level, employment_type) VALUES
('Software Engineer',         'Mid',    'Full-Time'),
('Senior Software Engineer',  'Senior', 'Full-Time'),
('Marketing Executive',       'Entry',  'Full-Time'),
('Marketing Manager',         'Senior', 'Full-Time'),
('HR Executive',              'Entry',  'Full-Time'),
('HR Business Partner',       'Mid',    'Full-Time'),
('Financial Analyst',         'Mid',    'Full-Time'),
('Finance Manager',           'Senior', 'Full-Time'),
('Sales Representative',      'Entry',  'Full-Time'),
('Sales Manager',             'Senior', 'Full-Time'),
('Operations Coordinator',    'Entry',  'Full-Time'),
('IT Support Specialist',     'Entry',  'Full-Time'),
('Systems Administrator',     'Mid',    'Full-Time'),
('Customer Support Agent',    'Entry',  'Full-Time'),
('Team Lead – Customer Supp', 'Lead',   'Full-Time');

-- DIMENSION TABLE 3: dim_recruitment_source
CREATE TABLE dim_recruitment_source (
    source_id   INT PRIMARY KEY AUTO_INCREMENT,
    source_name VARCHAR(100) NOT NULL,
    source_type VARCHAR(50)   -- Online / Referral / Agency / Walk-in
);

INSERT INTO dim_recruitment_source (source_name, source_type) VALUES
('LinkedIn',          'Online'),
('Indeed',            'Online'),
('Company Website',   'Online'),
('Employee Referral', 'Referral'),
('Recruitment Agency','Agency'),
('Campus Recruitment','Campus'),
('Walk-in',           'Walk-in'),
('Facebook Jobs',     'Online');

-- FACT TABLE: fact_recruitment
CREATE TABLE fact_recruitment (
    application_id       INT PRIMARY KEY AUTO_INCREMENT,
    applicant_name       VARCHAR(100) NOT NULL,
    department_id        INT NOT NULL,
    position_id          INT NOT NULL,
    source_id            INT NOT NULL,
    application_date     DATE NOT NULL,
    screening_date       DATE,
    interview_date       DATE,
    offer_date           DATE,
    joining_date         DATE,
    current_stage        VARCHAR(50) NOT NULL,
    -- Stages: Applied / Screened / Interviewed / Offered / Hired / Rejected / Withdrawn
    rejection_reason     VARCHAR(100),
    -- Null if not rejected. Values: Skill Mismatch / Salary Expectation / Failed Interview / Withdrew / Overqualified
    experience_years     INT,
    expected_salary_lkr  INT,
    offered_salary_lkr   INT,
    gender               VARCHAR(10),
    age                  INT,
    FOREIGN KEY (department_id) REFERENCES dim_department(department_id),
    FOREIGN KEY (position_id)   REFERENCES dim_job_position(position_id),
    FOREIGN KEY (source_id)     REFERENCES dim_recruitment_source(source_id)
);


-- INSERT 100 APPLICANT RECORDS
INSERT INTO fact_recruitment
(applicant_name, department_id, position_id, source_id, application_date, screening_date, interview_date, offer_date, joining_date, current_stage, rejection_reason, experience_years, expected_salary_lkr, offered_salary_lkr, gender, age)
VALUES
-- HIRED (25 records)
('Kavindu Perera',      1, 1, 1, '2023-01-05', '2023-01-10', '2023-01-17', '2023-01-24', '2023-02-01', 'Hired', NULL, 3, 120000, 115000, 'Male',   27),
('Nimasha Silva',       1, 1, 2, '2023-01-12', '2023-01-18', '2023-01-25', '2023-02-01', '2023-02-15', 'Hired', NULL, 2, 110000, 108000, 'Female', 25),
('Tharindu Fernando',   2, 3, 3, '2023-02-01', '2023-02-07', '2023-02-14', '2023-02-21', '2023-03-01', 'Hired', NULL, 1, 75000,  72000,  'Male',   23),
('Asha Rodrigo',        3, 5, 4, '2023-02-10', '2023-02-15', '2023-02-22', '2023-03-01', '2023-03-15', 'Hired', NULL, 2, 80000,  78000,  'Female', 26),
('Dinesh Jayasuriya',   4, 7, 1, '2023-03-01', '2023-03-08', '2023-03-15', '2023-03-22', '2023-04-01', 'Hired', NULL, 4, 130000, 128000, 'Male',   30),
('Sanduni Wickrama',    5, 9, 2, '2023-03-15', '2023-03-20', '2023-03-27', '2023-04-03', '2023-04-17', 'Hired', NULL, 1, 65000,  63000,  'Female', 22),
('Ruwan Dissanayake',   6, 11,5, '2023-04-01', '2023-04-07', '2023-04-14', '2023-04-21', '2023-05-01', 'Hired', NULL, 2, 85000,  83000,  'Male',   28),
('Malsha Gunawardena',  7, 12,3, '2023-04-10', '2023-04-16', '2023-04-23', '2023-04-30', '2023-05-15', 'Hired', NULL, 1, 72000,  70000,  'Female', 24),
('Isuru Bandara',       8, 14,6, '2023-05-01', '2023-05-07', '2023-05-14', '2023-05-21', '2023-06-01', 'Hired', NULL, 1, 68000,  66000,  'Male',   23),
('Pradeep Kumara',      1, 2, 4, '2023-05-15', '2023-05-22', '2023-05-29', '2023-06-05', '2023-06-19', 'Hired', NULL, 6, 180000, 175000, 'Male',   33),
('Dilini Senanayake',   2, 4, 1, '2023-06-01', '2023-06-07', '2023-06-14', '2023-06-21', '2023-07-01', 'Hired', NULL, 7, 200000, 195000, 'Female', 35),
('Chamara Rajapaksha',  4, 8, 5, '2023-06-15', '2023-06-21', '2023-06-28', '2023-07-05', '2023-07-19', 'Hired', NULL, 8, 220000, 215000, 'Male',   37),
('Gayani Mendis',       3, 6, 2, '2023-07-01', '2023-07-07', '2023-07-14', '2023-07-21', '2023-08-01', 'Hired', NULL, 4, 140000, 138000, 'Female', 30),
('Buddhika Rathnayake', 5, 10,3, '2023-07-15', '2023-07-21', '2023-07-28', '2023-08-04', '2023-08-18', 'Hired', NULL, 6, 195000, 190000, 'Male',   34),
('Samantha Weerasekara',6, 11,6, '2023-08-01', '2023-08-07', '2023-08-14', '2023-08-21', '2023-09-01', 'Hired', NULL, 3, 92000,  90000,  'Female', 29),
('Lahiru Pathirana',    7, 13,1, '2023-08-15', '2023-08-21', '2023-08-28', '2023-09-04', '2023-09-18', 'Hired', NULL, 4, 145000, 142000, 'Male',   31),
('Thilini Abeywickrama',8, 15,4, '2023-09-01', '2023-09-07', '2023-09-14', '2023-09-21', '2023-10-01', 'Hired', NULL, 5, 160000, 158000, 'Female', 32),
('Kasun Amarasinghe',   1, 1, 7, '2023-09-15', '2023-09-21', '2023-09-28', '2023-10-05', '2023-10-19', 'Hired', NULL, 2, 112000, 110000, 'Male',   26),
('Nadeesha Herath',     2, 3, 2, '2023-10-01', '2023-10-07', '2023-10-14', '2023-10-21', '2023-11-01', 'Hired', NULL, 2, 78000,  76000,  'Female', 25),
('Gihan Liyanage',      4, 7, 8, '2023-10-15', '2023-10-21', '2023-10-28', '2023-11-04', '2023-11-18', 'Hired', NULL, 3, 125000, 122000, 'Male',   29),
('Sachini Jayawardena', 3, 5, 3, '2023-11-01', '2023-11-07', '2023-11-14', '2023-11-21', '2023-12-01', 'Hired', NULL, 2, 82000,  80000,  'Female', 27),
('Asanka Wijesinghe',   6, 11,1, '2023-11-15', '2023-11-21', '2023-11-28', '2023-12-05', '2023-12-19', 'Hired', NULL, 3, 90000,  88000,  'Male',   28),
('Chamindi Ekanayake',  8, 14,5, '2023-12-01', '2023-12-07', '2023-12-14', '2023-12-21', '2024-01-06', 'Hired', NULL, 1, 67000,  65000,  'Female', 22),
('Vimukthi Siriwardena',1, 2, 4, '2024-01-10', '2024-01-16', '2024-01-23', '2024-01-30', '2024-02-13', 'Hired', NULL, 5, 165000, 160000, 'Male',   32),
('Ruwanthi Kotelawala', 5, 9, 6, '2024-02-01', '2024-02-07', '2024-02-14', '2024-02-21', '2024-03-06', 'Hired', NULL, 2, 70000,  68000,  'Female', 24),

-- REJECTED (35 records)
('Mohan Balasingham',   1, 1, 1, '2023-01-20', '2023-01-26', '2023-02-02', NULL, NULL, 'Rejected', 'Failed Interview',     1, 115000, NULL, 'Male',   24),
('Iresha Wimalasena',   2, 3, 2, '2023-02-05', '2023-02-11', '2023-02-18', NULL, NULL, 'Rejected', 'Skill Mismatch',       0, 70000,  NULL, 'Female', 21),
('Nalin Gunasekara',    3, 5, 3, '2023-02-20', '2023-02-26', NULL,         NULL, NULL, 'Rejected', 'Skill Mismatch',       1, 75000,  NULL, 'Male',   23),
('Harsha Madushanka',   4, 7, 1, '2023-03-05', '2023-03-11', '2023-03-18', NULL, NULL, 'Rejected', 'Salary Expectation',   3, 160000, NULL, 'Male',   29),
('Dilrukshi Perera',    5, 9, 4, '2023-03-20', '2023-03-26', '2023-04-02', NULL, NULL, 'Rejected', 'Failed Interview',     1, 68000,  NULL, 'Female', 22),
('Nuwan Rajapaksha',    6, 11,5, '2023-04-05', '2023-04-11', NULL,         NULL, NULL, 'Rejected', 'Skill Mismatch',       0, 80000,  NULL, 'Male',   21),
('Amali Wickramasinghe',7, 12,2, '2023-04-20', '2023-04-26', '2023-05-03', NULL, NULL, 'Rejected', 'Failed Interview',     1, 73000,  NULL, 'Female', 23),
('Jehan Fonseka',       8, 14,6, '2023-05-05', '2023-05-11', '2023-05-18', NULL, NULL, 'Rejected', 'Salary Expectation',   2, 85000,  NULL, 'Male',   26),
('Rashmi Dissanayake',  1, 1, 7, '2023-05-20', '2023-05-26', '2023-06-02', NULL, NULL, 'Rejected', 'Overqualified',        8, 200000, NULL, 'Female', 35),
('Sanjeewa Kumara',     2, 4, 1, '2023-06-05', '2023-06-11', '2023-06-18', NULL, NULL, 'Rejected', 'Failed Interview',     4, 155000, NULL, 'Male',   31),
('Thushara Jayakody',   3, 6, 3, '2023-06-20', '2023-06-26', NULL,         NULL, NULL, 'Rejected', 'Skill Mismatch',       2, 135000, NULL, 'Male',   28),
('Waruni Seneviratne',  4, 8, 2, '2023-07-05', '2023-07-11', '2023-07-18', NULL, NULL, 'Rejected', 'Salary Expectation',   6, 240000, NULL, 'Female', 34),
('Dhanushka Alwis',     5, 10,5, '2023-07-20', '2023-07-26', '2023-08-02', NULL, NULL, 'Rejected', 'Failed Interview',     4, 185000, NULL, 'Male',   32),
('Pubudu Wijeratne',    6, 11,4, '2023-08-05', '2023-08-11', NULL,         NULL, NULL, 'Rejected', 'Skill Mismatch',       1, 88000,  NULL, 'Male',   24),
('Shalini Karunaratne', 7, 13,1, '2023-08-20', '2023-08-26', '2023-09-02', NULL, NULL, 'Rejected', 'Failed Interview',     3, 140000, NULL, 'Female', 29),
('Roshan Bandara',      8, 15,6, '2023-09-05', '2023-09-11', '2023-09-18', NULL, NULL, 'Rejected', 'Salary Expectation',   4, 175000, NULL, 'Male',   30),
('Chamika Weerasinghe', 1, 2, 3, '2023-09-20', '2023-09-26', '2023-10-03', NULL, NULL, 'Rejected', 'Failed Interview',     3, 160000, NULL, 'Male',   29),
('Nishadi Ranasinghe',  2, 3, 2, '2023-10-05', '2023-10-11', NULL,         NULL, NULL, 'Rejected', 'Skill Mismatch',       0, 72000,  NULL, 'Female', 21),
('Kaveesha Jayasena',   3, 5, 7, '2023-10-20', '2023-10-26', '2023-11-02', NULL, NULL, 'Rejected', 'Failed Interview',     1, 79000,  NULL, 'Female', 23),
('Priyantha Munasinghe',4, 7, 1, '2023-11-05', '2023-11-11', '2023-11-18', NULL, NULL, 'Rejected', 'Overqualified',        9, 210000, NULL, 'Male',   38),
('Tharaka Madushan',    5, 9, 4, '2023-11-20', '2023-11-26', '2023-12-03', NULL, NULL, 'Rejected', 'Failed Interview',     2, 67000,  NULL, 'Male',   25),
('Subani Gamage',       6, 11,5, '2023-12-05', '2023-12-11', NULL,         NULL, NULL, 'Rejected', 'Skill Mismatch',       0, 82000,  NULL, 'Female', 21),
('Saman Ekanayake',     7, 12,3, '2023-12-20', '2023-12-26', '2024-01-02', NULL, NULL, 'Rejected', 'Failed Interview',     2, 75000,  NULL, 'Male',   26),
('Chathurika Perera',   8, 14,6, '2024-01-15', '2024-01-21', '2024-01-28', NULL, NULL, 'Rejected', 'Salary Expectation',   3, 90000,  NULL, 'Female', 27),
('Hirusha Marasinghe',  1, 1, 2, '2024-02-05', '2024-02-11', '2024-02-18', NULL, NULL, 'Rejected', 'Failed Interview',     2, 108000, NULL, 'Male',   25),
('Lahiru Sampath',      2, 4, 1, '2024-02-20', '2024-02-26', NULL,         NULL, NULL, 'Rejected', 'Skill Mismatch',       5, 195000, NULL, 'Male',   32),
('Nilmini Abeyratne',   3, 6, 8, '2024-03-01', '2024-03-07', '2024-03-14', NULL, NULL, 'Rejected', 'Failed Interview',     3, 138000, NULL, 'Female', 29),
('Danushka Silva',      4, 8, 4, '2024-03-10', '2024-03-16', '2024-03-23', NULL, NULL, 'Rejected', 'Salary Expectation',   7, 230000, NULL, 'Male',   36),
('Pavithra Jayaratne',  5, 10,3, '2024-03-20', '2024-03-26', '2024-04-02', NULL, NULL, 'Rejected', 'Failed Interview',     5, 190000, NULL, 'Female', 33),
('Malith Wickramanayake',6,11,5, '2024-04-01', '2024-04-07', NULL,         NULL, NULL, 'Rejected', 'Skill Mismatch',       1, 85000,  NULL, 'Male',   23),
('Udari Tennakoon',     7, 13,1, '2024-04-10', '2024-04-16', '2024-04-23', NULL, NULL, 'Rejected', 'Failed Interview',     3, 142000, NULL, 'Female', 29),
('Ravindu Navaratne',   8, 15,6, '2024-04-20', '2024-04-26', '2024-05-03', NULL, NULL, 'Rejected', 'Salary Expectation',   4, 170000, NULL, 'Male',   31),
('Chamath Serasinghe',  1, 2, 2, '2024-05-01', '2024-05-07', '2024-05-14', NULL, NULL, 'Rejected', 'Overqualified',        10,220000, NULL, 'Male',   39),
('Wishma Liyanage',     2, 3, 7, '2024-05-10', '2024-05-16', NULL,         NULL, NULL, 'Rejected', 'Skill Mismatch',       0, 71000,  NULL, 'Female', 20),
('Kasun Thilakarathna', 3, 5, 4, '2024-05-20', '2024-05-26', '2024-06-02', NULL, NULL, 'Rejected', 'Failed Interview',     1, 78000,  NULL, 'Male',   22),

-- WITHDRAWN (15 records)
('Dinusha Rathnasiri',  4, 7, 2, '2023-03-10', '2023-03-16', '2023-03-23', '2023-03-30', NULL, 'Withdrawn', 'Withdrew', 3, 128000, 125000, 'Female', 29),
('Thilak Jayasundara',  5, 9, 1, '2023-04-15', '2023-04-21', '2023-04-28', '2023-05-05', NULL, 'Withdrawn', 'Withdrew', 2, 66000,  64000,  'Male',   24),
('Priyani Dissanayake', 6, 11,3, '2023-06-10', '2023-06-16', '2023-06-23', '2023-06-30', NULL, 'Withdrawn', 'Withdrew', 3, 88000,  86000,  'Female', 28),
('Amitha Weerakoon',    7, 13,5, '2023-07-10', '2023-07-16', '2023-07-23', '2023-07-30', NULL, 'Withdrawn', 'Withdrew', 4, 145000, 140000, 'Male',   31),
('Suwanda Siriwardena', 8, 15,4, '2023-08-10', '2023-08-16', '2023-08-23', '2023-08-30', NULL, 'Withdrawn', 'Withdrew', 5, 162000, 158000, 'Male',   33),
('Lochana Amaratunga',  1, 1, 6, '2023-09-10', '2023-09-16', '2023-09-23', '2023-09-30', NULL, 'Withdrawn', 'Withdrew', 2, 110000, 107000, 'Female', 26),
('Madura Chandrasekara',2, 4, 2, '2023-10-10', '2023-10-16', '2023-10-23', '2023-10-30', NULL, 'Withdrawn', 'Withdrew', 6, 195000, 190000, 'Male',   34),
('Thisari Ranaweera',   3, 6, 1, '2023-11-10', '2023-11-16', '2023-11-23', '2023-11-30', NULL, 'Withdrawn', 'Withdrew', 4, 142000, 138000, 'Female', 30),
('Dushyantha Hettige',  4, 8, 7, '2023-12-10', '2023-12-16', '2023-12-23', '2023-12-30', NULL, 'Withdrawn', 'Withdrew', 7, 218000, 212000, 'Male',   36),
('Menaka Senanayake',   5, 10,3, '2024-01-05', '2024-01-11', '2024-01-18', '2024-01-25', NULL, 'Withdrawn', 'Withdrew', 5, 188000, 183000, 'Female', 32),
('Rusiru Pathirathna',  6, 11,5, '2024-02-10', '2024-02-16', '2024-02-23', '2024-03-01', NULL, 'Withdrawn', 'Withdrew', 2, 86000,  84000,  'Male',   27),
('Achini Madawela',     7, 12,4, '2024-03-05', '2024-03-11', '2024-03-18', '2024-03-25', NULL, 'Withdrawn', 'Withdrew', 1, 74000,  72000,  'Female', 23),
('Shehan Nallaperuma',  8, 14,6, '2024-04-05', '2024-04-11', '2024-04-18', '2024-04-25', NULL, 'Withdrawn', 'Withdrew', 2, 67000,  65000,  'Male',   24),
('Ransika Wijekoon',    1, 2, 1, '2024-05-05', '2024-05-11', '2024-05-18', '2024-05-25', NULL, 'Withdrawn', 'Withdrew', 5, 163000, 158000, 'Male',   33),
('Hasini Dassanayake',  2, 3, 2, '2024-05-15', '2024-05-21', '2024-05-28', '2024-06-04', NULL, 'Withdrawn', 'Withdrew', 2, 77000,  75000,  'Female', 25),

-- IN PIPELINE — OFFERED (10 records)
('Nipun Rajapaksha',    1, 1, 1, '2024-06-01', '2024-06-06', '2024-06-13', '2024-06-20', NULL, 'Offered', NULL, 3, 118000, 115000, 'Male',   27),
('Sewwandi Madushanka', 3, 5, 4, '2024-06-03', '2024-06-08', '2024-06-15', '2024-06-22', NULL, 'Offered', NULL, 2, 81000,  79000,  'Female', 25),
('Thilina Kumara',      4, 7, 2, '2024-06-05', '2024-06-10', '2024-06-17', '2024-06-24', NULL, 'Offered', NULL, 4, 133000, 130000, 'Male',   30),
('Kalani Jayatilake',   5, 9, 3, '2024-06-07', '2024-06-12', '2024-06-19', '2024-06-26', NULL, 'Offered', NULL, 1, 66000,  64000,  'Female', 22),
('Dimuth Wijesuriya',   6, 11,5, '2024-06-09', '2024-06-14', '2024-06-21', '2024-06-28', NULL, 'Offered', NULL, 2, 87000,  85000,  'Male',   26),

-- IN PIPELINE — INTERVIEWED (8 records)
('Yoshitha Senevirathna',7,13, 1,'2024-06-10', '2024-06-15', '2024-06-22', NULL,          NULL, 'Interviewed', NULL, 4, 148000, NULL, 'Male',   31),
('Dilnoza Perera',       8,14, 6,'2024-06-11', '2024-06-16', '2024-06-23', NULL,          NULL, 'Interviewed', NULL, 1, 68000,  NULL, 'Female', 22),
('Mahesh Liyanapathirana',1,2, 4,'2024-06-12', '2024-06-17', '2024-06-24', NULL,          NULL, 'Interviewed', NULL, 5, 168000, NULL, 'Male',   33),
('Nadun Sooriyaarachchi',2,4, 2,'2024-06-13', '2024-06-18', '2024-06-25', NULL,          NULL, 'Interviewed', NULL, 6, 198000, NULL, 'Male',   35),
('Tharindi Galhenage',   3,6, 3,'2024-06-14', '2024-06-19', '2024-06-26', NULL,          NULL, 'Interviewed', NULL, 3, 139000, NULL, 'Female', 29),

-- IN PIPELINE — SCREENED (4 records)
('Prabath Jayawardena',  4, 8, 1,'2024-06-20', '2024-06-25', NULL,          NULL,          NULL, 'Screened', NULL, 7, 222000, NULL, 'Male',   37),
('Sithumi Ranawaka',     5,10, 5,'2024-06-21', '2024-06-26', NULL,          NULL,          NULL, 'Screened', NULL, 5, 192000, NULL, 'Female', 32),
('Asiri Heendeniya',     6,11, 8,'2024-06-22', '2024-06-27', NULL,          NULL,          NULL, 'Screened', NULL, 1, 84000,  NULL, 'Male',   23),

-- IN PIPELINE — APPLIED (3 records)
('Manoli Wickramarachchi',7,15,2,'2024-06-25', NULL,          NULL,          NULL,          NULL, 'Applied', NULL, 5, 163000, NULL, 'Female', 32),
('Hashan Siriwardhane',   8,14,1,'2024-06-26', NULL,          NULL,          NULL,          NULL, 'Applied', NULL, 2, 69000,  NULL, 'Male',   24),
('Chamara Thilakaratna',  1, 1, 3,'2024-06-27', NULL,          NULL,          NULL,          NULL, 'Applied', NULL, 3, 116000, NULL, 'Male',   28);

-- VALIDATION QUERIES — Run these to check your data
-- 1. Total applications per stage
SELECT current_stage, COUNT(*) AS total
FROM fact_recruitment
GROUP BY current_stage
ORDER BY total DESC;

-- 2. Applications by department
SELECT d.department_name, COUNT(*) AS applications
FROM fact_recruitment f
JOIN dim_department d ON f.department_id = d.department_id
GROUP BY d.department_name
ORDER BY applications DESC;

-- 3. Average time-to-hire (days from application to joining)
SELECT 
    d.department_name,
    ROUND(AVG(DATEDIFF(f.joining_date, f.application_date)), 1) AS avg_days_to_hire
FROM fact_recruitment f
JOIN dim_department d ON f.department_id = d.department_id
WHERE f.current_stage = 'Hired'
GROUP BY d.department_name;

-- 4. Top recruitment sources
SELECT s.source_name, COUNT(*) AS applications, 
       SUM(CASE WHEN f.current_stage = 'Hired' THEN 1 ELSE 0 END) AS hires
FROM fact_recruitment f
JOIN dim_recruitment_source s ON f.source_id = s.source_id
GROUP BY s.source_name
ORDER BY hires DESC;

-- 5. Rejection reason breakdown
SELECT rejection_reason, COUNT(*) AS total
FROM fact_recruitment
WHERE rejection_reason IS NOT NULL
GROUP BY rejection_reason
ORDER BY total DESC;

-- 6. Gender breakdown of hires
SELECT gender, COUNT(*) AS hired_count
FROM fact_recruitment
WHERE current_stage = 'Hired'
GROUP BY gender;

-- 7. Monthly application trend
SELECT 
    DATE_FORMAT(application_date, '%Y-%m') AS month,
    COUNT(*) AS applications,
    SUM(CASE WHEN current_stage = 'Hired' THEN 1 ELSE 0 END) AS hires
FROM fact_recruitment
GROUP BY month
ORDER BY month;

-- 8. Full join — all applicant details with dimension names
SELECT 
    f.application_id,
    f.applicant_name,
    d.department_name,
    p.position_title,
    p.job_level,
    s.source_name,
    f.application_date,
    f.current_stage,
    f.rejection_reason,
    f.experience_years,
    f.expected_salary_lkr,
    f.offered_salary_lkr,
    f.gender,
    f.age,
    DATEDIFF(COALESCE(f.joining_date, CURDATE()), f.application_date) AS days_in_pipeline
FROM fact_recruitment f
JOIN dim_department d         ON f.department_id = d.department_id
JOIN dim_job_position p       ON f.position_id   = p.position_id
JOIN dim_recruitment_source s ON f.source_id     = s.source_id
ORDER BY f.application_date;
