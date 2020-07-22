import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signinflutter/views/recipe.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Recipe',style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.white)),),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 80.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Created with ",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black38,fontSize: 25.0),)),
                  Icon(Icons.favorite,color: Colors.green,),
                  Text(" by",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black38,fontSize: 25.0),))
                ],
              ),
              SizedBox(height: 40.0,),
              Text("BHUSHAN KOYANDE",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.w700,fontSize: 25.0),)),
              SizedBox(height: 40.0,),
              Text("Data from Spoonacular API",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black38,fontSize: 25.0),)),
              SizedBox(height: 40.0),
              ClipRRect(
                child: Image(
                  image: NetworkImage('https://spoonacular.com/application/frontend/images/food-api/image-classification/spoonacular-api.png'),
                ),
              ),
              SizedBox(height: 40.0),
              Text("CONTACT ME",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontSize: 25.0),)),
              SizedBox(height: 40.0),
              Text("bhushankoyande446@gmail.com",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500,fontSize: 17.0),)),
              SizedBox(height: 40.0),
              Text("github.com/Bhushan-Koyande",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500,fontSize: 17.0),)),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {

  final String imageUrl;
  final String sourceUrl;
  final int recipeId;
  final String name;

  RecipeCard({@required this.name, @required this.imageUrl, @required this.sourceUrl, @required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => RecipePage(recipeUrl: sourceUrl,id: recipeId,recipeName: name,)
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          elevation: 8.0,
          child: Container(
            height: 300.0,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            ),
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image(image: NetworkImage(imageUrl),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 300.0,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  height: 100.0,
                  width: 200.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  child: Text(name,style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.white)),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}