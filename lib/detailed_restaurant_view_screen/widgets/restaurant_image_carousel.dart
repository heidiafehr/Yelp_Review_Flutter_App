import 'package:flutter/material.dart';

class RestaurantImageCarousel extends StatelessWidget {
  final List<String>? photos;

  const RestaurantImageCarousel({Key? key, required this.photos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (photos != null && photos!.isNotEmpty) {
      return Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.7,
            child: PageView(
                children: photos!
                    .map((photo) => Image.network(
                          photo,
                          fit: BoxFit.cover,
                        ))
                    .toList()),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width - 30.0,
            child: Container(
              color: Colors.grey.withOpacity(0.3),
              child: const Icon(
                Icons.more_horiz,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
