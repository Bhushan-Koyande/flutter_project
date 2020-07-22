import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signinflutter/models/meal.dart';
import 'package:signinflutter/services/api.dart';
import 'package:signinflutter/views/fav.dart';
import 'package:signinflutter/views/info.dart';
import 'package:signinflutter/views/profile.dart';
import 'package:signinflutter/views/search.dart';
import 'login.dart';
import '../services/google_sign_in.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseUser appUser;
  final databaseReference = Firestore.instance;

  String name;
  String email;
  String imageURL;
  int _calorie = 3000;
  String _diet = 'Vegetarian';

  String calCount = 'N/A';
  String carbCount = 'N/A';
  String fatCount = 'N/A';
  String proteinCount = 'N/A';

  Service service;
  List <Recipe> recipes = List();

  @override
  void initState() {

    super.initState();
    name = 'username';
    email = 'e-mail';
    imageURL = 'https://thumbs.dreamstime.com/z/purple-user-icon-circle-thin-line-shadow-solid-gradient-138416179.jpg';
    getUserInfo();
    getMealData();
  }

  void getMealData() async {
    service = Service();
    await service.generateMealPlan(_diet, _calorie);
    recipes = await service.getRecipes();
    calCount = service.mealPlan.nutrients.calories.toString();
    carbCount = service.mealPlan.nutrients.carbohydrates.toString();
    fatCount = service.mealPlan.nutrients.fat.toString();
    proteinCount = service.mealPlan.nutrients.protein.toString();
    setState(() { });
  }

  void getUserInfo() async {
    appUser = await FirebaseAuth.instance.currentUser();
    if (appUser.displayName != null) {
      name = appUser.displayName;
    } else {
      name = 'username';
    }
    if (appUser.email != null) {
      email = appUser.email;
    } else {
      email = 'e-mail';
    }
    if (appUser.photoUrl != null) {
      imageURL = appUser.photoUrl;
    } else {
      imageURL = 'https://thumbs.dreamstime.com/z/purple-user-icon-circle-thin-line-shadow-solid-gradient-138416179.jpg';
    }
    try{
      var response = await databaseReference.collection("users").document(email).get();
      _calorie = response['calorie'].toInt();
      _diet = response['diet'];
    }catch (e){
      print(e);
    }
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Meal Plan',style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w500)),),
        centerTitle: true,
      ),
      drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  accountName: Text(name,style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600)),),
                  accountEmail: Text(email,style: GoogleFonts.montserrat(),),
                  currentAccountPicture: CircleAvatar(
                    radius: 28.0,
                    backgroundImage: NetworkImage(imageURL),
                    backgroundColor: Colors.transparent,
                  ),
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile',style: GoogleFonts.montserrat(),),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfilePage(user: appUser,))
                  );
                },
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Favourites',style: GoogleFonts.montserrat(),),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FavoritePage(val: email,))
                  );
                },
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About',style: GoogleFonts.montserrat(),),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage()));
                },
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Sign Out',style: GoogleFonts.montserrat(),),
                ),
                onTap: (){
                  signOutGoogle();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => LoginPage()
                  ));
                },
              ),
            ],
          ),
        ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 8.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 10,
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Center(child: Text('Nutrients',style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.bold)),),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Calories',style: GoogleFonts.montserrat(),),
                                  Text(calCount,style: GoogleFonts.montserrat(),)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Carbs',style: GoogleFonts.montserrat(),),
                                  Text(carbCount,style: GoogleFonts.montserrat(),)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Fats',style: GoogleFonts.montserrat(),),
                                  Text(fatCount,style: GoogleFonts.montserrat(),)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Proteins',style: GoogleFonts.montserrat(),),
                                  Text(proteinCount,style: GoogleFonts.montserrat(),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: recipes.map((recipe) => RecipeCard(
                          name: recipe.title,
                          recipeId: recipe.id,
                          imageUrl: recipe.image,
                          sourceUrl: recipe.spoonacularSourceUrl
                      )).toList(),
                    ),
                  ],
                ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => SearchPage()
            ));
          },
          child: Icon(Icons.search),
      ),
    );
  }
}