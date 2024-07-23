CREATE TABLE Camping_car (
	car_id int not null COMMENT '캠핑카등록ID',
    company_id int not null COMMENT '캠핑카대여회사ID',
	car_name varchar(20) not null COMMENT '캠핑카이름',
	car_no int not null comment '캠핑카차량번호',
	car_member int not null comment '캠핑카승차인원',
	car_image blob not null comment '캠핑카이미지',
	car_info varchar(1000) comment '캠핑카상세정보',
	car_cost int not null comment '캠핑카대여비용',
	car_set_date date not null comment '캠핑카등록일자'
);

CREATE TABLE Rent_company (
	company_id int not null comment '캠핑카대여회사ID',
	company_name varchar(20) not null comment '회사명',
	company_address varchar(30) not null comment '주소',
    company_phone char(13) not null comment '전화번호',
	company_manager_name varchar(30) not null comment '담당자이름',
	company_manager_email varchar(30) not null unique comment '담당자이메일'
);
    
CREATE TABLE rent_car (
	rent_no int not null comment '대여번호',
	car_id int not null COMMENT '캠핑카등록ID',
	driver_license char(12) not null comment '운전면허증',
	company_id int not null comment '캠핑카대여회사ID',
	rent_start_date date not null comment '대여시작일',
	rent_end_date date not null comment '대여기간',
	rent_pay int not null comment '청구요금',
	pay_date date not null comment '납입기한',
	other_pay_content varchar(100) comment '기타청구내역',
	other_pay int comment '기타청구요금'
);


create table customers(
	driver_license char(12) not null comment '운전면허증',
	customer_name varchar(20) not null comment '고객명',
	customer_address varchar(30) not null comment '고객주소',
	customer_phone char(13) not null comment '고객전화번호',
	customer_email varchar(30) not null comment "고객이메일",	
	before_rent_date date comment '이전캠핑카사용날짜',
	before_rent_car varchar(20) comment '이전캠핑카사용종류'
);


create table repair_shop (
	shop_id int not null comment '캠핑카정비소ID',
	shop_name varchar(20) not null comment '정비소명',
	shop_address varchar(30) not null comment '정비소주소',
	shop_phone char(13) not null comment "정비소전화번호",
	shop_manager_name varchar(20) not null comment "담당자이름",
	shop_manager_email varchar(30) not null comment '담당자이메일'
);


create table repair_info (
	repair_no int not null comment '정비번호',
	car_id int not null comment '캠핑카등록ID',
	shop_id int not null comment '캠핑카정비소ID',
	company_id int not null comment '캠핑카대여회사ID',
	driver_license char(12) not null comment '운전면허증',
	repair_content varchar(100) not null comment '정비내역',
	repair_date date not null comment '수리날짜',
	repair_pay int not null comment '수리비용',
	pay_date date not null comment '납입기한',
	other_repair_content varchar(100) comment '기타정비내역'
);


ALTER TABLE Camping_car ADD CONSTRAINT car_company_id_pk PRIMARY KEY(car_id, company_id);
ALTER TABLE Camping_car ADD (CONSTRAINT Car_1 FOREIGN KEY (company_id) REFERENCES rent_company(company_id)); --

ALTER TABLE rent_company ADD CONSTRAINT rent_company_pk PRIMARY KEY(company_id);

ALTER TABLE rent_car ADD constraint rent_car_pk primary key(rent_no);
alter table rent_car add (constraint R_1 foreign key (car_id) references camping_car(car_id));
alter table rent_car add (constraint R_2 foreign key (driver_license) references customers(driver_license)); --
alter table rent_car add (constraint R_3 foreign key (company_id) references rent_company(company_id));

alter table customers add constraint customers_pk primary key(driver_license);

alter table repair_shop add constraint repair_shop_pk primary key(shop_id);

alter table repair_info add constraint repair_info_pk primary key (repair_no);
alter table repair_info add (constraint RI_1 foreign key(car_id) references camping_car(car_id));
alter table repair_info add (constraint RI_2 foreign key(shop_id) references repair_shop(shop_id));
alter table repair_info add (constraint RI_3 foreign key(company_id) references rent_company(company_id)); --
alter table repair_info add (constraint RI_4 foreign key(driver_license) references customers(driver_license));