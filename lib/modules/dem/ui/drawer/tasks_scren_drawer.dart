import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyurakshak_web/utils/enums/priority_enum.dart';
import 'package:vidyurakshak_web/utils/screen_utils/screen_sizes.dart';
import 'package:vidyurakshak_web/utils/theme/app_colors.dart';

class TasksScreenDrawer extends StatefulWidget {
  const TasksScreenDrawer({super.key});

  @override
  State<TasksScreenDrawer> createState() => _TasksScreenDrawerState();
}

class _TasksScreenDrawerState extends State<TasksScreenDrawer> {
  PriorityEnum priorityEnum = PriorityEnum.low;

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
            const SizedBox(
              height: 20,
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      priorityEnum = PriorityEnum.low;
                    });
                  },
                  child: Chip(
                    label: Text(
                      'Low',
                      style: GoogleFonts.lato(
                          color: priorityEnum == PriorityEnum.low
                              ? Colors.white
                              : AppColors.primaryTextColor),
                    ),
                    backgroundColor: priorityEnum == PriorityEnum.low
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                            color: priorityEnum != PriorityEnum.low
                                ? AppColors.primaryColor
                                : Colors.transparent)),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      priorityEnum = PriorityEnum.medium;
                    });
                  },
                  child: Chip(
                    label: Text(
                      'Medium',
                      style: GoogleFonts.lato(
                          color: priorityEnum == PriorityEnum.medium
                              ? Colors.white
                              : AppColors.primaryTextColor),
                    ),
                    backgroundColor: priorityEnum == PriorityEnum.medium
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                            color: priorityEnum != PriorityEnum.medium
                                ? AppColors.primaryColor
                                : Colors.transparent)),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      priorityEnum = PriorityEnum.high;
                    });
                  },
                  child: Chip(
                    label: Text(
                      'High',
                      style: GoogleFonts.lato(
                          color: priorityEnum == PriorityEnum.high
                              ? Colors.white
                              : AppColors.primaryTextColor),
                    ),
                    backgroundColor: priorityEnum == PriorityEnum.high
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                            color: priorityEnum != PriorityEnum.high
                                ? AppColors.primaryColor
                                : Colors.transparent)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
