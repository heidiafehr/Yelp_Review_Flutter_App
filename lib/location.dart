
class Location {
  //final DisplayAddress displayAddress;
  final String addressLineOne;
  final String city;
  final String state;
  final String zipcode;

  Location({
    //required this.displayAddress,
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
        /*displayAddress: DisplayAddress.fromStringArray(
            (json['display_address'] as List)
                .map((address) => address.toString())
                .toList())*/
    );
  }
}

/*class DisplayAddress {
  final String addressLineOne;
  final String addressLineTwo;
  final String? addressLineThree;

  DisplayAddress({
    required this.addressLineOne,
    required this.addressLineTwo,
    this.addressLineThree,
  });

  factory DisplayAddress.fromStringArray(List<String> addresses) {
    return DisplayAddress(
        addressLineOne: addresses[0],
        addressLineTwo: addresses[1],
        addressLineThree: (addresses.length >= 3) ? addresses[2] : null,
    );
  }
}*/
