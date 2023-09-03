import jwt from "jsonwebtoken";
import asyncHandler from "express-async-handler";
import { getUserByEmail } from "../services/userService.js";

const protect = asyncHandler(async (req, res, next) => {
    let token;

    // accessing cookie through cookie parser library
     token = req.cookies.jwt;

     if (token) {
        try {
            const decoded = jwt.verify(token, process.env.JWT_SECRET);

            const user = await getUserByEmail(decoded.username);
            delete user[0].PasswordHash;

            req.user = user[0];

            next();
        } catch (error) {
            res.status(401);
            throw new Error('Not authorized. Token invalid.')
        }

     } else {
        res.status(401);
        throw new Error('Not authorized. Token unavailable.');
     }
})

export { protect }