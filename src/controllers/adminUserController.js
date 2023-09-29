import AsyncHandler from "express-async-handler";
import { generateTokenAdmin} from "../utils/generateToken.js";
import { getAdminByEmail, insertAdmin } from "../services/adminUserService.js";
import { comparePasswordHash, generatePasswordHash } from "../services/userService.js";

const authAdmin = AsyncHandler( async (req, res) => {
    const { email, password } = req.body;
    console.log("🚀 ~ file: adminUserController.js:8 ~ authAdmin ~ email, password:", email, password)

    
    var admin = await getAdminByEmail(email);
    admin = admin[0];

    if(admin && password !== undefined && (await comparePasswordHash(password, admin.PasswordHash))) {
        generateTokenAdmin(res, admin.Username);

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
    console.log("🚀 ~ file: adminUserController.js:30 ~ registerAdmin ~ adminExists:", adminExists)

    if (adminExists.length) {
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
            userId: admin.UserID,
        })
    } else {
        res.status(400);
        throw new Error('Invalid user data');
    }
});

const logoutAdmin = AsyncHandler( async (req, res) => {
    res.cookie('jwt_admin', '', {
        httpOnly: true,
        expires: new Date(0)
    })

    res.status(200).json({ message: 'User logged out' })
})



export { authAdmin, registerAdmin, logoutAdmin };