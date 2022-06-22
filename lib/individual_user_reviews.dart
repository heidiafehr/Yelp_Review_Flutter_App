class IndividualUserReviews {
  final String text;
  final num ratingNumber;
  final UserInfo user;

  IndividualUserReviews({
    required this.text,
    required this.ratingNumber,
    required this.user,
  });

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
  final String name;

  UserInfo({
    this.imageURL,
    required this.name,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      imageURL: json['image_url'],
      name: json['name'],
    );
  }
}
