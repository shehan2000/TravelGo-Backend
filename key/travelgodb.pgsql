--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: travelgodb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE travelgodb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE travelgodb OWNER TO postgres;

\connect travelgodb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AdminUser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AdminUser" (
    "UserID" uuid DEFAULT gen_random_uuid() NOT NULL,
    "Username" character varying(255),
    "FirstName" character varying(255),
    "LastName" character varying(255),
    "PasswordHash" character varying(255)
);


ALTER TABLE public."AdminUser" OWNER TO postgres;

--
-- Name: Booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Booking" (
    "BookingID" integer NOT NULL,
    "userID" uuid,
    "TrainID" integer,
    "isReturn" boolean DEFAULT false,
    "Source" integer,
    "Destination" integer,
    "BookedTime" timestamp without time zone,
    "Amount" double precision,
    "isPaid" boolean DEFAULT false
);


ALTER TABLE public."Booking" OWNER TO postgres;

--
-- Name: Booking_BookingID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Booking_BookingID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Booking_BookingID_seq" OWNER TO postgres;

--
-- Name: Booking_BookingID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Booking_BookingID_seq" OWNED BY public."Booking"."BookingID";


--
-- Name: Frequency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Frequency" (
    "FrequencyID" integer NOT NULL,
    "Name" character varying(255),
    "Monday" boolean DEFAULT false,
    "Tuesday" boolean DEFAULT false,
    "Wednesday" boolean DEFAULT false,
    "Thursday" boolean DEFAULT false,
    "Friday" boolean DEFAULT false,
    "Saturday" boolean DEFAULT false,
    "Sunday" boolean DEFAULT false
);


ALTER TABLE public."Frequency" OWNER TO postgres;

--
-- Name: Frequency_FrequencyID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Frequency_FrequencyID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Frequency_FrequencyID_seq" OWNER TO postgres;

--
-- Name: Frequency_FrequencyID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Frequency_FrequencyID_seq" OWNED BY public."Frequency"."FrequencyID";


--
-- Name: Passenger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Passenger" (
    "PassengerID" integer NOT NULL,
    "NIC" character varying(20),
    "Name" character varying(255),
    "IsMale" boolean,
    "Age" integer
);


ALTER TABLE public."Passenger" OWNER TO postgres;

--
-- Name: Payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Payments" (
    "PaymentID" integer NOT NULL,
    "BookingID" integer,
    "Timestamp" timestamp without time zone,
    "isSuccess" boolean DEFAULT false,
    "Response" character varying(255)
);


ALTER TABLE public."Payments" OWNER TO postgres;

--
-- Name: SeatBooking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SeatBooking" (
    "SeatBookingID" integer NOT NULL,
    "BookingID" integer,
    "WagonPosition" integer,
    "WagonID" integer,
    "SeatNo" integer
);


ALTER TABLE public."SeatBooking" OWNER TO postgres;

--
-- Name: SeatBooking_SeatBookingID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."SeatBooking_SeatBookingID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SeatBooking_SeatBookingID_seq" OWNER TO postgres;

--
-- Name: SeatBooking_SeatBookingID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."SeatBooking_SeatBookingID_seq" OWNED BY public."SeatBooking"."SeatBookingID";


--
-- Name: Station; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Station" (
    "StationID" integer NOT NULL,
    "StationName" character varying(255) NOT NULL
);


ALTER TABLE public."Station" OWNER TO postgres;

--
-- Name: Station_StationID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Station_StationID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Station_StationID_seq" OWNER TO postgres;

--
-- Name: Station_StationID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Station_StationID_seq" OWNED BY public."Station"."StationID";


--
-- Name: Train; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Train" (
    "TrainID" integer NOT NULL,
    "TrainNo" integer,
    "Date" date,
    "ChangedWagonsWithDirection" integer[]
);


ALTER TABLE public."Train" OWNER TO postgres;

--
-- Name: TrainSchedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TrainSchedule" (
    "TrainNo" integer NOT NULL,
    "TrainName" character varying(255),
    "Source" integer,
    "Destination" integer,
    "ArrivalTime" time without time zone,
    "DepartureTime" time without time zone,
    "TrainType" character varying(255),
    "Frequency" integer,
    "DefaultWagonsWithDirection" integer[],
    "InvertedStations" integer[],
    "DefaultTotalSeats" integer
);


ALTER TABLE public."TrainSchedule" OWNER TO postgres;

--
-- Name: TrainStop; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TrainStop" (
    "stopID" integer NOT NULL,
    "TrainNo" integer,
    "StationID" integer,
    "ArrivalTime" time without time zone,
    "DepartureTime" time without time zone,
    "Load" integer,
    "PlatformNo" integer
);


ALTER TABLE public."TrainStop" OWNER TO postgres;

--
-- Name: TrainStop_stopID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TrainStop_stopID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."TrainStop_stopID_seq" OWNER TO postgres;

--
-- Name: TrainStop_stopID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TrainStop_stopID_seq" OWNED BY public."TrainStop"."stopID";


--
-- Name: Train_TrainID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Train_TrainID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Train_TrainID_seq" OWNER TO postgres;

--
-- Name: Train_TrainID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Train_TrainID_seq" OWNED BY public."Train"."TrainID";


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "UserID" uuid DEFAULT gen_random_uuid() NOT NULL,
    "Username" character varying(255),
    "FirstName" character varying(255),
    "LastName" character varying(255),
    "Birthday" date,
    "PhoneNo" character varying(20),
    "NIC" character varying(15),
    "Address" character varying(255),
    "PasswordHash" character varying(255),
    "EmailConfirmed" boolean DEFAULT false
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: Wagon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Wagon" (
    "WagonID" integer NOT NULL,
    "Capacity" integer,
    "Class" character varying(255),
    "SeatNoScheme" text[],
    "Description" character varying(255),
    "HasTables" boolean DEFAULT false,
    "Amenities" text[]
);


ALTER TABLE public."Wagon" OWNER TO postgres;

--
-- Name: Wagon_WagonID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Wagon_WagonID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Wagon_WagonID_seq" OWNER TO postgres;

