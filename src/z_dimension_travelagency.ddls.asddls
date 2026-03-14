@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Agency'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #DIMENSION
define view entity Z_Dimension_TravelAgency
  as select from /dmo/agency
  association [0..1] to I_Country as _Country on $projection.Country = _Country.Country
{
      @ObjectModel.text.element: [ 'TravelAgencyName' ]
  key agency_id as TravelAgency,
@Semantics.text: true
      name      as TravelAgencyName,
@ObjectModel.foreignKey.association: '_Country'
      @Semantics.address.country: true
      country_code   as Country,
@Semantics.address.city: true
      city      as City,
      
      _Country
} 
