import DbHandler from "../database/dbHandler.js";

const getStationsService = async () => {
  return await DbHandler.executeSingleQuery('SELECT * FROM "Station"');
};

const getScheduleService = async (sourceID, destID, day) => {
  const dayString = '"' + day + '"';
  console.log(dayString);

  var query = `SELECT
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
    ts."TrainNo";`;

  return await DbHandler.executeSingleQuery(query);
};

const getAllScheduleService = async () => {
  return await DbHandler.executeSingleQuery('SELECT * FROM "TrainSchedule";');
};

const getTrainStopsService = async (page, pageSize, sort, search) => {
  console.log("🚀 ~ file: trainService.js:60 ~ getTrainStopsService ~ search:", search)
  let sql = `SELECT * FROM "TrainStop" `;

    if (search) {
        sql += `WHERE
                    CAST("stopID" AS TEXT) LIKE '%${search}%'
                    OR CAST("TrainNo" AS TEXT) LIKE '%${search}%'`
    }

  if (sort.length > 2) {
    const sortParsed = JSON.parse(sort);
    const { field, sort: sortOrder } = sortParsed;
    sql += `ORDER BY "${field}" ${sortOrder} `;
  }

  // Calculate the offset based on the requested page and page size
  const offset = page * pageSize;

  // Add pagination
  sql += `LIMIT ${pageSize} OFFSET ${offset};`;

  console.log(
    "🚀 ~ file: trainService.js:73 ~ getTrainStopsService ~ sql:",
    sql
  );

  return await DbHandler.executeSingleQuery(sql);
};

const getTrainStopsTotalService = async () => {
  return await DbHandler.executeSingleQuery(
    'SELECT COUNT(*) FROM "TrainStop";'
  );
};

const getWagonTypesService = async () => {
  return await DbHandler.executeSingleQuery(
    'SELECT "WagonID", "Capacity", "Class" FROM "Wagon";'
  );
}

const getBookingAggregateDataByMonthService = async () => {
  return await DbHandler.executeSingleQuery(
    ` WITH MonthlyData AS (SELECT
      TO_CHAR("BookedTime", 'Month') AS "month",
          SUM("Amount") AS "total_booking_amount",
          COUNT(*) AS "total_customers"
      FROM
          (SELECT * FROM "Booking" WHERE
      EXTRACT(YEAR FROM "BookedTime")=2023) AS "2023Booking"
      GROUP BY
          TO_CHAR("BookedTime", 'Month'))
  SELECT
      SUM(MonthlyData."total_customers") AS "yearly_total_customers",
      SUM(MonthlyData."total_booking_amount") AS "yearly_booking_amount_total",
      json_agg(
          json_build_object(
              'month', MonthlyData."month",
              'total_booking_amount', MonthlyData."total_booking_amount",
              'total_customers', MonthlyData."total_customers"
          )
      ) AS "monthly_data"
  FROM
      MonthlyData`
  );
}

const getBookingAggregateDataByDayService = async () => {
  return await DbHandler.executeSingleQuery(
    `WITH DailyData AS (
      SELECT
          DATE("BookedTime") AS "day",
          SUM("Amount") AS "total_booking_amount",
          COUNT(*) AS "total_customers"
      FROM
          (SELECT * FROM "Booking" WHERE EXTRACT(YEAR FROM "BookedTime") = 2023) AS "2023Booking"
      GROUP BY
          DATE("BookedTime")
  )
  SELECT
    json_agg(
          json_build_object(
              'day', DailyData."day",
              'total_booking_amount', DailyData."total_booking_amount",
              'total_customers', DailyData."total_customers"
          )
      ) AS "daily_data"
  FROM
      DailyData`
  )
}

export {
  getStationsService,
  getScheduleService,
  getAllScheduleService,
  getTrainStopsService,
  getTrainStopsTotalService,
  getWagonTypesService,
  getBookingAggregateDataByMonthService,
  getBookingAggregateDataByDayService,
};
