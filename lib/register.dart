import 'package:flutter/material.dart';
import 'package:material_x/material_x.dart';
import 'package:youtubeclone/Models/colors.dart';
import 'package:youtubeclone/login.dart';
import 'authentication.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isloading = false;
  bool iserror = false;
  TextEditingController email_controller = TextEditingController();
  TextEditingController pass1_controller = TextEditingController();
  TextEditingController pass2_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tabBarColor,
      //appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/youtube_logo.png"),
                height: 200,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: email_controller,
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                controller: pass1_controller,
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                controller: pass2_controller,
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              MaterialXButton(
                child: "Sign Up".textMaterialColorWhite(),
                color: Colors.red,
                height: 50.0,
                width: MediaQuery.of(context).size.width * .75,
                onTap: () async {
                  if (email_controller.text.isNotEmpty &&
                      pass1_controller.text.isNotEmpty ==
                          pass2_controller.text.isNotEmpty) {
                    setState(() {
                      isloading = true;
                    });
                  }
                  dynamic res = await AuthServices(
                          email: email_controller.text,
                          pass: pass1_controller.text)
                      .registerWithEmailAndPassword();
                  if (res == null) {
                    setState(() {
                      iserror = true;
                      isloading = false;
                    });
                    print("cant register in");
                  } else {
                    Navigator.of(context).pushReplacementNamed(Login.routeName);
                    print("registered");
                    print(res);
                  }
                },
                elavation: 10,
                rounded: 5,
                spreadRadius: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              isloading
                  ? CircularProgressIndicator()
                  : iserror
                      ? Container(
                          child: Text(
                            "INVALID CREDENTIALS!\nTRY AGAIN",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              InkWell(
                child: Text(
                  "I already have an account",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
