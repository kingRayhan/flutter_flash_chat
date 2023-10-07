import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/common/toast.dart';
import 'package:flash_chat/common/widgets/app_button.dart';
import 'package:flash_chat/common/widgets/app_textfield.dart';
import 'package:flash_chat/screens/chat_screen.dart';
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
                    label: "Register",
                    onPressed: _handleRegisterUser,
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

  void _handleRegisterUser() async {
    // submit after validation
    if (!_formKey.currentState!.validate()) return;
    setState(() => loading = true);
    print("email: ${emailTextController.text}");
    print("password: ${passwordTextController.text}");

    try {
      final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      if (!context.mounted) return;

      // TODO: Save user to firestore
      // TODO: Redirect user to chat screen
      Navigator.of(context).pushNamed(ChatScreen.id);
      showToast(
        message: "Successfully registered",
        context: context,
        type: ToastType.success,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'weak-password') {
        showToast(
          message: 'The password provided is too weak.',
          context: context,
          type: ToastType.error,
        );
      } else if (e.code == 'email-already-in-use') {
        showToast(
          message: 'The account already exists for that email.',
          context: context,
          type: ToastType.error,
        );
      }
    } catch (e) {
      showToast(
        message: 'Something went wrong!',
        context: context,
        type: ToastType.error,
      );
    } finally {
      setState(() => loading = false);
    }
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
