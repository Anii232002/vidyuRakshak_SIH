import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyurakshak_web/utils/screen_utils/screen_sizes.dart';
import 'package:vidyurakshak_web/utils/theme/app_colors.dart';

class TasksScreenDrawer extends StatefulWidget {
  const TasksScreenDrawer({super.key});

  @override
  State<TasksScreenDrawer> createState() => _TasksScreenDrawerState();
}

class _TasksScreenDrawerState extends State<TasksScreenDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenSizes.screenHeight! * 0.2 - 50,
            ),
            Text(
              'Filters',
              style: GoogleFonts.lato(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryTextColor),
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
