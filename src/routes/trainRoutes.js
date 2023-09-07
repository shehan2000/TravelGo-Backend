import express from 'express';
const router = express.Router();
import { getStations, getSchedule } from '../controllers/trainController.js';

router.get('/stations', getStations);
router.post('/schedule', getSchedule);

export default router;