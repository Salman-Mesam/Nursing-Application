-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.


--Database Table Creation for my Backend

CREATE TABLE Mother
(
    MotherId varchar(30) not null,
    email varchar(30) not null,
    QHI varchar(30) not null,
    PhoneNo CHAR(30) not null,
    DOB DATE not null,
    Name varchar(30) not null,
    BloodType varchar(30),
    address varchar(60) not null,
    profession varchar(30) not null
    ,PRIMARY KEY(MotherId)
);

CREATE TABLE Father
(
    FatherId varchar(30) not null,
    email varchar(30) ,
    QHI varchar(30) ,
    PhoneNo CHAR(30) not null,
    DOB DATE not null,
    Name varchar(30) not null,
    BloodType varchar(30),
    address varchar(60) ,
    profession varchar(30) not null
    ,PRIMARY KEY(FatherId)
);

--coupled With
CREATE TABLE Couple
(
    CoupleId varchar(30) NOT NULL ,
    FatherId varchar(30)  ,
    MotherId varchar(30) NOT NULL ,
    PRIMARY KEY(CoupleId),
    FOREIGN KEY (MotherId) REFERENCES Mother(MotherId) on DELETE cascade ,
    FOREIGN KEY (FatherId) REFERENCES Father(FatherId) on DELETE cascade
);

CREATE TABLE HealthCareInstitute
(
    InstituteId varchar(30) NOT NULL ,
    email varchar(30) NOT NULL UNIQUE ,
    name varchar(30) NOT NULL,
    website varchar(30) NOT NULL UNIQUE,
    address varchar(60) NOT NULL,
    phoneNo varchar(30) NOT NULL UNIQUE
    ,PRIMARY KEY(InstituteId)

);

CREATE TABLE Clinic
(
    ClinicId varchar(30) NOT NULL ,
    email varchar(30) NOT NULL UNIQUE,
    name varchar(30) NOT NULL UNIQUE,
    website varchar(30) NOT NULL UNIQUE,
    phoneNo varchar(30) NOT NULL UNIQUE
    ,PRIMARY KEY(ClinicId)

);

CREATE TABLE BirthingCenter
(
    BcentreId varchar(30) NOT NULL ,
    email varchar(30) NOT NULL UNIQUE ,
    name varchar(30) NOT NULL UNIQUE ,
    website varchar(30) NOT NULL UNIQUE ,
    phoneNo varchar(30) NOT NULL UNIQUE
    ,PRIMARY KEY(BcentreId)

);

CREATE TABLE Midwife
(
    PractitionerId varchar(30) not null,
    type varchar(30)  not null,
    name varchar(30) not null ,
    phoneNo CHAR(30) not null UNIQUE ,
    email varchar(30) not null UNIQUE
    ,InstituteId varchar(30) not null
    ,PRIMARY KEY(PractitionerId),
    FOREIGN KEY  (InstituteId) References HealthCareInstitute(InstituteId) on DELETE cascade
);

CREATE TABLE InfoSession
(
    SessionId varchar(30) not null,
    time TIME  not null,
    date DATE not null ,
    language CHAR(30) not null,
    PractitionerId varchar(30) not null
    ,PRIMARY KEY(SessionId),
    FOREIGN KEY  (PractitionerId) References Midwife(PractitionerId) on DELETE cascade
);

CREATE TABLE SessionAttendanceMother
(
    SessionId varchar(30) not null,
    MotherId varchar(30) not null

    ,PRIMARY KEY(SessionId,MotherId),
    FOREIGN KEY  (MotherId) References Mother(MotherId) on DELETE cascade
);


CREATE TABLE SessionAttendanceFather
(
    SessionId varchar(30) not null,
    FatherId varchar(30) not null

    ,PRIMARY KEY(SessionId,FatherId),
    FOREIGN KEY  (FatherId) References Father(FatherId) on DELETE cascade
);

CREATE TABLE Appointments
(
    AppId varchar(30) not null,
    time TIME  not null,
    date DATE not null ,
    PractitionerId varchar(30) not null
    ,PRIMARY KEY(AppId),
    FOREIGN KEY  (PractitionerId) References Midwife(PractitionerId) on DELETE cascade
);


