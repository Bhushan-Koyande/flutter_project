import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signinflutter/views/home.dart';
import 'package:signinflutter/views/login.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) => {
      if(value == null){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => LoginPage()
        ))
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomePage()
        ))
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: FlutterLogo(
              size: 200.0,
            ),
          ),
          SizedBox(height: 20.0,),
          Center(
            child: Text("Flutter\nProject",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800]
                    )
                )
            ),
          )
        ],
      ),
    );
  }
}
