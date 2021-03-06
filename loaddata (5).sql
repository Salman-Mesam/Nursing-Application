-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!


INSERT INTO Mother (MotherId, email,QHI,PhoneNo,DOB,Name,BloodType,address,profession) VALUES
(1,'pakeeeza1@gmail.com','QHI1234',4387287999,'2000-05-18','Pakeeza 2','O+','3565 avenue lorne','Engineer1'),
(146,'pakeeeza2@gmail.com','QHI1235',43872587939,'2000-07-18','Pakeeza 3','B+','3566 avenue lorne','Engineer2'),
(14,'pakeeeza3@gmail.com','QHI1236',43872787939,'2000-09-18','Pakeeza 4','A+','3567 avenue lorne','Engineer3'),
(14640,'pakeeeza4@gmail.com','QHI1237',4387287939,'2000-01-18','Pakeeza 5','C+','3569 avenue lorne','Engineer4'),
(1464660,'pakeeeza6@gmail.com','QHI1237',438726687939,'2000-01-18','Pakeeza 5','C+','3569 avenue lorne','Engineer4'),
(1827,'victo6@gmail.com','QHIss1237',43872668221,'2001-01-18','Victoria Gutierrez','C+','3569 avenue lorne','Engineer4')
;
INSERT INTO Father (FatherId, email,QHI,PhoneNo,DOB,Name,BloodType,address,profession) VALUES
(12,'mesam1@gmail.com','QHI123bb4',43387287999,'2001-05-18','Mesam 2','O+','356s5 avenue lorne','Engineer1'),
(14633555,'mesam22@gmail.com','QHIee1235',413872587939,'2002-07-18','Mesam 3','B+','356s6 avenue lorne','Engineer2'),
(18872,'mesam3@gmail.com','QHaaI1236',4387271187939,'2003-09-18','Mesam 4','A+','356s7 avenue lorne','Engineer3'),
(1469992,'mesam4@gmail.com','QHdddI1237',438721187939,'2004-01-18','Mesam 5','C+','356s9 avenue lorne','Engineer4'),
(1462,'mesDDam4@gmail.com','QHdddIE1237',4387921187939,'2004-01-18','Mesam 5','C+','356s9 avenue lorne','Engineer4')
;


INSERT INTO Couple (CoupleId, FatherId, MotherId) VALUES
(12,NULL,1),
(13,12,146),
(14,18872,14),
(15,NULL,14640),
(16,1462,1464660)
;



INSERT INTO HealthCareInstitute (instituteid, email, name, website,address, phoneno) VALUES
(11,'hc2@gmail.com','Hosp1','hc1.com','Montreal Area 1',43221133),
(12,'hc3@gmail.com','Lac-Saint-Louis','hc2.com','Montreal Area 2',432211122),
(13,'hc4@gmail.com','Hosp3','hc3.com','Montreal Area 3',432211111),
(14,'hc5@gmail.com','Hosp4','hc4.com','Montreal Area 4',4322111222),
(15,'hc6@gmail.com','Hosp5','hc5.com','Montreal Area 5',433322111222)
;

INSERT INTO Clinic (ClinicId, email, name, website, phoneno) VALUES
(88,'c2@gmail.com','cli','c1.com',4322116633),
(89,'c3@gmail.com','cli2','c2.com',43221516633),
(90,'c4@gmail.com','cli3','c3.com',43221116611),
(97,'c5@gmail.com','cli4','c4.com',432211126622),
(966,'c75@gmail.com','c7li4','c74.com',4322151126622)
;
INSERT INTO BirthingCenter (BcentreId, email, name, website, phoneno) VALUES
(8338,'b2@gmail.com','bli','b1.com',432211663443),
(83328,'b12@gmail.com','bli2','b2.com',432211644633),
(44588,'bnf2@gmail.com','bcli4','b3.com',4344422116633),
(8800,'bn@gmail.com','bcli5','b5.com',433322116633),
(82800,'bnww@gmail.com','bcwwli5','b5ww.com',43332266116633)
;


INSERT INTO Midwife ( PractitionerId, type, name, phoneNo, email, InstituteId) VALUES
(1277777,'Primary','Marion Girard',43392879999,'nhh1.com',11),
(146335777755,'Backup','Naniww',41398992587939,'nhh2.com',12),
(1887777772,'Backup','Naniaa',43872799911939,'n3j.com',11),
(14699777792,'Primary','Naniff',438721999189,'n.com',14),
(14699222292,'Primary','NaDDDniff',438333721997939,'n4hhhh.com',14),
(14699222200,'Primary','NqaDDDiff',138333721997939,'4hhhh.com',12)                                                                                      
;

INSERT INTO InfoSession ( SessionId, time, date, language, PractitionerId) VALUES
 (1277775557,'23.00.00','2001-05-18','English',1277777),
 (127777,'22.00.00','2003-05-16','Urdu',146335777755),
 (12557,'21.00.00','2002-05-15','Arabic',1887777772),
 (17775557,'18.00.00','2019-05-14','French',14699777792),
 (17775444557,'18.00.00','2019-05-14','French',14699777792)
;

Insert INTO SessionAttendanceMother(SessionId, MotherId) values
    (1277775557,1),
    (12557,146),
    (17775557,1827),
    (17775557,14640),
    (17775444557,1)
    ;

Insert INTO SessionAttendanceFather(SessionId, FatherId) values
    (1277775557,12),
    (12557,1462),
    (17775557,1462),
    (17775557,18872),
    (17775444557,1469992)
    ;