--
-- Name: Wagon_WagonID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Wagon_WagonID_seq" OWNED BY public."Wagon"."WagonID";


--
-- Name: Booking BookingID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking" ALTER COLUMN "BookingID" SET DEFAULT nextval('public."Booking_BookingID_seq"'::regclass);


--
-- Name: Frequency FrequencyID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Frequency" ALTER COLUMN "FrequencyID" SET DEFAULT nextval('public."Frequency_FrequencyID_seq"'::regclass);


--
-- Name: SeatBooking SeatBookingID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SeatBooking" ALTER COLUMN "SeatBookingID" SET DEFAULT nextval('public."SeatBooking_SeatBookingID_seq"'::regclass);


--
-- Name: Station StationID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Station" ALTER COLUMN "StationID" SET DEFAULT nextval('public."Station_StationID_seq"'::regclass);


--
-- Name: Train TrainID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Train" ALTER COLUMN "TrainID" SET DEFAULT nextval('public."Train_TrainID_seq"'::regclass);


--
-- Name: TrainStop stopID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TrainStop" ALTER COLUMN "stopID" SET DEFAULT nextval('public."TrainStop_stopID_seq"'::regclass);


--
-- Name: Wagon WagonID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Wagon" ALTER COLUMN "WagonID" SET DEFAULT nextval('public."Wagon_WagonID_seq"'::regclass);


--
-- Data for Name: AdminUser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AdminUser" ("UserID", "Username", "FirstName", "LastName", "PasswordHash") FROM stdin;
acf3faf8-19af-4223-b425-c5fdb8cbb6a4	movin@gmail.com	Movin	Silva	$2a$10$0Ssd8v7wW8KhT3M3V48o7.vaco8k.HSvydtYKVoLfuolpl3ltJTkO
fbb0aa04-cd2b-4a8c-930f-ba082adc4112	movin1@gmail.com	Movin	Silva	$2a$10$2sieW2O98iPwtSU.GNg.Sulqa7sTq4YhBYHh9lSdi8nIV7gVXpDCa
\.


