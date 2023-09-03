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
