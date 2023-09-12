import AsyncHandler from "express-async-handler";
import generateToken from "../utils/generateToken";
import { getAdminByEmail } from "../services/adminUserService";
import { comparePasswordHash, generatePasswordHash } from "../services/userService";

const authAdmin = AsyncHandler( async (req, res) => {
    const { email, password } = req.body;

    var admin = await getAdminByEmail(email);
    admin = admin[0];

    if(admin && password !== undefined && (await comparePasswordHash(password, admin.PasswordHash))) {
        generateToken(res, admin.Username);

        res.status(201).json({
            userId: admin.UserID,
            username: admin.Username,
            firstname: admin.FirstName,
        })
    } else {
        res.status(400);
        throw new Error('Invalid Credentials');
    }
})

const registerAdmin = AsyncHandler( async (req, res) => {
    const { firstname, lastname, email, password } = req.body;

    const adminExists = await getAdminByEmail(email);

    if (adminExists) {
        res.status(400);
        throw new Error('User already exists');
    }

    const passwordHash = await generatePasswordHash(password);

    var admin = await insertAdmin({
        email: email,
        firstName: firstname,
        lastName: lastname,
        passwordHash: passwordHash
    });

    if (admin) {
        admin = admin[0];
        res.status(201).json({
            message: "Admin created successfully",
            userId: user.UserID,
        })
    } else {
        res.status(400);
        throw new Error('Invalid user data');
    }
})

export { authAdmin };