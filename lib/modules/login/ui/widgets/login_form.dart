import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vidyurakshak_web/home_page.dart';
import 'package:vidyurakshak_web/modules/login/ui/signup_screen.dart';
import 'package:vidyurakshak_web/modules/login/ui/widgets/have_account_check.dart';
import 'package:vidyurakshak_web/utils/screen_utils/screen_sizes.dart';
import 'package:vidyurakshak_web/utils/theme/app_colors.dart';

class LoginForm extends StatelessWidget {
  final double defaultPadding = 16.0;
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailTextEditingController,
            textInputAction: TextInputAction.next,
            cursorColor: AppColors.primaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              iconColor: AppColors.primaryColor.withOpacity(0.5),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.primaryColor.withOpacity(0.5))),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 2)),
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              controller: _passwordTextEditingController,
              obscureText: true,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                iconColor: AppColors.primaryColor.withOpacity(0.5),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.primaryColor.withOpacity(0.5))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.primaryColor, width: 2)),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(
                    Icons.lock,
                    color: AppColors.primaryColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: ScreenSizes.screenWidth! * 0.2,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextEditingController.text,
                          password: _passwordTextEditingController.text);

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
