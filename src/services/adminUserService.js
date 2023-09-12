import DbHandler from "../database/dbHandler";

const getAdminByEmail = async (email) => {
    return await DbHandler.executeSingleQuery(
        'SELECT * FROM "AdminUser" WHERE "Username"=$1',
        [email] 
    )
}

const insertAdmin = async({
    email,
    firstName,
    lastName,
    passwordHash
}) => {

    return await DbHandler.executeSingleQuery(
        'INSERT INTO "AdminUser" ("Username", "FirstName", "LastName", "PasswordHash") values($1, $2, $3, $4) returning*',
        [email, firstName, lastName, passwordHash]
    )
}


export { getAdminByEmail, insertAdmin };