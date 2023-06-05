// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/languages.dart';

class PickLocation extends StatefulWidget {
  static const routeName = '/pick_location';

  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  Completer<GoogleMapController> mapcontroller = Completer();

  TextEditingController searchController = TextEditingController();

  static CameraPosition locationposition =
      const CameraPosition(target: LatLng(51.5403, 0.1482), zoom: 10.46);

  Map<String, Marker> markers = {};
  String _address = "2464 Royal Ln. Mesa, New Jersey 45463";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: GoogleMap(
              initialCameraPosition: locationposition,
              onTap: (LatLng latLng) async {
                final MarkerId markerId = MarkerId('yourLocation');
                final Marker marker = Marker(
                    markerId: markerId,
                    position: latLng,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueViolet));

                var latitude;
                var longitude;

                markers.forEach((key, value) {
                  latitude = value.position.latitude;
                  longitude = value.position.longitude;
                });
                List<Placemark> newPlace =
                    await placemarkFromCoordinates(latitude, longitude);

                Placemark placeMark = newPlace[0];
                String street = placeMark.street!;
                String administrativeArea = placeMark.administrativeArea!;
                String postalCode = placeMark.postalCode!;
                String country = placeMark.country!;
                String address =
                    "$street, $administrativeArea $postalCode, $country";

                setState(() {
                  _address = address;
                  markers.clear();

                  markers["yourLocation"] = marker;
                });
              },
              onMapCreated: (GoogleMapController controller) {
                mapcontroller.complete(controller);
                addMarker(
                  'yourLocation',
                  const LatLng(51.5403, 0.1482),
                );
              },
              markers: markers.values.toSet(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                heightSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          String textToSendBack =
                              "2464 Royal Ln. Mesa, New Jersey 45463";
                          Navigator.pop(context, textToSendBack);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 22,
                          color: blackColor,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: languageValue == "عربي"
                              ? EdgeInsets.only(left: fixPadding)
                              : EdgeInsets.only(right: fixPadding),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: grey94Color.withOpacity(0.5),
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                    primary: primaryColor)),
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                                hintText: getTranslate(
                                    context, 'pick_location.search_location'),
                                hintStyle: semibold14grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 2,
                    vertical: fixPadding * 2,
                  ),
                  padding: const EdgeInsets.all(fixPadding * 2),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: grey94Color.withOpacity(0.5), blurRadius: 5),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: primaryColor,
                      ),
                      widthSpace,
                      width5Space,
                      Expanded(
                          child: Text(
                        _address,
                        style: regular14black,
                      ))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pickaddress(context);
                  },
                  child: Container(
                    height: size.height * 0.07,
                    margin:
                        const EdgeInsets.symmetric(horizontal: fixPadding * 2),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: gradient,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.25),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      getTranslate(context, 'pick_location.pick_location'),
                      style: semibold18white,
                    ),
                  ),
                ),
                heightSpace,
                heightSpace,
                heightSpace,
              ],
            ),
          )
        ],
      ),
    );
  }

  addMarker(String id, LatLng location) async {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    );

    markers[id] = marker;
    setState(() {});
  }

  void pickaddress(BuildContext context) {
    String textToSendBack = _address;
    Navigator.pop(context, textToSendBack);
  }
}
