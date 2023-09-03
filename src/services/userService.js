import DbHandler from "../database/dbHandler.js";
import bcrypt from 'bcryptjs';

const getUserByEmail = async (email) => {
    return await DbHandler.executeSingleQuery(
        'SELECT * FROM "User" WHERE "Username"= $1',
        [email]
    );
};

const insertUser = async({
    email,
    firstName,
    lastName,
    passwordHash
}) => {

    return await DbHandler.executeSingleQuery(
        'INSERT INTO "User" ("Username", "FirstName", "LastName", "PasswordHash") values($1, $2, $3, $4) returning*',
        [email, firstName, lastName, passwordHash]
    )
}

//Generating hash value for the password using bcrypt library
const generatePasswordHash = async (password) => {
    const salt = await bcrypt.genSalt(10);
    return await bcrypt.hash(password, salt);
}

//Comparing hash values of passwords using bcrypt library
const comparePasswordHash = async (enteredPassword, password) => {
    return await bcrypt.compare(enteredPassword, password);
}

export { getUserByEmail, insertUser, generatePasswordHash, comparePasswordHash };