import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signinflutter/models/meal.dart';
import 'package:signinflutter/services/api.dart';
import 'package:signinflutter/views/info.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  Service service;
  List<Recipe> recipes = List();

  final searchController = TextEditingController();

  String searchedTerm;
  bool _flag = false;

  void searchRecipes() async {
    service = Service();
    searchedTerm = searchController.text.toString().trim();
    await service.getSearchedRecipes(searchedTerm);
    recipes = await service.getSearchedRecipesInfo();
    setState(() {
      _flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white)),
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Search Recipes',
            hintStyle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
          ),
          onEditingComplete: searchRecipes,
          controller: searchController,
        ),
      ),
      body: _flag != true ?
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search,size: 100.0,color: Colors.black38,),
            Text('Search for recipes',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black38,fontWeight: FontWeight.w500,fontSize: 25.0)),),
            Text('using Cuisines, Diets, etc',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black38,fontWeight: FontWeight.w500,fontSize: 25.0)),),
          ],
        ),
      ):
      Container(
        child: ListView(
          children: recipes.map((recipe) =>
              RecipeCard(
                name: recipe.title,
                imageUrl: recipe.image,
                sourceUrl: recipe.spoonacularSourceUrl,
                recipeId: recipe.id,
              )
          ).toList(),
        ),
      )
    );
  }
}
