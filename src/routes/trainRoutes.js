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
  getTrainFrequency,
} from "../controllers/trainController.js";

router.get("/stations", getStations);
router.post("/schedule", getSchedule);

router.get("/admin/schedule",getAllSchedule);
router.get("/admin/train-stations", getTrainStops);
router.get("/admin/wagon-types", getWagonTypes);
router.get(
  "/admin/aggregated-booking-data-month",
  getBookingAggregateDataByMonth
);
router.get("/admin/aggregated-booking-data-day", getBookingAggregateDataByDay)
router.get("/admin/train-frequency", getTrainFrequency);

export default router;
