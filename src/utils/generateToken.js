import jwt from "jsonwebtoken";

const generateToken = (res, username) => {
    const token = jwt.sign(
        {
            username
        },
        process.env.JWT_SECRET,
        {
            expiresIn: '1h'
        }
    );

    /**
     * secure - whether https
     * sameSite - prevent csrf attacks
     */
    res.cookie('jwt', token, {
        httpOnly: true,
        secure: false,
        maxAge: 60 * 60 * 1000
    });

};



export default generateToken;