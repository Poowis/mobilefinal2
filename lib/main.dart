import 'package:flutter/material.dart';
import 'package:mobilefinal2/ui/home.dart';
import 'package:mobilefinal2/ui/login.dart';
import 'package:mobilefinal2/ui/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobilefinal2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff111111)
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        // '/profile': (context) => ProfileScreen(),
        // '/friend': (context) => FriendScreen(),
        // '/friendInfo': (context) => FriendInfoScreen(),
      },
    );
  }
}