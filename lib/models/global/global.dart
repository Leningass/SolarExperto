

import '../city/city.dart';

class Global {
  String id;
  CityModel? city;
  String contSafetyFactor;
  String inverterEfficiency ;
  String batteryDod ;
  String roundTripEfficiency ;
  String deRatingFactor ;
  String lifeTime ;
  String batteryAutonomy ;

  Global({
    required this.id,
     this.city,
    required this.contSafetyFactor,
    required this.inverterEfficiency,
    required this.batteryDod,
    required this.roundTripEfficiency,
    required this.deRatingFactor,
    required this.lifeTime,
    required this.batteryAutonomy,
  });


}


