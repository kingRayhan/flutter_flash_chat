import 'package:flash_chat/common/widgets/app_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'flash_logo',
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const Text(
                  'Flash Chat Now',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48.0),
            AppButton(
              label: 'Login',
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.id);
              },
            ),
            const SizedBox(height: 18.0),
            AppButton(
              label: 'Register',
              color: Colors.blueAccent,
              textcolor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed(RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
