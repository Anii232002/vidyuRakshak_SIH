import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidyurakshak_web/modules/login/responsive.dart';
import 'package:vidyurakshak_web/modules/login/ui/widgets/background.dart';
import 'package:vidyurakshak_web/modules/login/ui/widgets/login_signup_button.dart';
import 'package:vidyurakshak_web/modules/login/ui/widgets/welcome_image.dart';
import 'package:vidyurakshak_web/utils/screen_utils/screen_sizes.dart';
import 'package:vidyurakshak_web/utils/theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Padding(
              padding: EdgeInsets.only(top: ScreenSizes.screenHeight! * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenSizes.screenWidth! * 0.18, top: 10),
                    child: RichText(
                      text: TextSpan(
                          text: 'Welcome To ',
                          style: GoogleFonts.lato(
                              fontSize: 45, fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(
                              text: 'VidyuRakshak',
                              style: GoogleFonts.lato(
                                  fontSize: 45,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor),
                            )
                          ]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: WelcomeImage(),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 450,
                              child: LoginAndSignupBtn(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            mobile: MobileWelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WelcomeImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
