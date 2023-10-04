import 'package:flash_chat/common/widgets/app_button.dart';
import 'package:flash_chat/common/widgets/app_textfield.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'flash_logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(height: 48.0),
            AppTextfield(),
            const SizedBox(height: 8.0),
            AppTextfield(),
            const SizedBox(height: 24.0),
            AppButton(
              label: "Register",
              onPressed: () {},
            ),
            const SizedBox(height: 12.0),
            _bottomText(context)
          ],
        ),
      ),
    );
  }

  RichText _bottomText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
              text: "Already have an account?",
              style: TextStyle(color: Colors.grey)),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).pushNamed(LoginScreen.id);
              },
            text: " Login Now",
            style: const TextStyle(
                color: Colors.grey, decoration: TextDecoration.underline),
          )
        ],
      ),
    );
  }
}
