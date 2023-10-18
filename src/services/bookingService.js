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

const getBookingPriceService = async () => {
    const query = `SELECT
    bp.*,
    ss."StationName" AS "SourceStationName",
    sd."StationName" AS "DestinationStationName"
  FROM
    "BookingPrice" bp
  JOIN
    "Station" ss ON bp."SourceID" = ss."StationID"
  JOIN
    "Station" sd ON bp."DestinationID" = sd."StationID";`
    return (await DbHandler.executeSingleQuery(query))
  }

  const getSeats = async (
    trainNo,
    date,
    source,
    destination
  ) => {

  }


export {
    insertBookingService,
    getBookingPriceService,
}