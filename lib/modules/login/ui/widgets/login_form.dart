import 'package:flutter/material.dart';
import 'package:vidyurakshak_web/modules/login/ui/signup_screen.dart';
import 'package:vidyurakshak_web/modules/login/ui/widgets/have_account_check.dart';
import 'package:vidyurakshak_web/utils/theme/app_colors.dart';

class LoginForm extends StatelessWidget {
  final double defaultPadding = 16.0;
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: AppColors.primaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Login".toUpperCase(),
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
