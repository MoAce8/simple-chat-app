import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:chat_app/screens/login/login_screen.dart';
import 'package:chat_app/screens/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat app',
      routes: {
        LoginScreen.id:(context)=>const LoginScreen(),
        RegisterScreen.id:(context)=>const RegisterScreen(),
        ChatScreen.id:(context) =>  ChatScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const LoginScreen(),
    );
  }
}
