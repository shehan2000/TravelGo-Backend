import express from "express";
import { insertBooking, getBookingPrice } from "../controllers/bookingController.js";
import { protectAdmin } from "../middleware/authMiddleware.js";
const router = express.Router();

router.post("/create-booking", insertBooking);

router.route("/admin/bookingprice").get(protectAdmin, getBookingPrice);

export default router;