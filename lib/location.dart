
class Location {
  final DisplayAddress displayAddress;

  Location({
    required this.displayAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        displayAddress: DisplayAddress.fromStringArray(
            (json['display_address'] as List)
                .map((address) => address.toString())
                .toList())
    );
  }
}

class DisplayAddress {
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
}
