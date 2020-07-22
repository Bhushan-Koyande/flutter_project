import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signinflutter/views/login.dart';
import 'dart:async';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<bool> registerUser(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    "Sign",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                  child: Text(
                    "Up",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(140.0, 175.0, 0.0, 0.0),
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
                SizedBox(height: 20.0,),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'CONFIRM PASSWORD',
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
                  controller: confirmPasswordController,
                ),
                SizedBox(height: 40.0,),
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
                        final confirmPassword = confirmPasswordController.text.toString().trim();
                        if(password == confirmPassword){
                          bool result = await registerUser(email, password);
                          if(result == true){
                            Flushbar(
                              message:  "Registered successfully !",
                              duration:  Duration(seconds: 3),
                            )..show(context);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => LoginPage()
                            ));
                          }else{
                            Flushbar(
                              message:  "Registration failed !",
                              duration:  Duration(seconds: 3),
                            )..show(context);
                          }
                        }else{
                          Flushbar(
                            message:  "Passwords must match !",
                            duration:  Duration(seconds: 3),
                          )..show(context);
                        }
                      },
                      child: Center(
                        child: Text('SIGN UP',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
              ],
            ),
          ),
          SizedBox(height: 15.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Have an Account ?',style: GoogleFonts.montserrat(),),
              SizedBox(width: 5.0,),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          }
                      )
                  );
                },
                child: Text('Login',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),),
              )
            ],
          )
        ],
      ),
    );
  }
}
