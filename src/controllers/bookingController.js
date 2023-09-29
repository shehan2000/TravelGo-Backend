import asyncHandler from "express-async-handler";
import { insertBookingService } from "../services/bookingService.js";

const insertBooking = asyncHandler( async (req, res) => {
    const {
        userID,
        trainID,
        isReturn,
        Source,
        Destination,
        Amount,
        isPaid
    } = req.body

    res.status(200).json(await insertBookingService(
        userID,
        trainID,
        isReturn,
        Source,
        Destination,
        Amount,
        isPaid
    ))
})

export {
    insertBooking
}