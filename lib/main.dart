import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtubeclone/register.dart';
import 'package:youtubeclone/video-page.dart';
import './main-page.dart';
import 'package:flutter/services.dart';

import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        '/': (context) => Login(),
        Register.routeName: (context) => Register(),
        MyHomePage.routeName:(context)=>MyHomePage(),
        VideoPage.routeName:(context)=> VideoPage(),
      },
    );
  }
}
