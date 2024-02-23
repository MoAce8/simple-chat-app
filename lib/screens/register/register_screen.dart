// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/shared/constants.dart';
import 'package:chat_app/shared/validators.dart';
import 'package:chat_app/shared/widgets/app_button.dart';
import 'package:chat_app/shared/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static String id = 'Register Page';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                    'Sign up',
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
                    validator: (value) => emailValidator(value??''),
                  ),
                  SizedBox(height: screenHeight(context) * 0.02),
                  AppFormField(
                    label: 'Password',
                    controller: passwordController,
                    obscure: passwordVisible,
                    keyboard: TextInputType.visiblePassword,
                    validator: (value) => passwordValidator(value??''),
                    suffix: IconButton(
                      icon: Icon(
                        passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                    text: 'Sign up',
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await createNewUser();
                          showSnackBar(context, 'Account created successfully');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                                context, 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,
                                'The account already exists for that email.');
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
                        'Already have an account? ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth(context) * 0.033,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login now',
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


  Future<void> createNewUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
  }
}
