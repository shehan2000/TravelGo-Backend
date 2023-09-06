import express from "express";
import dotenv from 'dotenv';
import cookieParser from "cookie-parser";

import userRoutes from './routes/userRoutes.js';
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

app.use(cors({
    origin: "http://localhost:5173",
}))

app.use('/api/users', userRoutes);

// Implementing swagger UI
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocs));



app.get('/', (req, res) => res.send('server is ready'));

app.use(notFound);
app.use(errorHandler);



export default app;