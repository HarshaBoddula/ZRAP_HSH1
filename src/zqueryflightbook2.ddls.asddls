@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Booking 2 Query'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
define view entity ZQUERYFLIGHTBOOK2 as select from Z_Cube_FlightBookings
{
    key Airline,
    key FlightConnection,
    key FlightDate,
    key BookNumber,
    key Customer,
    key TravelAgency,
    CalendarYear,
    CalendarMonth,
    concat( concat ( case CalendarMonth
  when '01' then 'JAN'
  when '02' then 'FEB'
  when '03' then 'MAR'
  when '04' then 'APR'
  when '05' then 'MAY'
  when '06' then 'JUN'
  when '07' then 'JUL'
  when '08' then 'AUG'
  when '09' then 'SEP'
  when '10' then 'OCT'
  when '11' then 'NOV'
  when '12' then 'DEC'
  else 'DUMMY'
end, '-' ), CalendarYear ) as month_year,
    
    concat(CalendarMonth, CalendarYear) as MonthYear,
    CustomerCountry,
    CustomerCity,
    TravelAgencyCountry,
    TravelAgencyCity,
//    @DefaultAggregation: #SUM
    TotalOfBookings,
    @Semantics.amount.currencyCode: 'DefaultCurrency'
    @DefaultAggregation: #SUM
    currency_conversion( amount => BookingPrice, source_currency => Currency, target_currency => cast( 'USD' as abap.cuky( 5 ) ), exchange_rate_date => $session.system_date ) as BookingPrice,
    cast( 'USD' as abap.cuky( 5 ) ) as DefaultCurrency,
    @Semantics.amount.currencyCode: 'Currency'
    BookingPrice as BookingPriceOld,
    Currency,
    AverageWeightPerFlight,
    /* Associations */
    _Airline,
    _CalendarDate,
    _CalendarMonth,
    _CalendarYear,
    _Connection,
    _Customer,
    _CustomerCountry,
    _TravelAgency,
    _TravelAgencyCountry
} where Currency = 'USD'
