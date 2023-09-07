CREATE DATABASE travelgodb;

CREATE TABLE "User" (
    "UserID" UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    "Username" VARCHAR(255),
    "FirstName" VARCHAR(255),
    "LastName" VARCHAR(255),
    "Birthday" DATE,
    "PhoneNo" VARCHAR(20),
    "NIC" VARCHAR(15),
    "Address" VARCHAR(255),
    "PasswordHash" VARCHAR(255),
    "EmailConfirmed" BOOLEAN DEFAULT false
);

CREATE TABLE "Station" (
    "StationID" SERIAL PRIMARY KEY,
    "StationName" VARCHAR(255) NOT NULL
);

CREATE TABLE "Frequency" (
    "FrequencyID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(255),
    "Monday" BOOLEAN DEFAULT false,
    "Tuesday" BOOLEAN DEFAULT false,
    "Wednesday" BOOLEAN DEFAULT false,
    "Thursday" BOOLEAN DEFAULT false,
    "Friday" BOOLEAN DEFAULT false,
    "Saturday" BOOLEAN DEFAULT false,
    "Sunday" BOOLEAN DEFAULT false
);

CREATE TABLE "TrainSchedule" (
    "TrainNo" INTEGER PRIMARY KEY,
    "TrainName" VARCHAR(255),
    "Source" INTEGER REFERENCES "Station"("StationID"),
    "Destination" INTEGER REFERENCES "Station"("StationID"),
    "ArrivalTime" TIME,
    "DepartureTime" TIME,
    "TrainType" VARCHAR(255),
    "Frequency" INTEGER REFERENCES "Frequency"("FrequencyID"),
    "DefaultWagonsWithDirection" INTEGER[][],
    "InvertedStations" INTEGER[],
    "DefaultTotalSeats" INTEGER
);

CREATE TABLE "Wagon" (
    "WagonID" SERIAL PRIMARY KEY,
    "Capacity" INTEGER,
    "Class" VARCHAR(255),
    "SeatNoScheme" TEXT[][],
    "TotalSeats" INTEGER,
    "Description" VARCHAR(255),
    "HasTables" BOOLEAN DEFAULT false
);



CREATE TABLE "TrainStop" (
    "stopID" SERIAL PRIMARY KEY,
    "TrainNo" INTEGER REFERENCES "TrainSchedule"("TrainNo"),
    "StationID" INTEGER REFERENCES "Station"("StationID"),
    "ArrivalTime" TIME,
    "DepartureTime" TIME,
    "Load" INTEGER,
    "PlatformNo" INTEGER
);

CREATE TABLE "Train" (
    "TrainID" INTEGER PRIMARY KEY,
    "TrainNo" INTEGER REFERENCES "TrainSchedule"("TrainNo"),
    "Date" DATE,
    "ChangedWagonsWithDirection" INTEGER[][]
);


CREATE TABLE "Booking" (
    "BookingID" INTEGER PRIMARY KEY,
    "userID" INTEGER REFERENCES "User"("UserID"),
    "TrainID" INTEGER REFERENCES "TrainSchedule"("TrainNo"),
    "isReturn" BOOLEAN,
    "Source" INTEGER REFERENCES "Station"("StationID"),
    "Destination" INTEGER REFERENCES "Station"("StationID"),
    "BookedTime" TIMESTAMP,
    "Amount" FLOAT,
    "isPaid" BOOLEAN
);

CREATE TABLE "Passenger" (
    "PassengerID" INTEGER REFERENCES "SeatBooking"("SeatBookingID"),
    "NIC" VARCHAR(20),
    "Name" VARCHAR(255),
    "Gender" VARCHAR(10),
    "Age" INTEGER,
    PRIMARY KEY ("PassengerID")
);

CREATE TABLE "Payments" (
    "PaymentID" INTEGER PRIMARY KEY,
    "BookingID" INTEGER REFERENCES "Booking"("BookingID"),
    "Timestamp" TIMESTAMP,
    "isSuccess" BOOLEAN,
    "Response" VARCHAR(255)
);
