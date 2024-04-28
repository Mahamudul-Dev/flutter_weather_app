class LocationModel {
  String? errorMessage;
  double? lat;
  double? lon;
  String? city;
  String? country;
  LocationModel({
    this.errorMessage,
    this.lat,
    this.lon,
    this.city,
    this.country,
  });

  Map<String, dynamic> toJson()=>{
    'errorMessage': errorMessage,
    'latitude': lat,
    'longitude': lon,
    'city': city,
    'country': country
  };
}
