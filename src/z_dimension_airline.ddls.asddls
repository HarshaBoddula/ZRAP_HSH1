@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airline'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #DIMENSION

define view entity Z_Dimension_Airline
  as select from /dmo/carrier
{
      @ObjectModel.text.element: [ 'AirlineName' ]
  key carrier_id    as Airline,

      @Semantics.text: true
      name          as AirlineName,

      currency_code as Currency
}
