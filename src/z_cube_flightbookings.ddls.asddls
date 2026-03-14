@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Bookings'
@Analytics.dataCategory: #CUBE
define view entity Z_Cube_FlightBookings
  as select from /dmo/booking
    inner join   /dmo/travel on /dmo/travel.travel_id = /dmo/booking.travel_id
  association [0..1] to I_CalendarDate           as _CalendarDate on  $projection.FlightDate = _CalendarDate.CalendarDate
  association [0..1] to Z_Dimension_Airline      as _Airline      on  $projection.Airline = _Airline.Airline
  association [0..1] to Z_Dimension_Connection   as _Connection   on  $projection.Airline          = _Connection.Airline
                                                                  and $projection.FlightConnection = _Connection.FlightConnection
  association [0..1] to Z_Dimension_Customer     as _Customer     on  $projection.Customer = _Customer.Customer
  association [0..1] to Z_Dimension_TravelAgency as _TravelAgency on  $projection.TravelAgency = _TravelAgency.TravelAgency
{
  /** DIMENSIONS **/
  @EndUserText.label: 'Airline'
  @ObjectModel.foreignKey.association: '_Airline'
  /dmo/booking.carrier_id    as Airline,
  @EndUserText.label: 'Connection'
  @ObjectModel.foreignKey.association: '_Connection'
  /dmo/booking.connection_id as FlightConnection,
  @EndUserText.label: 'Flight Date'
  @ObjectModel.foreignKey.association: '_CalendarDate'
  /dmo/booking.flight_date   as FlightDate,
  @EndUserText.label: 'Book No.'
  /dmo/booking.booking_id    as BookNumber,
  @EndUserText.label: 'Customer'
  @ObjectModel.foreignKey.association: '_Customer'
  /dmo/booking.customer_id   as Customer,
  @EndUserText.label: 'Travel Agency'
  @ObjectModel.foreignKey.association: '_TravelAgency'
  /dmo/travel.agency_id      as TravelAgency,
  @EndUserText.label: 'Flight Year'
  _CalendarDate.CalendarYear,
  @EndUserText.label: 'Flight Month'
  _CalendarDate.CalendarMonth,
  @EndUserText.label: 'Customer Country'
  @ObjectModel.foreignKey.association: '_CustomerCountry'
  _Customer.Country          as CustomerCountry,
  @EndUserText.label: 'Customer City'
  _Customer.City             as CustomerCity,
  @EndUserText.label: 'Travel Agency Country'
  @ObjectModel.foreignKey.association: '_TravelAgencyCountry'
  _TravelAgency.Country      as TravelAgencyCountry,
  @EndUserText.label: 'Travel Agency Customer City'
  _TravelAgency.City         as TravelAgencyCity,
  /** MEASURES **/
  @EndUserText.label: 'Total of Bookings'
  @DefaultAggregation: #SUM
  1                          as TotalOfBookings,
  //@EndUserText.label: 'Weight of Luggage'
  //  @DefaultAggregation: #SUM
  //  @Semantics.quantity.unitOfMeasure: 'WeightUOM'
  //  luggweight             as WeightOfLuggage,
  //@EndUserText.label: 'Weight Unit'
  //  @Semantics.unitOfMeasure: true
  //  wunit                  as WeightUOM,
  @EndUserText.label: 'Booking Price'
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'Currency'
  /dmo/booking.flight_price  as BookingPrice,
  @EndUserText.label: 'Currency'
  //  @Semantics.currencyCode: true
  /dmo/booking.currency_code as Currency,
  0 as AverageWeightPerFlight,
  // Associations
  _Airline,
  _CalendarDate,
  _CalendarDate._CalendarMonth,
  _CalendarDate._CalendarYear,
  _Connection,
  _Customer,
  _Customer._Country         as _CustomerCountry,
  _TravelAgency,
  _TravelAgency._Country     as _TravelAgencyCountry
}