--
-- Data for Name: Booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Booking" ("BookingID", "userID", "TrainID", "isReturn", "Source", "Destination", "BookedTime", "Amount", "isPaid") FROM stdin;
16	15571d9e-10a8-4e2d-b269-e7e4b61eae20	1	f	101	201	2023-09-11 01:27:29.112585	373.26	t
17	2452a9d7-74ce-4b70-ac52-acadc2e3ca8c	2	t	102	202	2023-09-11 01:27:29.112585	432.47	t
18	3dc75c2a-e783-4fc6-8f7f-903e1debb088	3	f	103	203	2023-09-11 01:27:29.112585	437.13	t
19	3de41578-5887-456b-b0b3-f25adf611094	4	t	104	204	2023-09-11 01:27:29.112585	1981.41	t
20	48f29f5f-b239-4bd9-954d-d65f369160b6	5	f	105	205	2023-09-11 01:27:29.112585	1559.29	t
21	48f79d96-a4d9-4322-a0cf-e711274cb538	6	t	106	206	2023-09-11 01:27:29.112585	1418.8	t
22	52cf66af-576c-4199-bdec-5e937d219fe7	7	f	107	207	2023-09-11 01:27:29.112585	1842.74	t
23	5a3ea9cd-b449-47ea-8873-b2557da278d9	8	t	108	208	2023-09-11 01:27:29.112585	1763.37	t
24	5e938b7b-2328-4bdb-b705-d7cb18b0eb1b	9	f	109	209	2023-09-11 01:27:29.112585	368.64	t
25	6225b96b-1520-4d0e-8501-1b0702c7755b	10	t	110	210	2023-09-11 01:27:29.112585	683.51	t
26	6876310d-b1b1-4e43-8f8e-331a10b765c1	11	f	111	211	2023-09-11 01:27:29.112585	1686.77	t
27	68e4eb75-7fcc-4bc5-b2e2-2ac81ad0b585	12	t	112	212	2023-09-11 01:27:29.112585	332.77	t
28	6bed8ed9-d0a5-46ba-87d5-e5c2c9b6ef9a	13	f	113	213	2023-09-11 01:27:29.112585	806.27	t
29	6bed8ed9-d0a5-46ba-87d5-e5c2c9b6ef9a	14	t	114	214	2023-09-11 01:27:29.112585	635.39	t
30	6bed8ed9-d0a5-46ba-87d5-e5c2c9b6ef9a	15	f	115	215	2023-09-11 01:27:29.112585	700.41	t
31	15571d9e-10a8-4e2d-b269-e7e4b61eae20	1	f	101	201	2023-01-15 08:30:00	500.5	t
32	2452a9d7-74ce-4b70-ac52-acadc2e3ca8c	2	f	102	202	2023-02-20 09:45:00	750.75	t
33	3dc75c2a-e783-4fc6-8f7f-903e1debb088	3	t	103	203	2023-03-10 15:20:00	800.25	f
34	3de41578-5887-456b-b0b3-f25adf611094	4	f	104	204	2023-04-05 14:15:00	600	t
35	48f29f5f-b239-4bd9-954d-d65f369160b6	5	f	105	205	2023-05-12 07:55:00	950.3	t
36	48f79d96-a4d9-4322-a0cf-e711274cb538	1	t	101	201	2023-06-18 12:10:00	450.2	f
37	52cf66af-576c-4199-bdec-5e937d219fe7	2	f	102	202	2023-07-22 16:30:00	700.1	t
38	5a3ea9cd-b449-47ea-8873-b2557da278d9	3	f	103	203	2023-08-08 10:45:00	850.8	t
39	5e938b7b-2328-4bdb-b705-d7cb18b0eb1b	4	t	104	204	2023-09-25 09:15:00	900	t
40	6225b96b-1520-4d0e-8501-1b0702c7755b	5	f	105	205	2023-10-30 17:40:00	600.6	t
41	6876310d-b1b1-4e43-8f8e-331a10b765c1	1	f	101	201	2023-11-07 18:25:00	750.9	f
42	68e4eb75-7fcc-4bc5-b2e2-2ac81ad0b585	2	t	102	202	2023-12-12 13:50:00	550.25	t
43	6bed8ed9-d0a5-46ba-87d5-e5c2c9b6ef9a	3	f	103	203	2023-01-05 08:15:00	400.75	t
44	15571d9e-10a8-4e2d-b269-e7e4b61eae20	1	f	101	201	2023-02-10 09:30:00	550.5	t
45	2452a9d7-74ce-4b70-ac52-acadc2e3ca8c	2	f	102	202	2023-03-15 11:45:00	600.25	t
46	3dc75c2a-e783-4fc6-8f7f-903e1debb088	3	f	103	203	2023-04-20 13:00:00	750	t
47	3de41578-5887-456b-b0b3-f25adf611094	4	f	104	204	2023-05-25 14:15:00	450.9	t
48	48f29f5f-b239-4bd9-954d-d65f369160b6	5	f	105	205	2023-06-30 15:30:00	900.6	t
49	48f79d96-a4d9-4322-a0cf-e711274cb538	1	t	101	201	2023-07-05 16:45:00	800.2	t
50	52cf66af-576c-4199-bdec-5e937d219fe7	2	f	102	202	2023-08-10 18:00:00	700.8	t
51	5a3ea9cd-b449-47ea-8873-b2557da278d9	3	f	103	203	2023-09-15 19:15:00	550.5	t
52	5e938b7b-2328-4bdb-b705-d7cb18b0eb1b	4	t	104	204	2023-10-20 20:30:00	650.25	t
53	6225b96b-1520-4d0e-8501-1b0702c7755b	5	f	105	205	2023-11-25 21:45:00	700	t
54	6876310d-b1b1-4e43-8f8e-331a10b765c1	1	f	101	201	2023-12-30 22:00:00	600.9	t
55	68e4eb75-7fcc-4bc5-b2e2-2ac81ad0b585	2	t	102	202	2023-01-02 23:15:00	800.8	t
56	6bed8ed9-d0a5-46ba-87d5-e5c2c9b6ef9a	3	f	103	203	2023-02-05 08:30:00	950.5	t
57	15571d9e-10a8-4e2d-b269-e7e4b61eae20	1	f	101	201	2023-03-10 09:45:00	350.25	t
58	2452a9d7-74ce-4b70-ac52-acadc2e3ca8c	2	f	102	202	2023-04-15 11:00:00	550	t
59	3dc75c2a-e783-4fc6-8f7f-903e1debb088	3	f	103	203	2023-05-20 12:15:00	700.9	t
60	3de41578-5887-456b-b0b3-f25adf611094	4	f	104	204	2023-06-25 13:30:00	450.8	t
61	48f29f5f-b239-4bd9-954d-d65f369160b6	5	f	105	205	2023-07-30 14:45:00	650.5	t
62	48f79d96-a4d9-4322-a0cf-e711274cb538	1	t	101	201	2023-08-04 16:00:00	850.25	t
63	15571d9e-10a8-4e2d-b269-e7e4b61eae20	1	f	101	201	2022-01-15 08:30:00	500	t
64	2452a9d7-74ce-4b70-ac52-acadc2e3ca8c	2	f	102	202	2022-02-20 14:45:00	750	t
65	3dc75c2a-e783-4fc6-8f7f-903e1debb088	3	t	103	203	2022-03-10 10:15:00	600	t
66	3de41578-5887-456b-b0b3-f25adf611094	4	f	104	204	2022-04-05 12:00:00	450	t
67	48f29f5f-b239-4bd9-954d-d65f369160b6	5	t	105	205	2022-05-18 16:30:00	700	t
68	48f79d96-a4d9-4322-a0cf-e711274cb538	6	f	106	206	2022-06-23 09:20:00	800	t
69	52cf66af-576c-4199-bdec-5e937d219fe7	7	f	107	207	2022-07-07 17:55:00	550	t
70	5a3ea9cd-b449-47ea-8873-b2557da278d9	8	t	108	208	2022-08-12 11:40:00	900	t
71	5e938b7b-2328-4bdb-b705-d7cb18b0eb1b	9	f	109	209	2022-09-30 18:10:00	650	t
72	6225b96b-1520-4d0e-8501-1b0702c7755b	10	t	110	210	2022-10-22 13:25:00	850	t
\.


--
-- Data for Name: Frequency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Frequency" ("FrequencyID", "Name", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday") FROM stdin;
1	Weekdays	t	t	t	t	t	f	f
2	Weekends Only	f	f	f	f	f	t	t
\.


--
-- Data for Name: Passenger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Passenger" ("PassengerID", "NIC", "Name", "IsMale", "Age") FROM stdin;
\.


--
-- Data for Name: Payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Payments" ("PaymentID", "BookingID", "Timestamp", "isSuccess", "Response") FROM stdin;
\.


--
-- Data for Name: SeatBooking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SeatBooking" ("SeatBookingID", "BookingID", "WagonPosition", "WagonID", "SeatNo") FROM stdin;
\.


