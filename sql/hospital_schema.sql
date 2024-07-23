drop table chart;
drop table doctor;
drop table patient;
drop table nurse;
drop table diagnosis;

create table doctor(
	doctor_id int unsigned not null,
    treatment_department varchar(40) not null,
    doctor_name varchar(20) not null,
    doctor_gender char(2) not null,
    doctor_phone char(13) not null,
    doctor_email varchar(30),
    doctor_rank varchar(15),
    primary key (doctor_id)
);

create table patient(
	patient_id int unsigned not null,
    nurse_id int unsigned not null,
    doctor_id int unsigned not null,
    patient_name varchar(20) not null,
    patient_gender char(2) not null,
    patienet_idenetity_number char(14) unique not null,
    patient_address varchar(45) not null,
    patient_phone char(13) not null,
    patient_email varchar(30),
    patient_job varchar(25),
    primary key (patient_id)
);

create table diagnosis (
	diagnosis_id char(10) not null,
    patient_id int unsigned not null,
    doctor_id int unsigned not null,
    diagnosis_content varchar(1000) not null,
    diagnosis_date date not null,
    primary key(diagnosis_id)
);

create table chart (
	chart_number int unsigned not null,
    diagnosis_id char(10) not null,
    doctor_id int unsigned not null,
	patient_id int unsigned not null,
    nurse_id int unsigned not null,
    chart_content varchar(1000) not null
);

create table nurse(
	nurse_id int unsigned not null,
    nurse_task varchar(30) not null,
    nurse_name varchar(20) not null,
    nurse_gender char(2) not null,
    nurse_phone char(13) not null,
    nurse_email varchar(30),
    nurse_rank varchar(15) not null,
    primary key (nurse_id)
);

alter table chart add unique index(
			diagnosis_id, chart_number
);


alter table patient add foreign key (nurse_id) references nurse(nurse_id);
ALTER TABLE patient ADD	foreign key (doctor_id) references doctor(doctor_id);

alter table diagnosis add foreign key (patient_id) references patient(patient_id);
alter table diagnosis add foreign key (doctor_id) references doctor(doctor_id);

alter table chart add foreign key (diagnosis_id) references diagnosis(diagnosis_id);
alter table chart add foreign key (doctor_id) references doctor(doctor_id);
alter table chart add foreign key (patient_id) references patient(patient_id);
alter table chart add foreign key (nurse_id) references nurse(nurse_id);
