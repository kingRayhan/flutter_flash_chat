import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/common/toast.dart';
import 'package:flash_chat/common/widgets/app_button.dart';
import 'package:flash_chat/common/widgets/app_textfield.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextfield(
                    hintText: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    controller: emailTextController,
                    validator:
                        ValidationBuilder().email().maxLength(50).build(),
                  ),
                  const SizedBox(height: 8.0),
                  AppTextfield(
                    hintText: "Password",
                    controller: passwordTextController,
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
                    label: "Login",
                    onPressed: _handleLoginUser,
                    loading: loading,
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

  Future<void> _handleLoginUser() async {
    // submit after validation
    if (!_formKey.currentState!.validate()) return;
    setState(() => loading = true);
    print("email: ${emailTextController.text}");
    print("password: ${passwordTextController.text}");

    try {
      final newUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      if (!context.mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(ChatScreen.id, (route) => false);
      showToast(
        message: "Successfully loggedin",
        context: context,
        type: ToastType.success,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(
          message: 'No user found for that email.',
          context: context,
          type: ToastType.error,
        );
      } else if (e.code == 'wrong-password') {
        showToast(
          message: 'Wrong password provided for that user.',
          context: context,
          type: ToastType.error,
        );
      } else {
        showToast(
          message: 'Wrong password provided for that user.',
          context: context,
          type: ToastType.error,
        );
      }
    } catch (e) {
      if (context.mounted) {
        showToast(
          message: 'Failed to login',
          context: context,
          type: ToastType.error,
        );
      }
    } finally {
      setState(() => loading = false);
    }
  }
}
