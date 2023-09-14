import express from "express";
const router = express.Router();
import {
  getStations,
  getSchedule,
  getAllSchedule,
  getTrainStops,
  getWagonTypes,
  getBookingAggregateDataByMonth,
  getBookingAggregateDataByDay,
} from "../controllers/trainController.js";
import { protect } from '../middleware/authMiddleware.js';

router.get("/stations", getStations);
router.post("/schedule", getSchedule);

router.route("/admin/schedule").get(protect, getSchedule);
router.get("/admin/train-stations", getTrainStops);
router.get("/admin/wagon-types", getWagonTypes);
router.get(
  "/admin/aggregated-booking-data-month",
  getBookingAggregateDataByMonth
);
router.get("/admin/aggregated-booking-data-day", getBookingAggregateDataByDay)

export default router;
