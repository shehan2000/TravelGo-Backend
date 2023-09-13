import express from "express";
import dotenv from 'dotenv';
import cookieParser from "cookie-parser";

import userRoutes from './routes/userRoutes.js';
import trainRoutes from './routes/trainRoutes.js';
import adminUserRoutes from './routes/adminUserRoutes.js';
import { notFound, errorHandler } from "./middleware/errorMiddleware.js";
import cors from "cors";
import swaggerUi from 'swagger-ui-express';
import swaggerDocs from "./utils/swagger.js";



dotenv.config();

const app = express();

// To get data from the request body
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(cookieParser());

// Cross origin requests
const allowedOrigins = [
    "http://localhost:5173",
    "http://localhost:3000"
]
app.use(cors({
    origin: allowedOrigins
}))

// Routes
app.use('/api/users', userRoutes);
app.use('/api/trains', trainRoutes);
app.use('/api/admin', adminUserRoutes);

// Implementing swagger UI
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocs));



app.get('/', (req, res) => res.send('server is ready'));

//Exception Handling
app.use(notFound);
app.use(errorHandler);



export default app;