--
-- Data for Name: Station; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Station" ("StationID", "StationName") FROM stdin;
1	ABANPOLA
2	ADAGALA
3	AGBOPURA
4	AHANGAMA
5	AHUNGALLE
6	AKURALA
7	ALAWATUPITIYA
8	ALAWWA
9	ALUTH AMBALAMA
10	ALUTHGAMA
11	AMBALANGODA
12	AMBEWELA
13	AMBEYPUSSA
14	ANAWILUNDAWA
15	ANDADOLA
16	ANGAMPITIYA
17	ANGULANA
18	ANURADHAPURA
19	ANURADHAPURA TOWN
20	ARACHCHIKATTUWA
21	ARAPATHGAMA
22	ARIVIAL NAGAR
23	ARUKKUWATTE
24	ASELAPURA
25	ASGIRIYA
26	AUKANA
27	AVISSAWELLA
28	BADULLA
29	BALANA
30	BALAPITIYA
31	BAMBALAPITIYA
32	BAMBARENDA
33	BANDARAWELA
34	BANDIRIPPUWA
35	BANGADENIYA
36	BASELINE ROAD
37	BATTALUOYA
38	BATTICALOA
39	BATUWATTE
40	BELIATHTHA
41	BEMMULLA
42	BENTOTA
43	BERUWALA
44	BOLAWATTE
45	BOOSSA
46	BORELESSA
47	BOTALE
48	BULUGAHAGODA
49	BUTHGAMUWA
50	CHAVAKACHCHERI
51	CHEDDIIKULAM
52	CHILAW
53	CHINA BEY
54	CHUNNAKAM
55	COLOMBO FORT
56	COTTA ROAD
57	DARALUWA
58	DEHIWALA
59	DEKINDA
60	DEMATAGODA
61	DEMODARA
62	DEWAPURAM
63	DEWEDDA
64	DIYATALAWA
65	DODANDUWA
66	EGODA UYANA
67	ELIPHANT PASS
68	ELLE
69	ELUTHUMATTUVAL
70	ELWALA
71	ENDERAMULLA
72	ERATTAPERIYAKULAM
73	ERAVUR
74	ERUKKALAM PENDU
75	FREE TRADE ZONE
76	GALABODA
77	GALGAMUWA
78	GALLE
79	GALLELLA
80	GALOYA JUNCTION
81	GAMMANA
82	GAMPAHA
83	GAMPOLA
84	GANEGODA
85	GANEMULLA
86	GANEWATTE
87	GANGATHILAKA
88	GANGODA
89	GANTALAWA
90	GELIOYA
91	GINTHOTA
92	GIRAMBE
93	GODAGAMA
94	GREAT WESTERN
95	HABARADUWA
96	HABARANA
97	Hadiriwalana
98	HALIELA
99	HAPUTALE
100	HATAMUNA
101	HATARAS KOTUWA
102	HATTON
103	HEEL OYA
104	HEENDENIYA
105	HETTIMULLA
106	HIKKADUWA
107	HINGURAKGODA
108	HINGURALA
109	HIRIYALA
110	HOMAGAMA
111	HOMAGAMA HOSPITAL
112	HORAPE
113	HORIWIALA
114	HUNUPITIYA
115	HYINPORT
116	IDALGASINNA
117	IHALAGAMA
118	IHALAKOTTE
119	IHALAWATAWALA
120	INDURUWA
121	INGURUOYA
122	INUVIL
123	JA-ELA
124	JAFFNA
125	JAYANTHIPURA
126	KADADASI NAGAR
127	KADIGAMUWA
128	KADUGANNAWA
129	KADUGODA
130	KAHATAPITIYA
131	KAHAWA
132	KAKKAPALLIYA
133	KALAWEWA
134	KALKUDAH
135	KALUTARA NORTH
136	KALUTARA SOUTH
137	KAMBURUGAMUWA
138	KANDANA
139	KANDEGODA
140	KANDY
141	KANKESANTHURAI
142	KANTALE
143	KAPUWATTE
144	KARADIPUWAL
145	KATHALUWA
146	KATTUWA
147	KATUGASTOTA
148	KATUGASTOTA ROAD
149	KATUGODA
150	KATUKURUNDA
151	KATUNAYAKA AIRPORT
152	KATUNAYAKE
153	KEENAWALA
154	KEKANADURA
155	KEKIRAWA
156	KELANIYA
157	KILINOCHCHI
158	KINIGAMA
159	KIRINDIWELA
160	KIRULAPANA
161	KITAL ELLE
162	KOCHCHIKADE
163	KODIKAMAM
164	KOGGALA
165	KOHOMBILIWALA
166	KOKUVIL
167	KOLLUPITIYA
168	KOLONNAWA
169	KOLONNAWA
170	KOLONNAWA
171	KOMPANNAVEDIYA
172	KONDAVIL
173	KONWEWA
174	KORALAWELLA
175	KOSGAMA
176	KOSGODA
177	KOSHINNA
178	KOTAGALA
179	KOTTAWA
180	KUDA WAWA
181	KUDAHAKAPOLA
182	KUMARAKANDA
183	KUMBALGAMA
184	KURAHANHENAGAMA
185	KURANA
186	KURUNEGALA
187	LAKSAUYANA
188	LIYANAGEMULLA
189	LIYANWALA
190	LUNAWA
191	LUNUWILA
192	MADAMPAGAMA
193	MADAMPE
194	MADHU ROAD
195	MADURANKULIYA
196	MAGALEGODA
197	MAGGONA
198	MAGULEGODA
199	MAHAIYAWA
200	MAHARAGAMA
201	MAHO
202	MAKUMBURA
203	MALLAKAM
204	MANAMPITIYA
205	MANGALAELIYA
206	MANKULAM
207	MANNAR
208	MANUWANGAMA
209	MARADANA
210	MARAKONA
211	MARALUWEWA
212	MATALE
213	MATARA
214	MATHOTTAM
215	MAVILMADA
216	MAVITTAPURAM
217	MEDAGAMA
218	MEDAWACHCHIYA
219	MEDDEGAMA
220	MEEGAMMANA
221	MEEGODA
222	MEESALAI
223	MHA INDURUWA
224	MIDIGAMA
225	MIHINTALE
226	MIHINTALE JUNCTION
227	MINNERIYA
228	MIRIGAMA
229	MIRIHANPITIGAMA
230	MIRISSA
231	MIRISWATTA
232	MIRUSUVIL
233	MOLLIPATANA
234	MORAGOLLAGAMA
235	MORAKELE
236	MORATUWA
237	MOUNT LAVINIA
238	MUNDAL
239	MURIKANDY
240	MURUNKAN
241	MUTHTHETTUGALA
242	NAGOLLAGAMA
243	NAILIYA
244	NAKULUGAMUWA
245	NANUOYA
246	NARAHENPITA
247	NATTANDIYA
248	NAVATKULI
249	NAWALAPITIYA
250	NAWINNA
251	NEGAMA
252	NEGOMBO
253	NELUMPATHGAMA
254	NELUMPOKUNA
255	NERIYAKULAM
256	NOORANAGAR
257	NUGEGODA
258	OHIYA
259	OMANTHAI
260	PADUKKA
261	PAHALAWARDHANA
262	PALAVI
263	PALLAI
264	PALLE TALAVINNA
265	PALLEWALA
266	PALUGASWEWA
267	PANADURA
268	PANAGODA
269	PANALEEYA
270	PANGIRIWATTA
271	PANNIPITIYA
272	PARAKUMUYANA
273	PARANTHAN
274	PARASANGAHAWEWA
275	PATAGAMGODA
276	PATHANPAHA
277	PATTIPOLA
278	PAYAGALA NORTH
279	PAYAGALA SOUTH
280	PEMROSE
281	PERADENIYA
282	PERAKUMPURA
283	PERALANDA
284	PERIYANAGAVILLU
285	PESALAI
286	PILADUWA
287	PILIDUWA
288	PILIMATALAWA
289	PINNAGOLLA
290	PINNAWALA
291	PINWATTE
292	PIYADIGAMA
293	PIYAGAMA
294	POLGAHA ANGA
295	POLGAHAWELA
296	POLONNARUWA
297	POLWATHUMODARA
298	POONEWA
299	PORAPOLA
300	PORAPOLA JUNC.
301	POTUHERA
302	PULACHCHIKULAM
303	PULIYANKULAM
304	PUNANI
305	PUNKANKULAM
306	PUTTALAM
307	PUWAKPITIYA
308	PUWAKPITIYA TOWN
309	RADELLA
310	RAGAMA
311	RAMBUKKANA
312	RANAMUGGAMUWA
313	RANDENIGAMA
314	RATHGAMA
315	RATMALANA
316	REDEETHENNA
317	RICHMOND HILL
318	ROSELLA
319	SALIYAPURA
320	SANKATHANAI
321	SARASAVIUYANA
322	SAWARANA
323	SECRETARIAL HALT
324	SEEDUWA
325	SEENIGAMA
326	SENARATHGAMA
327	SEVANAPITIYA
328	SIYABALANGAMUWA
329	SIYALANGAMUWA
330	SRAWASTHIPURA
331	TALAIMANNAR
332	TALAIMANNAR PIER
333	TALAWA
334	TALAWAKELE
335	TALAWATTEGEDARA
336	TAWALANOYA
337	TELLIPALLAI
338	TELWATTE
339	TEMBLIGALA
340	THACHANTHOPPU
341	THALPE
342	THAMBAGALLA
343	THAMBALAGAMUWA
344	THAMBUTTEGAMA
345	THANDIKULAM
346	THIIRUKETHEESWARAM
347	THILLADIYA
348	THIRANAGAMA
349	THODDAVELI
350	THURULIYAGAMA
351	TIMBIRIYAGEDARA
352	TISMALPOLA
353	TRAIN HALT 01
354	TRINCOMALEE
355	TUDELLA
356	TUMMODARA
357	UDATALAWINNA
358	UDATHTHAWALA
359	UDHAMULLA
360	UDUGODAGAMA
361	UDUWARA
362	UGGALLA
363	UKUWELA
364	ULAPANE
365	UNAWATUNA
366	Urugodawattha
367	UYANGALLA
368	VALACHCHENEI
369	VANDARAMULLAI
370	VAVUNIYA
371	VEYANGODA
372	VIRALMURIPPUWA
373	WADDUWA
374	WAGA
375	WAIKKALA
376	WALAHAPITIYA
377	WALASWEWA
378	WALGAMA
379	WALPOLA
380	WANAWASALA
381	WANDURAWA
382	WATAGODA
383	WATARAKA
384	WATAWALA
385	WATTEGAMA
386	WEHERAHENA
387	Weligalla
388	WELIGAMA
389	WELIKANDA
390	WELLAWA
391	WELLAWATTA
392	WERAGALA
393	WEWURUKANNALA
394	WIJAYARAJADAHANA
395	WILWATTE
396	WLAKUBURA
397	YAGODA
398	YAPAHUWA
399	YATAGAMA
400	YATAWARA
401	YATIRAWANA
402	YATTALGODA
\.


