import 'package:flutter/material.dart';
import 'package:vidyurakshak_web/utils/theme/app_colors.dart';
import 'package:vidyurakshak_web/utils/widgets/primary_text.dart';

class CustomAppDrawer extends StatefulWidget {
  const CustomAppDrawer({super.key});

  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          Expanded(
              child: ListView.builder(
                  itemCount: drawerList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        drawerList[index].icon,
                        color: (_currentIndex == index)
                            ? AppColors.primaryColor
                            : AppColors.primaryColor.withOpacity(0.6),
                      ),
                      title: PrimaryText(
                          weight: (_currentIndex == index)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          size: 14,
                          color: (_currentIndex == index)
                              ? AppColors.primaryTextColor
                              : AppColors.primaryTextColor.withOpacity(0.6),
                          text: drawerList[index].title),
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    );
                  }))
        ],
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
