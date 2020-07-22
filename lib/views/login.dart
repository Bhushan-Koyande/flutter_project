import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signinflutter/views/signup.dart';
import '../services/google_sign_in.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<FirebaseUser> loginUser(String email, String password) async{
    try{
      FirebaseAuth auth = FirebaseAuth.instance;
      AuthResult authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return firebaseUser;
    }catch(e){
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      "Hello",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                    child: Text(
                      "There",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(250.0, 175.0, 0.0, 0.0),
                    child: Text(
                      ".",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold,color: Colors.green),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0,left: 20.0,right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        )
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)
                      ),
                    ),
                    controller: emailController,
                  ),
                  SizedBox(height: 20.0,),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            )
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)
                        ),
                    ),
                    obscureText: true,
                    controller: passwordController,
                  ),
                  SizedBox(height: 60.0,),
                  Container(
                    height: 60.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(60.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: InkWell(
                        onTap: () async {
                          final email = emailController.text.toString().trim();
                          final password = passwordController.text.toString().trim();
                          FirebaseUser resultUser = await loginUser(email, password);
                          if(resultUser != null){
                            Flushbar(
                              message:  "Signed in successfully !",
                              duration:  Duration(seconds: 3),
                            )..show(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => HomePage()
                            ));
                          }else{
                            Flushbar(
                              message:  "Sign in failed !",
                              duration:  Duration(seconds: 3),
                            )..show(context);
                          }
                        },
                        child: Center(
                          child: Text('LOGIN',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0,),
                  _signInButton(),
                ],
              ),
            ),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('New here ?',style: GoogleFonts.montserrat(),),
                SizedBox(width: 5.0,),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SignupPage();
                        }
                      )
                    );
                  },
                  child: Text('Register',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.jpg"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 20,
                    
                    color: Colors.black,
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}