--
-- Data for Name: Train; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Train" ("TrainID", "TrainNo", "Date", "ChangedWagonsWithDirection") FROM stdin;
1	1001	2023-08-01	\N
2	1002	2023-08-02	\N
3	1003	2023-08-03	\N
4	1004	2023-08-04	\N
5	1005	2023-08-05	\N
6	1006	2023-08-06	\N
7	1007	2023-08-07	\N
8	1008	2023-08-08	\N
9	1009	2023-08-09	\N
10	1010	2023-08-10	\N
11	1011	2023-08-11	\N
12	1012	2023-08-12	\N
13	1013	2023-08-13	\N
14	1014	2023-08-14	\N
15	1015	2023-08-15	\N
\.


--
-- Data for Name: TrainSchedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TrainSchedule" ("TrainNo", "TrainName", "Source", "Destination", "ArrivalTime", "DepartureTime", "TrainType", "Frequency", "DefaultWagonsWithDirection", "InvertedStations", "DefaultTotalSeats") FROM stdin;
8716	COLOMBO COMMUTER	209	136	05:30:00	07:05:00	COMMUTER	1	{{1,0},{1,0},{2,1}}	{250}	300
1001	Express 1	101	201	08:00:00	09:30:00	Express	1	{{1,2},{3,4}}	{1,3}	150
1002	Local 1	102	202	07:30:00	10:00:00	Local	2	{{2,1},{4,3}}	{2,4}	100
1003	Fast 1	103	203	09:15:00	11:45:00	Fast	1	{{1,3},{2,4}}	{1,2}	200
1004	Express 2	104	204	10:00:00	12:30:00	Express	2	{{3,1},{4,2}}	{3,4}	180
1005	Local 2	105	205	12:30:00	14:00:00	Local	1	{{1,4},{3,2}}	{1,3}	120
1006	Express 3	106	206	08:45:00	11:15:00	Express	2	{{1,4},{2,3}}	{2,4}	170
1007	Local 3	107	207	06:30:00	08:00:00	Local	1	{{3,2},{4,1}}	{1,2}	110
1008	Fast 2	108	208	10:20:00	12:50:00	Fast	2	{{2,1},{4,3}}	{3,4}	190
1009	Express 4	109	209	11:15:00	13:45:00	Express	1	{{1,3},{2,4}}	{1,2}	160
1010	Local 4	110	210	14:30:00	16:00:00	Local	1	{{3,4},{1,2}}	{2,3}	130
1011	Fast 3	111	211	16:45:00	19:15:00	Fast	2	{{2,4},{3,1}}	{1,4}	210
1012	Express 5	112	212	18:30:00	21:00:00	Express	1	{{4,1},{3,2}}	{2,4}	140
1013	Local 5	113	213	05:00:00	07:30:00	Local	2	{{1,2},{3,4}}	{1,3}	90
1014	Express 6	114	214	08:15:00	10:45:00	Express	2	{{1,3},{2,4}}	{1,4}	220
1015	Local 6	115	215	09:30:00	12:00:00	Local	1	{{3,1},{4,2}}	{2,3}	180
1016	Fast 4	116	216	12:45:00	15:15:00	Fast	2	{{4,3},{2,1}}	{1,2}	170
1017	Express 7	117	217	14:00:00	16:30:00	Express	1	{{1,4},{2,3}}	{3,4}	150
1018	Local 7	118	218	16:15:00	18:45:00	Local	2	{{4,2},{3,1}}	{1,4}	200
1019	Fast 5	119	219	19:30:00	22:00:00	Fast	1	{{2,4},{1,3}}	{2,3}	120
1020	Express 8	120	220	20:45:00	23:15:00	Express	2	{{3,1},{4,2}}	{1,2}	250
1021	Local 8	121	221	05:30:00	08:00:00	Local	1	{{1,2},{3,4}}	{1,3}	130
1022	Fast 6	122	222	07:15:00	09:45:00	Fast	2	{{2,3},{4,1}}	{3,4}	170
1023	Express 9	123	223	09:30:00	12:00:00	Express	1	{{4,3},{1,2}}	{2,4}	190
1024	Local 9	124	224	11:15:00	13:45:00	Local	1	{{1,4},{2,3}}	{1,4}	140
1025	Fast 7	125	225	13:30:00	16:00:00	Fast	2	{{3,2},{4,1}}	{1,2}	210
\.


