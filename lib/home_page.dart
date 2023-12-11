import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vidyurakshak_web/utils/screen_utils/screen_sizes.dart';
import 'package:vidyurakshak_web/utils/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.1707, 74.6869),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomAppDrawer(),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                margin: EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.white,
                ),

                // color: Colors.white,
                height: ScreenSizes.screenHeight,
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