INSERT INTO Appointments (AppId, time, date, PractitionerId) VALUES
(1271,'23.00.00','2022-03-22',1277777),
(1255,'22.32.00','2022-03-24',1277777),
(125000,'21.17.00','2002-05-21',1887777772),
(17443,'18.11.00','2019-05-22',14699777792),
(1744113,'18.11.00','2019-05-22',14699777792),
(1,'23.00.00','2022-03-22',1277777),
(2,'22.32.00','2022-03-24',1277777),
(3,'21.17.00','2002-05-21',1887777772),
(4,'18.11.00','2019-05-22',14699777792),
(5,'18.11.00','2019-05-22',14699777792)
;


INSERT INTO Pregnancy (pregnancyid, pregcount, finalDueDate, menstrualduedate, ultrasoundduedate, estimatedduedate, MotherId,FatherId, appid, practitionerid, bcentreid ,isPregnant, givenBirth) VALUES
(12888727,5,'2022-07-19','2001-05-19','2001-05-19','2001-05-19',1,12,1271,1277777,8338,TRUE,False),
(1289988727,5,'2001-05-19','2001-05-19','2001-05-19','2001-05-19',146,NULL,1,1277777,8800,TRUE,false),
(12888999727,5,'2001-05-19','2001-05-19','2001-05-19','2001-05-19',14,NULL,1255,1277777,NULL,TRUE,false),
(12827,1,'2001-05-19','2001-05-19','2001-05-19','2001-05-19',1827,12,125000,1887777772,8800,TRUE,false),
(1282557,2,'2001-05-19','2001-05-19','2001-05-19','2001-05-19',1827,18872,2,1277777,8800,TRUE,false),
(1512,3,'2022-07-19','2001-05-19','2001-05-19','2001-05-19',1464660,18872,17443,146335777755,8800,TRUE,false),
(1514,4,NULL,'2001-05-19','2001-05-19','2022-07-19',1,18872,1744113,146335777755,8800,TRUE,false),
(1600,4,NULL,'2001-05-19','2001-05-19','2022-07-19',1827,18872,3,146335777755,8800,TRUE,false),
(1601,4,NULL,'2001-05-19','2001-05-19','2022-07-31',14640,1462,4,1277777,8800,TRUE,false)

;


INSERT INTO MeetingRecord (PregnancyId, AppId) VALUES
(12888727,1271),
(1289988727,1),
(12888999727,1255),
(12827,125000),
(1282557,2),
(1512,17443),
(1514,1744113),
(1600,3),
(1601,4)
;



INSERT INTO Notes (noteid, timestamp, details, observation, appid) VALUES
(177271,'9999-12-31-24.00.00.000000000','D1','ob1',1271),
(125577,'9999-12-31-24.00.00.000000000','D1','ob1',1271),
(12577000,'9999-12-31-24.00.00.000000000','D1','ob1',1255),
 (1777443,'9999-12-31-24.00.00.000000000','D1','ob1',17443),
(177337443,'9999-12-31-24.00.00.000000000','D1','ob1',17443)
;

INSERT INTO LabTechnician ( TechnicianId, TechnicianName, TechnicianCell) VALUES
(127777227,'LOLO',433879992879999),
(146335772227755,'BIKIK',413989972587939),
(188117777772,'BaLLOL',4387279991187939),
(146992,'PriOP',438721999187939),
(14694492,'PriOP',438721999187939)
;



INSERT INTO Baby (BabyId, name, gender, bloodType, DOB, birthTime, birthType, PregnancyId ) VALUES
(122222,'BABYA','M','O+','2001-05-19','23.00.00','One',1600),
(1222221111,'BABY22A','M33','O+','2001-05-19','23.00.00','One',1600),
(1222,'BABYB','M','O+','2001-05-19','23.00.00','One',1514),
(222,'BABYc','M','O+','2001-05-19','23.00.00','One',1512),
(122,'BABYd','F','O-','2022-05-19','21.00.00','One',1512),
(12332,'BABYe','F','O-','2022-05-19','21.00.00','One',1514)

;



iNSERT INTO MidWifePregnancyRecord (PregnancyId, PractitionerId, isPrimary) VALUES
(12888727,1277777,TRUE),
(1289988727,1277777,FALSE),
(12888999727,146335777755,TRUE),
(12827,1887777772,TRUE),
(1282557,1887777772,FALSE),
(1512,146335777755,FALSE),
(1514,146335777755,TRUE),
(1600,146335777755,FALSE),
(1601,1277777,TRUE)
;



INSERT INTO Test ( TestId, type, prescribedDate, labConductDate, sampleDate, resultDescription, PregnancyId, PractionerId, TechnicianId, BabyId) VALUES
 (12727,'Blood-Iron','2001-05-19','2001-05-19','2021-05-19','Normal',1282557,146335777755,127777227,222),
 (12729,'Blood-Iron','2001-06-19','2001-06-19','2021-06-19','abnormal',1282557,146335777755,127777227,222),
 (1279927,'Urine','2001-05-19','2001-05-19','2001-05-19','Good',12827,1887777772,188117777772,122),
 (12666727,'Urine','2001-05-19','2001-05-19','2001-05-19','Good',12888727,1887777772,188117777772,1222),
 (12744427,'Urine','2001-05-19','2001-05-19','2001-05-19','Good',12888999727,146335777755,127777227,1222),
 (1274664427,'Blood','2001-05-19','2004-05-19','2000-05-19','Good',12888999727,146335777755,127777227,1222)
;