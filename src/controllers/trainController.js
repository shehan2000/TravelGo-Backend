import asyncHandler from "express-async-handler";
import {
  getStationsService,
  getScheduleService,
  getAllScheduleService,
  getTrainStopsService,
  getTrainStopsTotalService,
  getWagonTypesService,
  getBookingAggregateDataByMonthService,
  getBookingAggregateDataByDayService,
  getTrainFrequencyService,
} from "../services/trainService.js";

const getStations = asyncHandler(async (req, res) => {
  res.status(200).json(await getStationsService());
});

const getSchedule = asyncHandler(async (req, res) => {
  const { sourceId, destinationId, date } = req.body;

  res.status(200).json(await getScheduleService(sourceId, destinationId, date));
});

const getAllSchedule = asyncHandler(async (req, res) => {
  res.status(200).json(await getAllScheduleService());
});

const getTrainStops = asyncHandler(async (req, res) => {
  // sort should look like this: { "field": "userId", "sort": "desc"}
  const { page = 1, pageSize = 20, sort = null, search = "" } = req.query;
  console.log("🚀 ~ file: trainController.js:24 ~ getTrainStops ~ page:", page);
  console.log(
    "🚀 ~ file: trainController.js:24 ~ getTrainStops ~ pageSize:",
    pageSize
  );
  console.log(
    "🚀 ~ file: trainController.js:24 ~ getTrainStops ~ search:",
    search
  );

  const trainstops = await getTrainStopsService(page, pageSize, sort, search);
  const totalRes = await getTrainStopsTotalService()
  const total = parseInt(totalRes[0].count);
  
  res.status(200).json({ trainstops, total });
});

const getWagonTypes = asyncHandler( async (req, res) => {
  res.status(200).json(await getWagonTypesService());
})

const getBookingAggregateDataByMonth = asyncHandler( async (req, res) => {
  res.status(200).json(await getBookingAggregateDataByMonthService());
})

const getBookingAggregateDataByDay = asyncHandler( async (req, res) => {
  res.status(200).json(await getBookingAggregateDataByDayService());
})

const getTrainFrequency = asyncHandler( async (req, res) => {
  res.status(200).json(await getTrainFrequencyService());
})
export { getStations, getSchedule, getAllSchedule, getTrainStops, getWagonTypes, getBookingAggregateDataByMonth, getBookingAggregateDataByDay, getTrainFrequency };
