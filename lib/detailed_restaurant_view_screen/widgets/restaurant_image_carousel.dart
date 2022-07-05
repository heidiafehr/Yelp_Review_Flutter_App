import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RestaurantImageCarousel extends StatefulWidget {
  final List<String> photos;

  const RestaurantImageCarousel({Key? key, required this.photos})
      : super(key: key);

  @override
  State<RestaurantImageCarousel> createState() =>
      _ImageCarousel(photos: photos);
}

class _ImageCarousel extends State<RestaurantImageCarousel> {
  int activePage = 1;
  final List<String> photos;

  _ImageCarousel({Key? key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.width * 0.7,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            onPageChanged: (position, _) {
              setState((){
                activePage = position;
              },);
            },
          ),
          items: photos.map<Widget>(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.7,
                    child: Image.network(
                      i,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            },
          ).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(photos.length, activePage),
          ),
        ),
      ],
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
