import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class YelpRefreshIndicator extends StatelessWidget {
  final Widget child;
  final AsyncCallback onRefresh;

  const YelpRefreshIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isTestMode ? const Icon(
      Icons.refresh,
      color: Colors.blue,
    ) : RefreshIndicator(
      onRefresh: onRefresh,
      child: child,
    );
  }
}