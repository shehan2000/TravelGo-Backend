import DbHandler from "../database/dbHandler.js";

const insertBookingService = async (
    userID,
    trainID,
    isReturn,
    Source,
    Destination,
    Amount,
    isPaid
) => {
    const query = `INSERT INTO "Booking" ("userID", "TrainID", "isReturn", "Source", "Destination", "BookedTime", "Amount", "isPaid")
    VALUES ('${userID}', ${trainID}, '${isReturn}', '${Source}', '${Destination}', NOW(), '${Amount}', '${isPaid}') returning*;
    `
    return ( await DbHandler.executeSingleQuery(query));
}

export {
    insertBookingService
}