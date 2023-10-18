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
  createTrainScheduleService,
  getStatBoxDataService,
  deleteTrainScheduleService,
  createWagonService,
  createFrequencyService,
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
  const totalRes = await getTrainStopsTotalService();
  const total = parseInt(totalRes[0].count);

  res.status(200).json({ trainstops, total });
});

const getWagonTypes = asyncHandler(async (req, res) => {
  res.status(200).json(await getWagonTypesService());
});

const getBookingAggregateDataByMonth = asyncHandler(async (req, res) => {
  res.status(200).json(await getBookingAggregateDataByMonthService());
});

const getBookingAggregateDataByDay = asyncHandler(async (req, res) => {
  res.status(200).json(await getBookingAggregateDataByDayService());
});

const getTrainFrequency = asyncHandler(async (req, res) => {
  res.status(200).json(await getTrainFrequencyService());
});

const createTrainSchedule = asyncHandler(async (req, res) => {
  const {
    trainNo,
    trainName,
    source,
    dest,
    arrivalTime,
    departureTime,
    trainType,
    frequency,
    defaultWagonsWithDirection,
    invertedStations,
  } = req.body;

  res
    .status(200)
    .json(
      await createTrainScheduleService(
        trainNo,
        trainName,
        source,
        dest,
        arrivalTime,
        departureTime,
        trainType,
        frequency,
        defaultWagonsWithDirection,
        invertedStations
      )
    );
});

const getStatBoxData = asyncHandler(async (req, res) => {
  res.status(200).json(await getStatBoxDataService());
});

const deleteTrainSchedule = asyncHandler(async (req, res) => {
  const TrainNo = req.query.TrainNo;
  console.log(
    "🚀 ~ file: trainController.js:107 ~ deleteTrainSchedule ~ TrainNo:",
    TrainNo
  );
  res.status(200).json(await deleteTrainScheduleService(TrainNo));
});

const createWagon = asyncHandler(async (req, res) => {
  const { Capacity, Class, SeatNoScheme, Description, HasTables, Amenities } =
    req.body;

  res
    .status(200)
    .json(
      await createWagonService(
        Capacity,
        Class,
        SeatNoScheme,
        Description,
        HasTables,
        Amenities
      )
    );
});

const createFrequency = asyncHandler(async (req, res) => {
  const {
    frequencyName,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,
  } = req.body;

  res
    .status(200)
    .json(
      await createFrequencyService(
        frequencyName,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
        sunday
      )
    );
});



export {
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
  createFrequency,

};
