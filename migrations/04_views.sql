\c demo;
SET search_path = bookings;

SELECT CURRENT_SCHEMA, CURRENT_SCHEMA();

CREATE MATERIALIZED VIEW customers_info AS
  WITH flight_dates AS (
    SELECT MIN(scheduled_departure) AS start, MAX(scheduled_departure) AS finish
    FROM flights_v
    WHERE status != 'Scheduled' AND status != 'Cancelled'
  )
  SELECT passenger_id, passenger_name, actual_departure, fare_conditions, amount
  FROM flights_v
    LEFT JOIN ticket_flights USING(flight_id)
    JOIN tickets USING(ticket_no)
  WHERE status != 'Cancelled' AND scheduled_departure BETWEEN (SELECT start FROM flight_dates) AND (SELECT finish FROM flight_dates);

CREATE MATERIALIZED VIEW profitable_routes AS
  SELECT city_1
        , city_2
        , route_revenue
        , route_revenue * 100.0 / SUM(route_revenue) OVER () AS revenue_percentage
  FROM (
    SELECT LEAST(departure_city, arrival_city) AS city_1
            , GREATEST(departure_city, arrival_city) AS city_2
            , SUM(amount) AS route_revenue
    FROM flights_v
     LEFT JOIN ticket_flights
     USING(flight_id)
    GROUP BY 1,2
  ) revenue
  WHERE route_revenue IS NOT NULL
  ORDER BY 4 DESC
  LIMIT 5;

CREATE UNIQUE INDEX route
  ON bookings.profitable_routes (city_1, city_2);
  
CREATE MATERIALIZED VIEW aircrafts_summary AS
  SELECT total_flights.model
        , total_flights.total_flights
        , COALESCE(total_passenger.total_passenger, 0) AS total_passenger
        , COALESCE(total_passenger.total_revenue, 0) AS total_revenue
        , COALESCE(empty_seats, 0) AS empty_seats
        , COALESCE(occupancy, 0) AS occupancy
  FROM (
    SELECT model, COUNT(flight_id) AS total_flights
    FROM aircrafts
      LEFT JOIN flights USING(aircraft_code)
    GROUP BY 1
    ORDER BY 2 DESC
  ) total_flights
  LEFT JOIN
    (
      SELECT model, COUNT(flight_id) AS total_passenger, SUM(amount) AS total_revenue
      FROM aircrafts
        LEFT JOIN flights USING(aircraft_code)
        LEFT JOIN ticket_flights USING(flight_id)
      GROUP BY 1
      ORDER BY 2 DESC
    ) total_passenger
    USING(model)
  LEFT JOIN 
    (
      SELECT model, COUNT(*) - COUNT(bp.seat_no)  as empty_seats, round(COUNT(bp.seat_no)*100.0 / COUNT(s.seat_no), 2) AS occupancy
      FROM aircrafts a
        LEFT JOIN seats s USING(aircraft_code)
        LEFT JOIN flights f ON a.aircraft_code = f.aircraft_code
        LEFT JOIN boarding_passes bp USING(flight_id, seat_no)
      WHERE scheduled_departure BETWEEN '2016-08-14T23:45:00+00:00' AND '2017-08-15T14:25:00+00:00' AND f.status = 'Arrived'
      GROUP BY 1
    ) aircraft_occupancy
    USING(model)
  ORDER BY 2 DESC;
