// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:chat_app/screens/register/register_screen.dart';
import 'package:chat_app/shared/constants.dart';
import 'package:chat_app/shared/widgets/app_button.dart';
import 'package:chat_app/shared/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String id = 'Login Page';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth(context) * 0.05,
                right: screenWidth(context) * 0.05,
                top: screenHeight(context) * 0.1),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/scholar.png'),
                  SizedBox(height: screenHeight(context) * 0.05),
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth(context) * 0.064, //24
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  SizedBox(height: screenHeight(context) * 0.12),
                  AppFormField(
                    controller: emailController,
                    label: 'Email',
                    keyboard: TextInputType.emailAddress,
                  ),
                  SizedBox(height: screenHeight(context) * 0.02),
                  AppFormField(
                    label: 'Password',
                    controller: passwordController,
                    obscure: passwordVisible,
                    keyboard: TextInputType.visiblePassword,
                    suffix: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight(context) * 0.03),
                  AppButton(
                    text: 'Login',
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await loginUser();
                          showSnackBar(context, 'Login successful');
                          Navigator.pushReplacementNamed(context, ChatScreen.id,arguments: emailController.text);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-credential') {
                            showSnackBar(
                                context, 'Wrong email or password.');
                          }
                        } catch (e) {
                          showSnackBar(context, 'There was an error');
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: screenHeight(context) * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth(context) * 0.033,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterScreen.id);
                        },
                        child: Text(
                          'Sign up now',
                          style: TextStyle(
                              color: Colors.blue[200],
                              fontSize: screenWidth(context) * 0.033,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }
}
