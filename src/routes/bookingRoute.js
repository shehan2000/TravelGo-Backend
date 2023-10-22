import express from "express";
import { insertBooking, getBookingPrice, getBookingDetails, getSeats } from "../controllers/bookingController.js";
import { protect, protectAdmin } from "../middleware/authMiddleware.js";
const router = express.Router();

router.post("/create-booking", insertBooking);

router.route("/admin/bookingprice").get(protectAdmin, getBookingPrice);

router.route("/book-tickets").post(protect, getBookingDetails)

router.route("/get-seats").post(protect, getSeats)

export default router;