--
-- Data for Name: TrainStop; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TrainStop" ("stopID", "TrainNo", "StationID", "ArrivalTime", "DepartureTime", "Load", "PlatformNo") FROM stdin;
1	8716	101	08:00:00	08:05:00	7	1
2	8716	205	08:20:00	08:25:00	3	2
3	8716	308	08:40:00	08:45:00	9	1
4	8716	112	09:00:00	09:05:00	5	3
5	8716	315	09:20:00	09:25:00	8	2
6	8716	118	09:40:00	09:45:00	2	1
7	8716	220	10:00:00	10:05:00	6	4
8	8716	323	10:20:00	10:25:00	10	3
9	8716	129	10:40:00	10:45:00	4	2
10	8716	235	11:00:00	11:05:00	1	1
11	1001	101	08:00:00	08:15:00	30	1
12	1001	102	08:30:00	08:45:00	25	2
13	1001	103	09:00:00	09:15:00	20	1
14	1001	104	09:30:00	09:45:00	22	3
15	1001	105	10:00:00	10:15:00	28	2
16	1002	101	07:30:00	07:45:00	24	1
17	1002	102	08:00:00	08:15:00	27	2
18	1002	103	08:30:00	08:45:00	29	1
19	1002	104	09:00:00	09:15:00	21	3
20	1002	105	09:30:00	09:45:00	26	2
21	1003	101	09:15:00	09:30:00	18	1
22	1003	102	09:45:00	10:00:00	23	2
23	1003	103	10:15:00	10:30:00	19	1
24	1003	104	10:45:00	11:00:00	31	3
25	1003	105	11:15:00	11:30:00	27	2
26	1004	101	10:00:00	10:15:00	30	1
27	1004	102	10:30:00	10:45:00	25	2
28	1004	103	11:00:00	11:15:00	20	1
29	1004	104	11:30:00	11:45:00	22	3
30	1004	105	12:00:00	12:15:00	28	2
31	1005	101	12:30:00	12:45:00	24	1
32	1005	102	12:45:00	13:00:00	27	2
33	1005	103	13:15:00	13:30:00	29	1
34	1005	104	13:45:00	14:00:00	21	3
35	1005	105	14:15:00	14:30:00	26	2
36	1006	101	15:00:00	15:15:00	28	1
37	1006	102	15:30:00	15:45:00	23	2
38	1006	103	16:00:00	16:15:00	19	1
39	1006	104	16:30:00	16:45:00	31	3
40	1006	105	17:00:00	17:15:00	27	2
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("UserID", "Username", "FirstName", "LastName", "Birthday", "PhoneNo", "NIC", "Address", "PasswordHash", "EmailConfirmed") FROM stdin;
52cf66af-576c-4199-bdec-5e937d219fe7	nadeesha@gmail.com	Nadeesha	Some	\N	\N	\N	\N	\N	f
6225b96b-1520-4d0e-8501-1b0702c7755b	shehan@gmail.com	shehan	cli	\N	\N	\N	\N	\N	f
740fa403-dd85-4bfe-a535-19ec85feacc2	john2@gmail.com	John Doe 2	\N	\N	\N	\N	\N	$2a$10$odoY.6Q1BImRg53ZMQG7buN3j0LwuXeWG2hY7jZpngFprzuCP/gv6	f
6876310d-b1b1-4e43-8f8e-331a10b765c1	john3@gmail.com	John Doe 3	\N	\N	\N	\N	\N	$2a$10$XvpX2JrpCWFA0JZfEuPtK.0P04yVldcYEvUaSMSRH7t0HEmJ/arsu	f
a49d6f49-4ab1-42d1-880f-297aa72b4395	john4@gmail.com	John Doe 4	\N	\N	\N	\N	\N	$2a$10$00a8FN0v/75YBtzwJ8mrUuE7YgUCbBLm6adS8zZF56/ZmZGpNphhq	f
48f29f5f-b239-4bd9-954d-d65f369160b6	john5@gmail.com	John Doe 5	\N	\N	\N	\N	\N	$2a$10$VWZtgiqW4Clks/CP6UXo2ebebfHMADvrzIl01gFN7kVX.YomyUQMK	f
3dc75c2a-e783-4fc6-8f7f-903e1debb088	john6@gmail.com	John Doe 6	\N	\N	\N	\N	\N	$2a$10$8kbTSym7cHmjO6K4UHgiOuk6XnLQBOZtSWfjLX9Ov7tEHD.KlRi1C	f
9aa15891-643a-405e-8ae5-5a3df01b417d	john7@gmail.com	John Doe 7	\N	\N	\N	\N	\N	$2a$10$HEjUhJ5uV72FL1yNIoozxudlTxVSrOS87NnCPIliGgNe0tJdmD3ay	f
5a3ea9cd-b449-47ea-8873-b2557da278d9	john8@gmail.com	John Doe 8	\N	\N	\N	\N	\N	$2a$10$DxP2SdlgCH7.nZOlrT//qecNL9OobV.sn8gufcxcvOGEujPWWxxfC	f
78aaccca-a3aa-46a0-a9c2-c8868b16ddec	john9@gmail.com	John Doe 9	Doe	\N	\N	\N	\N	$2a$10$AMgwqZo2vKSiYgrAaSTV2uLlT5kQCwfeFRfobrJwZ1a/jp.fArlDW	f
3de41578-5887-456b-b0b3-f25adf611094	john10@gmail.com	John Doe 10	Doe	\N	\N	\N	\N	$2a$10$yYEL391pOwpecRa91XmUW.bj5CoyB7bxAM.4De7xhK9AEJ.RanUzi	f
2452a9d7-74ce-4b70-ac52-acadc2e3ca8c	john11@gmail.com	John Doe 11	Doe	\N	\N	\N	\N	$2a$10$wRIghd5appblxSpCzh2w9OLbNoFBjUgwEfWr.T9VBvsZGYhQfvo96	f
6bed8ed9-d0a5-46ba-87d5-e5c2c9b6ef9a	john12@gmail.com	John Doe 12	Doe	\N	\N	\N	\N	$2a$10$t8xRPpo1m2EOZbANE5KjjeupJcA0jxpC5Ssumg/2AwV0Kf729qo6u	f
68e4eb75-7fcc-4bc5-b2e2-2ac81ad0b585	john13@gmail.com	John Doe 13	Doe	\N	\N	\N	\N	$2a$10$mnNC15IExHgEACGz0sdDlOoPv5uwXFz5ajDTyiFTDUa6w6zgi3saG	f
95acb3b2-1685-4dc8-80dd-c104caf8ecd4	john14@gmail.com	John Doe 14	Doe	\N	\N	\N	\N	$2a$10$513Upxk8iw85q1tsCJf.0.hVgslK58n7NpeG/bDOBHoMLuDLnUZBm	f
73a94b60-a08f-4229-838e-45852b2cc41f	john15@gmail.com	John Doe 1	Doe	\N	\N	\N	\N	$2a$10$izWzSEiWQXRDN922QWftQ.W9J4..3TZ6KkSfS115T3Y.r.80mS0iu	f
ed449e7a-7afb-4848-a2ae-25bff2d01cfc	john17@gmail.com	John Doe 	Doe	\N	\N	\N	\N	$2a$10$uYVHfoI2ugrm2dSwYiDeXutVdx66cFnU9j6/jDDiwHfqusxMh7Yce	f
48f79d96-a4d9-4322-a0cf-e711274cb538	john18@gmail.com	John Doe	Doe	\N	\N	\N	\N	$2a$10$B5ju5sfyZfXxBZXJScTcjOXyfUlaCxG7rmBDZdyrwX6KUvbyp1hue	f
6f88fe7b-c83f-40fc-b85e-bd49aed579c7		\N	\N	\N	\N	\N	\N	\N	f
ec4a47fc-0f3f-4a7e-ae6d-5a99183f5d48	shehan1@gmail.com	\N	\N	\N	\N	\N	\N	\N	f
5e938b7b-2328-4bdb-b705-d7cb18b0eb1b	shehanw@gmail.com	Sh	sg	\N	\N	\N	\N	\N	f
da121408-18dc-46ba-840d-7c68e3e48767	admin@cse.com	aa	aa	\N	\N	\N	\N	\N	f
9ec7b042-b5ea-4bef-af18-67abec64552c	admina@cse.com	as	as	\N	\N	\N	\N	$2a$10$wJTw2Y541/TwuENZv5uveunICU4u1XSTp1VrzwW5ykPVdaOaS1j/a	f
a426f1fc-f214-40a0-8bf4-bbcada4d9a03	adqmina@cse.com	q	w	\N	\N	\N	\N	$2a$10$jQ8snrr.0FD5CpbsDlQu5esz5v/V4hjNYjSeHsXRK7AxF9cmicvTW	f
84b2af85-4964-498c-9139-0af60c01803e	q@gmail.com	q	q	\N	\N	\N	\N	$2a$10$fzropARwN4TbKCRyccO.qui7YoSxqJau8WmF68R8XuKBsK6eKlQGe	f
15571d9e-10a8-4e2d-b269-e7e4b61eae20	john19@gmail.com	John Doe	Doe	\N	\N	\N	\N	$2a$10$pcfzIlYqK6TVF1aUDmHkOu0a1UYSrfiHvgYkASOh3J2004i3.KBL.	f
\.


