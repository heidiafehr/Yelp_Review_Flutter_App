
class Location {
  final String? addressLineOne;
  final String? city;
  final String? state;
  final String? zipcode;

  Location({
    this.addressLineOne,
    this.city,
    this.state,
    this.zipcode,
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
