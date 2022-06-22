import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomYelpAppBar extends StatelessWidget {
  const CustomYelpAppBar(this.title, {Key? key,}) : super(key :key);

  final String title;

  @override
  Widget build(BuildContext context){
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0.5),
        //sets status bar background to white
        statusBarIconBrightness: Brightness.dark,
        //sets text colors to dark color
        statusBarBrightness: Brightness.dark,
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Text(title,
            style: Theme.of(context).textTheme.headline1,
            overflow: TextOverflow.ellipsis)
      ),
    );
  }
}