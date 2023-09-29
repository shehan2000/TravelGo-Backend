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
  createTrainSchedule,
  getStatBoxData,
  deleteTrainSchedule,
  createWagon,
} from "../controllers/trainController.js";
import { protectAdmin } from "../middleware/authMiddleware.js";

router.get("/stations", getStations);
router.post("/schedule", getSchedule);

router.route("/admin/schedule").get(protectAdmin, getAllSchedule);
router.route("/admin/train-stations").get(protectAdmin, getTrainStops);
router.route("/admin/wagon-types").get(protectAdmin, getWagonTypes);
router.route("/admin/aggregated-booking-data-month").get(
  protectAdmin,
  getBookingAggregateDataByMonth
);
router.route("/admin/aggregated-booking-data-day").get(protectAdmin, getBookingAggregateDataByDay);
router.route("/admin/train-frequency").get(protectAdmin, getTrainFrequency);

router.route("/admin/create-train-schedule").post(protectAdmin, createTrainSchedule);
router.route("/admin/stat-box-data").get(protectAdmin, getStatBoxData);
router.route("/admin/delete-train-schedule").delete(protectAdmin, deleteTrainSchedule);

router.route("/admin/create-wagon").post(protectAdmin, createWagon);

export default router;
