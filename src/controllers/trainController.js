import asyncHandler from 'express-async-handler';
import { getStationsService, getScheduleService } from '../services/trainService.js'

const getStations = asyncHandler(async (req, res) => {
    res.status(200).json(await getStationsService())
})

const getSchedule = asyncHandler(async (req, res) => {
    const { sourceId, destinationId, date } = req.body;
    
    res.status(200).json(await getScheduleService( sourceId, destinationId, date ));
});





export { getStations, getSchedule };