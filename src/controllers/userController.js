import asyncHandler from 'express-async-handler';
import { getUserByEmail, insertUser, generatePasswordHash, comparePasswordHash } from '../services/userService.js';
import generateToken from '../utils/generateToken.js';

/**
 * @swagger
 * /api/users/auth:
 *      post:
 *          summary: Authentication.
 *          responses:
 *              200:
 *                  description: Authenticated
 */
const authUser = asyncHandler( async (req, res) => {
    
    const { email , password } = req.body;

    var user = await getUserByEmail(email); 
    user = user[0];

    if(user && (await comparePasswordHash(password, user.PasswordHash))) {
        generateToken(res, user.Username);

        res.status(201).json({
            userId: user.UserID,
            usernmae: user.Username,
            firstname: user.FirstName,
        }) 
    } else {
        res.status(400);
        throw new Error('Invalid credentials');
    }
});

/**
 * @swagger
 * /api/users/register:
 *      post:
 *          summary: Registation.
 *          responses:
 *              200:
 *                  description: registered
 */
const registerUser = asyncHandler( async (req, res) => {

    const { firstname, lastname, email, password } = req.body;
    
    const userExists = await getUserByEmail(email); 
    if (userExists.length) {
        res.status(400);
        throw new Error('User already exists');
    }

    const passwordHash = await generatePasswordHash(password);

    var user = await insertUser({
        email: email,
        firstName: firstname,
        lastName: lastname,
        password: passwordHash
    });

    if(user) {
        user = user[0];
        generateToken(res, user.Username);

        res.status(201).json({
            userId: user.UserID,
            usernmae: user.Username,
            firstname: user.FirstName,
        }) 
    } else {
        res.status(400);
        throw new Error('Invalid user data');
    }

});


/**
 * @swagger
 * /api/users/logout:
 *      post:
 *          summary: loggin out.
 *          responses:
 *              200:
 *                  description: logged out
 */
const logoutUser = asyncHandler( async (req, res) => {
    
    res.cookie('jwt', '', {
        httpOnly: true,
        expires: new Date(0)
    })

    res.status(200).json({ message: 'User logged out.'})
});


/**
 * @swagger
 * /api/users/profile:
 *      get:
 *          summary: Get user profile.
 *          responses:
 *              200:
 *                  description: logged out
 */
const getUserProfile = asyncHandler( async (req, res) => {

    res.status(200).json(req.user)
});


/**
 * @swagger
 * /api/users/profile:
 *      put:
 *          summary: Update user profile.
 *          responses:
 *              200:
 *                  description: profile updated
 */
const updateUserProfile = asyncHandler( async (req, res) => {
    res.status(200).json({ message: 'Update User Profile' })
});

export { authUser, registerUser, logoutUser, getUserProfile, updateUserProfile };