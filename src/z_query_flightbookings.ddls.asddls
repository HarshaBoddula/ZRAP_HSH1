@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Flight Bookings'
//@Analytics.query: true
@VDM.viewType: #CONSUMPTION
@ObjectModel.modelingPattern: #ANALYTICAL_QUERY
@ObjectModel.supportedCapabilities: [#ANALYTICAL_QUERY]

@UI.selectionPresentationVariant: [{
    qualifier: 'Default',
    presentationVariantQualifier: 'Default'
//    selectionVariantQualifier: 'Default'
 }]
@UI.presentationVariant: [{
   qualifier: 'Default',
   visualizations: [{
       type: #AS_CHART,
       qualifier: 'ChartDefault'
   }]
},
{
 qualifier: 'PV_Airline',
 text: 'Filter: Gross Price by Airline',
 sortOrder: [{ 
    direction: #DESC
  }],
 visualizations: [
   { type: #AS_CHART, qualifier: 'BookingPriceByAirline' }
 ]
},
{
 qualifier: 'PV_Agency',
 visualizations: [
   { type: #AS_CHART, qualifier: 'BookingPriceByAgency' }
 ]
},
{
 qualifier: 'PV_Year',
 visualizations: [
   { type: #AS_CHART, qualifier: 'BookingPriceByYear' }
 ]
},
{
       qualifier: 'KPIQualifier',
       text: 'KPI: KPIQualifier',
       visualizations: [{
           type: #AS_DATAPOINT,
           qualifier: 'KPIDataPoint'
                        }]
                        }
]

@UI.selectionVariant: [{
   qualifier: 'Default',
   text: 'Default'
},
{
     qualifier: 'KPISelQualifier',
     text: 'Default'
        }]
@UI.chart: [{
   qualifier: 'ChartDefault',
   chartType: #COLUMN_STACKED,
   dimensions: ['Airline', 'CustomerCountry'],
//    measures: ['CalendarYear'],
   measures: ['BookingPrice'],
   dimensionAttributes: [{
       dimension: 'Airline',
       role: #SERIES
    },{
       dimension: 'CustomerCountry',
       role: #CATEGORY
    }],

   measureAttributes: [{
//        measure: 'CalendarYear',
       measure: 'BookingPrice',
       role: #AXIS_1
    }]
 },
 {
   qualifier: 'BookingPriceByAirline',
   chartType: #BAR,
   title: 'Gross Price by Airline',
   description: 'Gross Price by Airline',
   dimensions: ['Airline'],
   dimensionAttributes: [{ dimension: 'Airline', role: #CATEGORY }],
   measures: ['BookingPrice'],

   measureAttributes: [{measure: 'BookingPrice', role: #AXIS_1, asDataPoint: true }]
},
{
   qualifier: 'BookingPriceByAgency',
   chartType: #DONUT,
   dimensions: ['TravelAgency'],
   measures: ['BookingPrice'],
    measureAttributes: [{measure: 'BookingPrice', role: #AXIS_1, asDataPoint: true }]
},
{
   qualifier: 'BookingPriceByYear',
   chartType: #LINE,
   dimensions: ['CalendarYear'],
   measures: ['BookingPrice'],
    measureAttributes: [{measure: 'BookingPrice', role: #AXIS_1, asDataPoint: true }]
}]


//config kpi
//@UI.chart: [
//  {
//    chartType: #BAR,
//    title: 'Bar Chart',
//    description: 'Testing Bar Chart',
//    dimensions: [
//      'SoldToParty'
//    ],
//    measures: [
//      'totalPricing'
//    ],
//    measureAttributes: [{measure: 'totalPricing', role: #AXIS_1, asDataPoint: true }],
//  }
//]
//
//@UI.dataPoint: {
//     title: 'Total Pricing',
//     criticalityValue: #POSITIVE
// }
//totalPricing;

define view entity Z_Query_FlightBookings
  as select from Z_Cube_FlightBookings
  //provider contract analytical_query
  //as projection on Z_Cube_FlightBookings
{
      /** DIMENSIONS **/
      @UI.kpi: [{
       qualifier: 'KPI_Airline', detail.defaultPresentationVariantQualifier: 'PV_Airline'
       }]
      @UI.textArrangement: #TEXT_LAST
      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 10 }]
      @UI.selectionField:  [{ position: 10 }]
      @UI.dataPoint: { criticalityValue: #POSITIVE, title: 'Airline' }
      @Consumption.valueHelpDefinition: [{ 
        qualifier: 'VisualFilter',
        label: 'Airline',
        entity: {
            name: '/DMO/I_Carrier_StdVH',
            element: 'AirlineID'
        },
        presentationVariantQualifier: 'PV_Airline'
       }]
  key Airline,
      @UI.textArrangement: #TEXT_LAST
      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 20 }]
  key FlightConnection,

      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 30 }]
  key FlightDate,
      @UI.textArrangement: #TEXT_LAST
      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 40 }]
  key Customer,
      @UI.textArrangement: #TEXT_LAST
      @AnalyticsDetails.query.axis: #FREE
      @UI.kpi: [{
     qualifier: 'KPI_Agency', detail.defaultPresentationVariantQualifier: 'PV_Agency'
     }]
      @UI.lineItem: [{ position: 50 }]
      @UI.selectionField:  [{ position: 30 }]
  key TravelAgency,

      @UI.kpi: [{
      qualifier: 'KPI_Year', detail.defaultPresentationVariantQualifier: 'PV_Year'
      }]
      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 60 }]
      CalendarYear,
      @UI.textArrangement: #TEXT_ONLY
      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 70 }]
      CalendarMonth,
      @UI.textArrangement: #TEXT_ONLY
      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 80 }]
      @UI.selectionField:  [{ position: 20 }]
      CustomerCountry,

      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 90 }]
      CustomerCity,
      @UI.textArrangement: #TEXT_ONLY
      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 100 }]
      TravelAgencyCountry,

      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 110 }]
      TravelAgencyCity,

      @AnalyticsDetails.query.axis: #FREE
      @UI.lineItem: [{ position: 120 }]
      Currency,
      //
      //    @AnalyticsDetails.query.axis: #FREE
      //    WeightUOM,

      /** MEASURES **/
      @EndUserText.label: 'Average Bookings Per Flight'
      //    @AnalyticsDetails.exceptionAggregationSteps: [{exceptionAggregationBehavior: #SUM },
      //    {exceptionAggregationElements: [ 'Airline', 'FlightConnection', 'FlightDate' ]} ]
      //    @AnalyticsDetails.query.formula: '$projection.WeightOfLuggage'
      @AnalyticsDetails.query.decimals: 0
      @AnalyticsDetails.query.formula: '$projection.TotalOfBookings'
          @DefaultAggregation: #SUM
      //    @AnalyticsDetails.exceptionAggregationSteps: [{exceptionAggregationBehavior: #SUM },
      //    {exceptionAggregationElements: [ 'Airline', 'FlightConnection', 'FlightDate' ]} ]
      @UI.lineItem: [{ position: 130 }]
      TotalOfBookings,
          @DefaultAggregation: #SUM

      @EndUserText.label: 'Total Bookingprice Per Flight'
      @AnalyticsDetails.exceptionAggregationSteps: [{ exceptionAggregationBehavior: #SUM }]
      @AnalyticsDetails.query.decimals: 0
      @AnalyticsDetails.query.formula: '$projection.BookingPrice'
      @UI.lineItem: [{ position: 140 }]
      
@UI.dataPoint: {
  title: 'Booking Price datapoint',
  valueFormat: { numberOfFractionalDigits: 2 },
  criticalityCalculation: {
    improvementDirection: #MAXIMIZE
  }
}
      @UI.kpi: [{
       qualifier: 'KPIBookingPrice'
       }]
      BookingPrice,
      @UI.kpi: [{
       qualifier: 'KPIQualifier', detail.defaultPresentationVariantQualifier: 'KPIQualifier'
       }]
      @UI: {
dataPoint: {
qualifier: 'KPIDataPoint',
title: 'PO',
valueFormat.numberOfFractionalDigits: 0,
//minimumValue: 0,
//maximumValue: 100,
criticalityCalculation: {
improvementDirection: #MAXIMIZE
//deviationRangeLowValue: 70,
//toleranceRangeLowValue: 84
}
}
}
@AnalyticsDetails.query.axis: #COLUMNS
@AnalyticsDetails.query.decimals: 0
@EndUserText.label: 'KPIQualifier'
@AnalyticsDetails.query.formula: '$projection.BookingPrice'
      
      
      1 as KPIQualifier

}
where Currency = 'USD'
