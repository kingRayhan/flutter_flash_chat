import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/common/widgets/app_button.dart';
import 'package:flash_chat/common/widgets/app_textfield.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

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
          children: <Widget>[
            _logo(),
            const SizedBox(height: 48.0),
            AppTextfield(),
            const SizedBox(height: 8.0),
            AppButton(
              label: "Login",
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
              text: "Don’t have any account?",
              style: TextStyle(color: Colors.grey)),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).pushNamed(RegistrationScreen.id);
              },
            text: " Register Now",
            style: const TextStyle(
                color: Colors.grey, decoration: TextDecoration.underline),
          )
        ],
      ),
    );
  }

  Hero _logo() {
    return Hero(
      tag: 'flash_logo',
      child: SizedBox(
        height: 200.0,
        child: Image.asset('images/logo.png'),
      ),
    );
  }
}