--
-- Data for Name: Wagon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Wagon" ("WagonID", "Capacity", "Class", "SeatNoScheme", "Description", "HasTables", "Amenities") FROM stdin;
1	60	Third Class	{{d,"","","",d},{xw,xf,xf,xm,xw},{xw,xf,xf,xm,xw},{yw,yf,yf,ym,yw},{yw,yf,yf,ym,yw},{xw,xf,xf,xm,xw},{xw,xf,xf,xm,xw},{yw,yf,yf,ym,yw},{yw,yf,yf,ym,yw},{xw,xf,xf,xm,xw},{xw,xf,xf,xm,xw},{yw,yf,yf,ym,yw},{yw,yf,yf,ym,yw},{s,"","","",t}}	Standard Economy Wagon	f	{"Ceiling Fans","Reading Lights"}
2	40	Second Class	{{d,"","",d},{w,f,f,w},{w,f,f,w},{w,f,f,w},{w,f,f,w},{w,f,f,w},{w,f,f,w},{w,f,f,w},{w,f,f,w},{w,f,f,w},{w,f,f,w},{s,"","",t}}	Standard Second Class Wagon	f	{"Ceiling Fans","Reading Lights","Folding table","Cup holder"}
\.


--
-- Name: Booking_BookingID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Booking_BookingID_seq"', 72, true);


