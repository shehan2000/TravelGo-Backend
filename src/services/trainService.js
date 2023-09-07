import DbHandler from "../database/dbHandler.js";

const getStationsService = async () => {
    return await DbHandler.executeSingleQuery(
        'SELECT * FROM "Station"'
    );
}

const getScheduleService = async ( sourceID, destID, day ) => {
    const dayString = '"' + day + '"';
    console.log(dayString);

    var query =  `SELECT
    ts."TrainNo",
    ts."TrainName",
    ts."ArrivalTime",
    ts."DepartureTime",
    ts."TrainType",
    f."Name" AS "FrequencyName",
    ts."Frequency",
    ts."InvertedStations",
    ts."DefaultTotalSeats",
    t."SourceStationID",
    t."DestinationStationID",
    t."ArrivalTimeAtSource",
    t."DepartureTimeAtSource",
    t."ArrivalTimeAtDestination"
FROM
    "TrainSchedule" ts
JOIN
    "Frequency" f ON ts."Frequency" = f."FrequencyID"
JOIN
    (
        SELECT
            a."TrainNo",
            a."StationID" AS "SourceStationID",
            a."ArrivalTime" AS "ArrivalTimeAtSource",
            a."DepartureTime" AS "DepartureTimeAtSource",
            b."StationID" AS "DestinationStationID",
            b."ArrivalTime" AS "ArrivalTimeAtDestination"
        FROM
            "TrainStop" a
        JOIN
            "TrainStop" b ON a."TrainNo" = b."TrainNo"
        WHERE
            a."StationID" = ${sourceID}
            AND b."StationID" = ${destID}
    ) t ON ts."TrainNo" = t."TrainNo"
WHERE
    f.${dayString} = true
ORDER BY
    ts."TrainNo";`

    return await DbHandler.executeSingleQuery(
       query
    )
}

export { getStationsService, getScheduleService };