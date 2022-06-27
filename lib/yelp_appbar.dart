import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomYelpAppBar extends StatelessWidget {
  const CustomYelpAppBar({
    required this.title,
    this.elevations,
    required this.addNavigateBack,
    Key? key,
  }) : super(key: key);

  final String title;
  final double? elevations;
  final bool addNavigateBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: addNavigateBack
          ? ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent, shadowColor: Colors.transparent),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30.0,
              ),
            )
          : const SizedBox.shrink(),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0.5),
        //sets status bar background to white
        statusBarIconBrightness: Brightness.dark,
        //sets text colors to dark color
        statusBarBrightness: Brightness.dark,
      ),
      elevation: elevations ?? 0.0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Text(title,
            style: Theme.of(context).textTheme.headline1,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
