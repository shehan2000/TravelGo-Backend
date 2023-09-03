const notFound = (req, res, next) => {
    const error = new Error(`Not Found - ${req.originalUrl}`);
    res.status(404);
    next(error);
} 

//custom error handler to replace default html error
const errorHandler = (err, req, res, next) => {
    //if there are any erros displaying with 200 rseponse code, change it to 500
    let statusCode = res.statusCode === 200 ? 500 : res.statusCode;
    let message = err.message;

    //if project is in dev mode, show stack as well.
    res.status(statusCode).json({
        message,
        stack: process.env.NODE_ENV === 'production' ? null : err.stack
    })
}

export { notFound, errorHandler }