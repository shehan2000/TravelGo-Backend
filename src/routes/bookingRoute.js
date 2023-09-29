import express from "express";
import { insertBooking } from "../controllers/bookingController.js";
const router = express.Router();

router.post("/create-booking", insertBooking);

export default router;