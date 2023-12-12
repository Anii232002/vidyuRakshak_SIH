import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:vidyurakshak_web/utils/enums/map_type_enums.dart';
import 'package:vidyurakshak_web/utils/screen_utils/screen_sizes.dart';
import 'package:vidyurakshak_web/utils/theme/app_colors.dart';
import 'package:vidyurakshak_web/utils/widgets/primary_text.dart';

import 'modules/dem/ui/dem_model_page.dart';

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
  final drawerList = [
    DrawerListModel(title: "Home", icon: Icons.home),
    DrawerListModel(title: "Search", icon: Icons.search),
    DrawerListModel(title: "Regulations", icon: Icons.newspaper),
    DrawerListModel(title: "Videos", icon: Icons.movie),
    DrawerListModel(title: "Topics", icon: Icons.topic),
    DrawerListModel(title: "My Favourites", icon: Icons.star_border),
    DrawerListModel(title: "Logout", icon: Icons.logout),
  ];

  int _currentIndex = 0;
  MapTypeEnums _mapTypeEnums = MapTypeEnums.carbon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Drawer(
            elevation: 0,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/profile_icon.png"),
                  radius: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                PrimaryText(
                    weight: FontWeight.bold,
                    size: 14,
                    color: AppColors.primaryTextColor,
                    text: "Krishna Rao"),
                SizedBox(
                  height: 5,
                ),
                PrimaryText(
                    weight: FontWeight.normal,
                    size: 11,
                    color: Colors.grey.withOpacity(0.8),
                    text: "@abhi_navkare"),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(
                    drawerList[0].icon,
                    color: (_currentIndex == 0)
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.6),
                  ),
                  title: PrimaryText(
                      weight: (_currentIndex == 0)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      size: 16,
                      color: (_currentIndex == 0)
                          ? AppColors.primaryTextColor
                          : AppColors.primaryTextColor.withOpacity(0.6),
                      text: drawerList[0].title),
                  onTap: () {
                    setState(
                      () {
                        _currentIndex = 0;
                        if (_currentIndex == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DemModelPage()));
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Map types',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _mapTypeEnums = MapTypeEnums.carbon;
                    });
                  },
                  child: MapContainerWidget(
                    imageLoc: 'assets/carbon_map.png',
                    selected: _mapTypeEnums == MapTypeEnums.carbon,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _mapTypeEnums = MapTypeEnums.dem;
                    });
                  },
                  child: MapContainerWidget(
                    imageLoc: 'assets/dem_img.png',
                    selected: _mapTypeEnums == MapTypeEnums.dem,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                margin: const EdgeInsets.all(12),

                decoration: const BoxDecoration(
                  color: Colors.white,
                ),

                // color: Colors.white,
                height: ScreenSizes.screenHeight,
                child: _mapTypeEnums == MapTypeEnums.dem
                    ? const ModelViewer(
                        src: 'assets/power_line_dem.glb',
                        backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
                        alt: 'A 3D model of an astronaut',
                        ar: true,
                        autoRotate: true,
                      )
                    : GoogleMap(
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

class MapContainerWidget extends StatelessWidget {
  final String imageLoc;
  final bool selected;

  const MapContainerWidget(
      {super.key, required this.imageLoc, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: selected ? AppColors.primaryColor : Colors.transparent,
            width: 3),
      ),
      child: Container(
        width: ScreenSizes.screenWidth! * 0.18,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(imageLoc),
          ),
        ),
      ),
    );
  }
}

class DrawerListModel {
  final String title;
  final IconData icon;
  DrawerListModel({
    required this.title,
    required this.icon,
  });
}
