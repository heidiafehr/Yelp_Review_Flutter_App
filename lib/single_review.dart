class SingleUserReview {
  final String text;
//  final int ratingNumber;
//  final UserInfo user;

  SingleUserReview({
    required this.text,
//    required this.ratingNumber,
//    required this.user,
  });

  factory SingleUserReview.fromJson(Map<String, dynamic> json) {
    return SingleUserReview(
      text: json['text'],
 //     ratingNumber: json['rating'],
//      user: json['user'],
    );
  }
}

/*class UserInfo {
  final String imageURL;
  final String name;

  UserInfo({
    required this.imageURL,
    required this.name,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      imageURL: json['image_url'],
      name: json['name'],
    );
  }
}*/
