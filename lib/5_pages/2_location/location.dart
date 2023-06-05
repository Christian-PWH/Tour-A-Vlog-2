import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = '/location';

  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Completer<GoogleMapController> mapcontroller = Completer();

  static CameraPosition locationposition =
      const CameraPosition(target: LatLng(51.5072, 0.1276), zoom: 10.46);

  Map<String, Marker> markers = {};

  BitmapDescriptor? customIcon;
  BitmapDescriptor? customIcon2;

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  final Set<Polyline> _polyline = {};

  List<LatLng> latLen = [
    const LatLng(51.4060, 0.0132),
    const LatLng(51.4265, 0.1009),
    const LatLng(51.5566, 0.0763),
    const LatLng(51.5771, 0.1783),
  ];

  @override
  void initState() {
    super.initState();
    _polyline.add(
      Polyline(
          polylineId: const PolylineId('1'),
          color: primaryColor,
          points: latLen,
          width: 7,
          endCap: Cap.roundCap),
    );
    getBytesFromAsset('assets/location/Group 307.png', 64).then((onValue) {
      customIcon = BitmapDescriptor.fromBytes(onValue);
    });
    getBytesFromAsset('assets/location/home (1).png', 80).then((onValue) {
      customIcon2 = BitmapDescriptor.fromBytes(onValue);
    });
  }

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
              polylines: _polyline,
              onMapCreated: (GoogleMapController controller) {
                mapcontroller.complete(controller);
                addMarker(
                  'yourLocation',
                  const LatLng(51.4060, 0.0132),
                  customIcon,
                );
                addMarker(
                  "location",
                  const LatLng(51.5771, 0.1783),
                  customIcon2,
                );
              },
              markers: markers.values.toSet(),
            ),
          ),
          Column(
            children: [
              heightSpace,
              heightSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      padding: const EdgeInsets.all(fixPadding * 2),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 22,
                        color: blackColor,
                      ))
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: fixPadding * 3,
                vertical: fixPadding * 2,
              ),
              padding: const EdgeInsets.all(fixPadding * 2),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: grey94Color.withOpacity(0.5), blurRadius: 5),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/location/Group 312.png",
                      width: size.width * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  widthSpace,
                  width5Space,
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hard Rock Hotel Bali",
                        style: semibold18black,
                      ),
                      Text(
                        "2.2km ${getTranslate(context, 'location.aways')}",
                        style: regular14grey,
                      ),
                      Row(
                        children: [
                          Text(
                            "${getTranslate(context, 'location.reach_time')} : ",
                            style: regular14black,
                          ),
                          Text(
                            "10 min.",
                            style: regular14black.copyWith(
                              color: const Color(0xff06919D),
                            ),
                          )
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  addMarker(String id, LatLng location, customicon) async {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      icon: customicon,
    );

    markers[id] = marker;
    setState(() {});
  }
}
