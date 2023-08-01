# Yelp Review App

This applicaiton is an end-to-end, multipage Flutter application that displays nearby restaurants and their information. Selecting a restaurant navigates to another screen and displays the full restaurant details & reviews and its location on Google Maps.

![alt text](https://github.com/heidiafehr/Yelp_Review_Flutter_App/blob/master/RestauranTourScreenShot.jpg)
# How To Run It
Here are instructions on how to get your copy of the repo up and running on your local machine.

## Prerequisites
You will need both Yelp andn Google Maps API requests.
I have provided the boilerplate of the API requests and backing data models to save you some time. To successfully make a request to the Yelp GraphQL API and Google Maps API, please follow these steps:

### Yelp
1. Please go to https://www.yelp.com/signup and sign up for a developer account.
2. Follow the authentication guide on https://docs.developer.yelp.com/docs/fusion-intro and generate your API key.
3. Create a file in the root directory of `lib\services` with the name `secret_services.dart`
4. This file will contain the following. Replace the API generated in previous steps (include 'Bearer ' at the beginning of the value).
`const yelpKey = 'YOUR KEY HERE';`

### Google Maps
Note: Some information comes from the README for [Google Maps for Flutter]([url](https://pub.dev/packages/google_maps_flutter)https://pub.dev/packages/google_maps_flutter).
1. Sign up and generate an API key at https://cloud.google.com/maps-platform/
2. Enable the Google Map SKD for Android and iOS
    _Edit the API key_

    - Go to the Google Developers Console
    - Choose the project that you want to enable Google Maps on
    - Select the navigation menu and then select "Google Maps"
    - Select "APIs" under the Google Maps menu
    - To enable Google Maps for Android, select "Maps SDK for Android" in the "Additional APIs" section, then select "ENABLE"
    - To enable Google Maps for iOS, select "Maps SDK for iOS" in the "Additional APIs" section, then select "ENABLE"
    - Make sure the APIs you enabled are under the "Enabled APIs" section
3. Create a file in `android\app\src\main\res\values` and name it `strings.xml`
4. Paste the following code and insert the API key generated in the previous step:
`<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="MAPS_KEY">YOUR KEY HERE</string>
</resources>`

6. Create a file in `ios\Runner` and name it `secrets.swift`
7. Paste the following code and insert the API key generated in previous steps:
`struct Constants {
    static let MAP_KEY = "YOUR KEY HERE"
}`


