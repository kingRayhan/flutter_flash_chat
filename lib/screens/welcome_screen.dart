import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/common/toast.dart';
import 'package:flash_chat/common/widgets/app_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _firebaseAuth = FirebaseAuth.instance;

  void initFirebaseState() {
    _firebaseAuth.authStateChanges().listen((User? user) async {
      if (user != null) {
        Navigator.pushNamed(context, ChatScreen.id);
      }
    });
  }

  @override
  void initState() {
    initFirebaseState();
    super.initState();
  }

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
                    height: 75.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Flash Chat',
                        textStyle: const TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w900,
                        ),
                        speed: Duration(milliseconds: 300))
                  ],
                )
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