CREATE TABLE Notes
(
    NoteId varchar(30) not null,
    timestamp TIMESTAMP  not null,
    details varchar(300) not null ,
    observation varchar(300) not null,
    AppId varchar(30) not null
    ,PRIMARY KEY(NoteId),
    FOREIGN KEY  (AppId) References Appointments(AppId) on delete cascade
);


CREATE TABLE LabTechnician
(
    TechnicianId varchar(30) not null,
    TechnicianName varchar(30) not null,
    TechnicianCell CHAR(30) not null
    ,PRIMARY KEY(TechnicianId)

);


CREATE TABLE Pregnancy
(
    PregnancyId varchar(30) not null,
    pregCount INTEGER  not null,
    finalDueDate DATE  ,
    menstrualDueDate DATE ,
    ultrasoundDueDate DATE ,
    estimatedDueDate DATE ,
    MotherId varchar(30) not null,
    FatherId varchar(30),
    AppId varchar(30) NOT NULL unique ,
    PractitionerId varchar(30) ,
    BcentreId varchar(30)  ,
    isPregnant BOOLEAN,
    givenBirth BOOLEAN ,

    PRIMARY KEY(PregnancyId),
    FOREIGN KEY  (MotherId) References Mother(MotherId),
    FOREIGN KEY  (FatherId) References Father(FatherId),
    FOREIGN KEY  (AppId) References Appointments(AppId),
    FOREIGN KEY  (BcentreId) References BirthingCenter(BcentreId),
    FOREIGN KEY  (PractitionerId) References Midwife(PractitionerId)


);

CREATE TABLE Baby
(
    BabyId varchar(30) not null,
    name varchar(30) not null,
    gender varchar(30) not null,
    bloodType varchar(30) not null,
    DOB DATE not null,
    birthTime TIME not null,
    birthType varchar(30) not null,
    PregnancyId varchar(30) not null
    ,PRIMARY KEY(BabyId)
    ,  FOREIGN KEY  (PregnancyId) References Pregnancy(PregnancyId) on delete cascade

);

CREATE TABLE MeetingRecord
(
    PregnancyId varchar(30) not null,
    AppId varchar(30) not null,
    PRIMARY KEY(AppId,PregnancyId) ,
    FOREIGN KEY (AppId) REFERENCES Appointments(AppId) on delete cascade,
    FOREIGN KEY (PregnancyId) REFERENCES Pregnancy(PregnancyId) on delete cascade
);




--NOte for developer Participation constraint
CREATE TABLE MidWifePregnancyRecord
(
    PregnancyId varchar(30) not null,
    PractitionerId varchar(30) not null ,
    isPrimary BOOLEAN
    ,PRIMARY KEY(PregnancyId,PractitionerId),
    FOREIGN KEY  (PractitionerId) References Midwife(PractitionerId) on delete cascade ,
    FOREIGN KEY  (PregnancyId) References Pregnancy(PregnancyId) on delete cascade
);


CREATE TABLE TEST
(
    TestId varchar(30) not null,
    type varchar(30)  not null,
    prescribedDate DATE not null ,
    labConductDate DATE not null,
    sampleDate DATE not null,
    resultDescription varchar(30) not null,
    PregnancyId varchar(30) not null,
    PractionerId varchar(30) not null,
    TechnicianId varchar(30) not null ,
    BabyId varchar(30) not null
    ,PRIMARY KEY(TestId),
    FOREIGN KEY  (PractionerId) References Midwife(PractitionerId) on delete cascade,
    FOREIGN KEY  (PregnancyId) References Pregnancy(PregnancyId) on delete cascade,
    FOREIGN KEY  (TechnicianId) References LabTechnician(TechnicianId) on delete cascade,
    FOREIGN KEY  (BabyId) References Baby(BabyId) on delete cascade,
    CHECK ( labConductDate >= prescribedDate )

);



--End of Tables To Be Created --
