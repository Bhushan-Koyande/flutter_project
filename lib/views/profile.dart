import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {

  final FirebaseUser user;

  ProfilePage({this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final databaseReference = Firestore.instance;

  double _calories = 0.0;
  String _diet = 'None';
  bool _isNew = true;

  final List<DropdownMenuItem<String>> diets = [
    DropdownMenuItem(child: Text('None',style: GoogleFonts.montserrat(),),value: 'None',),
    DropdownMenuItem(child: Text('Gluten Free',style: GoogleFonts.montserrat(),),value: 'Gluten Free',),
    DropdownMenuItem(child: Text('Ketogenic',style: GoogleFonts.montserrat(),),value: 'Ketogenic',),
    DropdownMenuItem(child: Text('Vegetarian',style: GoogleFonts.montserrat(),),value: 'Vegetarian',),
    DropdownMenuItem(child: Text('Lacto-Vegetarian',style: GoogleFonts.montserrat(),),value: 'Lacto-Vegetarian',),
    DropdownMenuItem(child: Text('Ovo-Vegetarian',style: GoogleFonts.montserrat()),value: 'Ovo-Vegetarian',),
    DropdownMenuItem(child: Text('Vegan',style: GoogleFonts.montserrat()),value: 'Vegan',),
    DropdownMenuItem(child: Text('Pescetarian',style: GoogleFonts.montserrat()),value: 'Pescetarian',),
    DropdownMenuItem(child: Text('Paleo',style: GoogleFonts.montserrat()),value: 'Paleo',),
    DropdownMenuItem(child: Text('Primal',style: GoogleFonts.montserrat()),value: 'Primal',),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUserPresent();
  }

  // Verifying if user exists in database
  void isUserPresent() async {
    try{
      var doc = await databaseReference.collection("users").document(widget.user.email).get();
      setState(() {
        _isNew = ! doc.exists;
      });
    }catch (e){
      print(e);
    }
  }

  // Creating new document in database
  void addData() async {
    try{
      await databaseReference.collection("users").document(widget.user.email).setData({ "calorie" : _calories, "diet" : _diet });
    }catch(e){
      print(e);
    }
  }

  // Updating a document in database
  void updateData() async {
    try{
      await databaseReference.collection("users").document(widget.user.email).updateData({ "calorie" : _calories, "diet" : _diet });
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Your Account',style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w500)),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('          Your\nRequirements',style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 32.0,fontWeight: FontWeight.w600,color: Colors.black38)),),
            Slider(
                value: _calories,
                min: 0.0,
                max: 5000.0,
                divisions: 10,
                activeColor: Colors.green[400],
                inactiveColor: Colors.grey[600],
                label: 'calories : $_calories',
                onChanged: (newCalories){
                  setState(() {
                    _calories = newCalories;
                  });
                }
            ),
            DropdownButton<String>(
              items: diets,
              value: _diet,
              hint: Text('Pick a Diet',style: GoogleFonts.montserrat(),),
              onChanged: (newDiet){
                setState(() {
                  _diet = newDiet;
                });
              },
            ),
            ButtonTheme(
              minWidth: 100.0,
              height: 40.0,
              child: RaisedButton(
                child: Text('CONFIRM',style: GoogleFonts.montserrat(color: Colors.white),),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
                onPressed: (){
                  if(_isNew){
                    addData();
                  }else{
                    updateData();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
