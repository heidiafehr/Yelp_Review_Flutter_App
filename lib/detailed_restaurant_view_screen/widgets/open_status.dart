import 'package:flutter/material.dart';

///This will display the open status of the restaurant
///assumes that isOpenNow is not null
class OpenStatus extends StatelessWidget {
  final bool isOpenNow;

  const OpenStatus({Key? key, required this.isOpenNow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          (isOpenNow) ? 'Open Now' : 'Closed Now',
          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 13.5),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Icon(
            Icons.circle,
            color: (isOpenNow) ? Colors.green : Colors.red,
            size: 11.5,
          ),
        ),
      ],
    );
  }
}
