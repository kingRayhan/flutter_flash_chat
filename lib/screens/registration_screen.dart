import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/common/widgets/app_button.dart';
import 'package:flash_chat/common/widgets/app_textfield.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextfield(
                    hintText: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    validator:
                        ValidationBuilder().email().maxLength(50).build(),
                  ),
                  const SizedBox(height: 8.0),
                  AppTextfield(
                    hintText: "Password",
                    obscureText: true,
                    validator: ValidationBuilder()
                        .required()
                        .minLength(6)
                        .maxLength(20)
                        .build(),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 24.0),
                  AppButton(
                    label: "Register",
                    onPressed: _handleRegisterUser,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            _bottomText(context)
          ],
        ),
      ),
    );
  }

  void _handleRegisterUser() async {
    _formKey.currentState!.validate();
    print("Validating user input");
    // try {
    //   final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
    //       email: "rayhan.dev.bd@gmail.com", password: "rayhan123");
    //   print(newUser.user!.uid);
    // } catch (e) {
    //   print(e.toString());
    // }
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