--
-- Name: Frequency_FrequencyID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Frequency_FrequencyID_seq"', 2, true);


--
-- Name: SeatBooking_SeatBookingID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."SeatBooking_SeatBookingID_seq"', 1, false);


--
-- Name: Station_StationID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Station_StationID_seq"', 402, true);


--
-- Name: TrainStop_stopID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TrainStop_stopID_seq"', 40, true);


--
-- Name: Train_TrainID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Train_TrainID_seq"', 15, true);


--
-- Name: Wagon_WagonID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Wagon_WagonID_seq"', 2, true);


--
-- Name: AdminUser AdminUser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AdminUser"
    ADD CONSTRAINT "AdminUser_pkey" PRIMARY KEY ("UserID");


--
-- Name: Booking Booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_pkey" PRIMARY KEY ("BookingID");


--
-- Name: Frequency Frequency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Frequency"
    ADD CONSTRAINT "Frequency_pkey" PRIMARY KEY ("FrequencyID");


--
-- Name: Passenger Passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Passenger"
    ADD CONSTRAINT "Passenger_pkey" PRIMARY KEY ("PassengerID");


--
-- Name: Payments Payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT "Payments_pkey" PRIMARY KEY ("PaymentID");


--
-- Name: SeatBooking SeatBooking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SeatBooking"
    ADD CONSTRAINT "SeatBooking_pkey" PRIMARY KEY ("SeatBookingID");


--
-- Name: Station Station_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Station"
    ADD CONSTRAINT "Station_pkey" PRIMARY KEY ("StationID");


--
-- Name: TrainSchedule TrainSchedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TrainSchedule"
    ADD CONSTRAINT "TrainSchedule_pkey" PRIMARY KEY ("TrainNo");


--
-- Name: TrainStop TrainStop_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TrainStop"
    ADD CONSTRAINT "TrainStop_pkey" PRIMARY KEY ("stopID");


--
-- Name: Train Train_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Train"
    ADD CONSTRAINT "Train_pkey" PRIMARY KEY ("TrainID");


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("UserID");


--
-- Name: Wagon Wagon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Wagon"
    ADD CONSTRAINT "Wagon_pkey" PRIMARY KEY ("WagonID");


--
-- Name: Booking Booking_Destination_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_Destination_fkey" FOREIGN KEY ("Destination") REFERENCES public."Station"("StationID");


--
-- Name: Booking Booking_Source_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_Source_fkey" FOREIGN KEY ("Source") REFERENCES public."Station"("StationID");


--
-- Name: Booking Booking_TrainID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_TrainID_fkey" FOREIGN KEY ("TrainID") REFERENCES public."Train"("TrainID");


--
-- Name: Booking Booking_userID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_userID_fkey" FOREIGN KEY ("userID") REFERENCES public."User"("UserID");


--
-- Name: Passenger Passenger_PassengerID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Passenger"
    ADD CONSTRAINT "Passenger_PassengerID_fkey" FOREIGN KEY ("PassengerID") REFERENCES public."SeatBooking"("SeatBookingID");


--
-- Name: Payments Payments_BookingID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT "Payments_BookingID_fkey" FOREIGN KEY ("BookingID") REFERENCES public."Booking"("BookingID");


--
-- Name: SeatBooking SeatBooking_BookingID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SeatBooking"
    ADD CONSTRAINT "SeatBooking_BookingID_fkey" FOREIGN KEY ("BookingID") REFERENCES public."Booking"("BookingID");


--
-- Name: SeatBooking SeatBooking_WagonID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SeatBooking"
    ADD CONSTRAINT "SeatBooking_WagonID_fkey" FOREIGN KEY ("WagonID") REFERENCES public."Wagon"("WagonID");


--
-- Name: TrainSchedule TrainSchedule_Destination_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TrainSchedule"
    ADD CONSTRAINT "TrainSchedule_Destination_fkey" FOREIGN KEY ("Destination") REFERENCES public."Station"("StationID");


--
-- Name: TrainSchedule TrainSchedule_Frequency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TrainSchedule"
    ADD CONSTRAINT "TrainSchedule_Frequency_fkey" FOREIGN KEY ("Frequency") REFERENCES public."Frequency"("FrequencyID");


--
-- Name: TrainSchedule TrainSchedule_Source_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TrainSchedule"
    ADD CONSTRAINT "TrainSchedule_Source_fkey" FOREIGN KEY ("Source") REFERENCES public."Station"("StationID");


--
-- Name: TrainStop TrainStop_StationID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TrainStop"
    ADD CONSTRAINT "TrainStop_StationID_fkey" FOREIGN KEY ("StationID") REFERENCES public."Station"("StationID");


--
-- Name: TrainStop TrainStop_TrainNo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TrainStop"
    ADD CONSTRAINT "TrainStop_TrainNo_fkey" FOREIGN KEY ("TrainNo") REFERENCES public."TrainSchedule"("TrainNo");


--
-- Name: Train Train_TrainNo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Train"
    ADD CONSTRAINT "Train_TrainNo_fkey" FOREIGN KEY ("TrainNo") REFERENCES public."TrainSchedule"("TrainNo");


--
-- PostgreSQL database dump complete
--

