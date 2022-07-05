class IndividualUserReviews {
  final String? text;
  final num? ratingNumber;
  final UserInfo user;

  IndividualUserReviews({
    this.text,
    this.ratingNumber,
    required this.user,
  });

  bool get textIsValid => text != null && text!.isNotEmpty;
  bool get reviewNameIsValid => user.name != null && user.name!.isNotEmpty;

  factory IndividualUserReviews.fromJson(Map<String, dynamic> json) {
    return IndividualUserReviews(
      text: json['text'],
      ratingNumber: json['rating'],
      user: UserInfo.fromJson(json['user']),
    );
  }
}

class UserInfo {
  final String? imageURL;
  final String? name;

  UserInfo({
    this.imageURL,
    this.name,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      imageURL: json['image_url'],
      name: json['name'],
    );
  }
}
