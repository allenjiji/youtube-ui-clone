import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtubeclone/register.dart';
import 'package:youtubeclone/video-page.dart';
import './main-page.dart';
import 'package:flutter/services.dart';

import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState(){
    autoLogIn();
    super.initState();
  }



   void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool userId = prefs.getBool('isloggedIn');

    if (userId != null) {
      setState(() {
        isLoggedIn = true;
      });
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    

    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      //home: Login(),
      routes: {
        '/': (context) =>isLoggedIn? MyHomePage() : Login(),
        Register.routeName: (context) => Register(),
        Login.routeName: (context) => Login(),
        MyHomePage.routeName: (context) => MyHomePage(),
        VideoPage.routeName: (context) => VideoPage(),
      },
    );
  }
}
