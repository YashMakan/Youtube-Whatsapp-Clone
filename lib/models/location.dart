class Location {
  static const String streetKey = "street";
  static const String cityKey = "city";
  static const String stateKey = "state";
  static const String postcodeKey = "postcode";

  final String? street;
  final String? city;
  final String? state;
  final String? postcode;

  Location(
      {this.street,
      this.city,
      this.state,
      this.postcode});

  factory Location.fromJson(Map? json) => Location(
      street: json?[streetKey],
      city: json?[cityKey],
      state: json?[stateKey],
      postcode: json?[postcodeKey].toString());

  toJson() => {
        streetKey: street,
        cityKey: city,
        stateKey: state,
        postcodeKey: postcode,
      };
}
