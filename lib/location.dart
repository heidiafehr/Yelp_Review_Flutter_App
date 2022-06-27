
class Location {
  final String addressLineOne;
  final String city;
  final String state;
  final String zipcode;

  Location({
    required this.addressLineOne,
    required this.city,
    required this.state,
    required this.zipcode,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        addressLineOne: json['address1'],
        city: json['city'],
        state: json['state'],
        zipcode: json['zip_code'],
    );
  }
}
