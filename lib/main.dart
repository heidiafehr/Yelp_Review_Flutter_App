import 'package:flutter/material.dart';
import 'package:yelp_app/service_locator.dart';
import 'package:yelp_app/yelp_review_app.dart';

void main() {
  setupDependencies();

  runApp(const YelpReviewApp());
}
