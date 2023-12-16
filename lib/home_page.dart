import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:vidyurakshak_web/modules/dem/ui/dashboard_screen.dart';
import 'package:vidyurakshak_web/modules/dem/ui/drawer/tasks_scren_drawer.dart';
import 'package:vidyurakshak_web/modules/dem/ui/task_details.dart';
import 'package:vidyurakshak_web/modules/dem/ui/tasks_screen.dart';
import 'package:vidyurakshak_web/utils/enums/map_type_enums.dart';
import 'package:vidyurakshak_web/utils/screen_utils/screen_sizes.dart';
import 'package:vidyurakshak_web/utils/theme/app_colors.dart';
import 'package:vidyurakshak_web/utils/widgets/primary_text.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:ui';

import 'modules/dem/ui/dem_model_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final String geoTiffFilePath =
      'C:\\Users\\Puneet\\Downloads\\clipped_image.tiff';
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

  final controller_carbon = WebViewController()
    ..loadRequest(Uri.parse(
        'https://ee-singhaniruddh30.projects.earthengine.app/view/vidyurakshacarbonemission'));

  final controller_height_map = WebViewController()
    ..loadRequest(Uri.parse(
        'https://ee-singhaniruddh30.projects.earthengine.app/view/vidyurakshak'));

  final controller_modis = WebViewController()
    ..loadRequest(Uri.parse(
        'https://ee-singhaniruddh30.projects.earthengine.app/view/vidyurakshakvegetationclassification'));
  int _currentIndex = 0;
  final Set set = {};
  PageEnums _mapTypeEnums = PageEnums.carbon;

  Future<Uint8List> _readImage() async {
    ByteData data = await rootBundle.load(geoTiffFilePath);
    List<int> bytes = data.buffer.asUint8List();

    img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;

    return Uint8List.fromList(img.encodePng(image));
  }

  Widget getScreenContent(PageEnums pageEnum) {
    switch (pageEnum) {
      case PageEnums.carbon:
        return WebViewWidget(controller: controller_carbon);
      case PageEnums.dem:
        return const DemModelPage();
      case PageEnums.tasks:
        return const TasksScreen();
      case PageEnums.dashboard:
        return const DashboardScreen();
      case PageEnums.task_detail:
        return const TaskDetails();
      case PageEnums.height_map:
        return WebViewWidget(controller: controller_height_map);
      case PageEnums.modis:
        return WebViewWidget(controller: controller_modis);
      default:
        return WebViewWidget(controller: controller_carbon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          (_mapTypeEnums == PageEnums.carbon ||
                  _mapTypeEnums == PageEnums.dem ||
                  _mapTypeEnums == PageEnums.height_map ||
                  _mapTypeEnums == PageEnums.modis)
              ? Drawer(
                  elevation: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/profile_icon.png"),
                          radius: 30,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        PrimaryText(
                            weight: FontWeight.bold,
                            size: 14,
                            color: AppColors.primaryTextColor,
                            text: "Krishna Rao"),
                        const SizedBox(
                          height: 5,
                        ),
                        PrimaryText(
                            weight: FontWeight.normal,
                            size: 11,
                            color: Colors.grey.withOpacity(0.8),
                            text: "@abhi_navkare"),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading: Icon(drawerList[0].icon,
                              color: AppColors.primaryColor),
                          title: PrimaryText(
                              weight: FontWeight.bold,
                              size: 16,
                              color: AppColors.primaryTextColor,
                              text: drawerList[0].title),
                        ),
                        const SizedBox(
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
                              _mapTypeEnums = PageEnums.dem;
                            });
                          },
                          child: MapContainerWidget(
                              imageLoc: 'assets/dem_img.png',
                              selected: _mapTypeEnums == PageEnums.dem,
                              name: '3D model'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _mapTypeEnums = PageEnums.carbon;
                            });
                          },
                          child: MapContainerWidget(
                              imageLoc: 'assets/carbon_map.png',
                              selected: _mapTypeEnums == PageEnums.carbon,
                              name: 'Risk Assessment'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _mapTypeEnums = PageEnums.height_map;
                            });
                          },
                          child: MapContainerWidget(
                              imageLoc: 'assets/height_image.png',
                              selected: _mapTypeEnums == PageEnums.height_map,
                              name: 'Height Map'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _mapTypeEnums = PageEnums.modis;
                            });
                          },
                          child: MapContainerWidget(
                            imageLoc: 'assets/modis_image.png',
                            selected: _mapTypeEnums == PageEnums.modis,
                            name: 'vegetation Classification',
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       _mapTypeEnums = PageEnums.dem;
                        //     });
                        //   },
                        //   child: MapContainerWidget(
                        //     imageLoc: 'assets/dem_img.png',
                        //     selected: _mapTypeEnums == PageEnums.dem,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                )
              : const TasksScreenDrawer(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: ScreenSizes.screenHeight! * 0.08,
                    width: ScreenSizes.screenWidth! - 100,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'VidyuRakshak',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _mapTypeEnums = PageEnums.carbon;
                                });
                              },
                              child: Container(
                                height: ScreenSizes.screenHeight! * 0.1,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: _mapTypeEnums == PageEnums.carbon ||
                                        _mapTypeEnums == PageEnums.dem ||
                                        _mapTypeEnums == PageEnums.modis ||
                                        _mapTypeEnums == PageEnums.height_map
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    'Map',
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        color:
                                            _mapTypeEnums == PageEnums.carbon ||
                                                    _mapTypeEnums ==
                                                        PageEnums.dem ||
                                                    _mapTypeEnums ==
                                                        PageEnums.modis ||
                                                    _mapTypeEnums ==
                                                        PageEnums.height_map
                                                ? Colors.white
                                                : AppColors.primaryTextColor),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _mapTypeEnums = PageEnums.tasks;
                                });
                              },
                              child: Container(
                                height: ScreenSizes.screenHeight! * 0.1,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: _mapTypeEnums == PageEnums.tasks
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    'Tasks',
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        color: _mapTypeEnums == PageEnums.tasks
                                            ? Colors.white
                                            : AppColors.primaryTextColor),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _mapTypeEnums = PageEnums.dashboard;
                                });
                              },
                              child: Container(
                                height: ScreenSizes.screenHeight! * 0.1,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: _mapTypeEnums == PageEnums.dashboard
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    'Dashboard',
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        color:
                                            _mapTypeEnums == PageEnums.dashboard
                                                ? Colors.white
                                                : AppColors.primaryTextColor),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _mapTypeEnums = PageEnums.task_detail;
                                });
                              },
                              child: Container(
                                height: ScreenSizes.screenHeight! * 0.1,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: _mapTypeEnums == PageEnums.task_detail
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    'Task Detail',
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        color: _mapTypeEnums ==
                                                PageEnums.task_detail
                                            ? Colors.white
                                            : AppColors.primaryTextColor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Icon(Icons.more_vert)
                          ],
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        margin: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        height: ScreenSizes.screenHeight,
                        child: getScreenContent(_mapTypeEnums)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MapContainerWidget extends StatefulWidget {
  final String imageLoc;
  final bool selected;
  final String name;

  const MapContainerWidget({
    Key? key,
    required this.imageLoc,
    required this.selected,
    required this.name,
  }) : super(key: key);

  @override
  _MapContainerWidgetState createState() => _MapContainerWidgetState();
}

class _MapContainerWidgetState extends State<MapContainerWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: widget.selected
                ? AppColors.primaryColor
                : (isHovered ? Colors.grey : Colors.transparent),
            width: 3,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: ScreenSizes.screenWidth! * 0.18,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(widget.imageLoc),
                ),
              ),
            ),
            if (isHovered) BlurredOverlay(text: widget.name),
          ],
        ),
      ),
    );
  }
}

class BlurredOverlay extends StatelessWidget {
  final String text;

  const BlurredOverlay({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          color: Colors.grey.withOpacity(0.3),
          width: ScreenSizes.screenWidth! * 0.18,
          height: 150,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
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
