import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signinflutter/models/favourite.dart';
import 'package:signinflutter/views/recipe.dart';

class FavoritePage extends StatefulWidget {

  final String val;

  FavoritePage({this.val});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  FavouriteService favouriteService;

  bool _flag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavourites();
  }

  void getFavourites() async {
    favouriteService = FavouriteService(username: widget.val);
    await favouriteService.fetchFavourites();

    if(favouriteService.favouritesList.length > 0){
      setState(() {
        _flag = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorites",style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w500)),),
        centerTitle: true,
      ),
      body: _flag ?
      Container(
        child: ListView(
          children: favouriteService.favouritesList.map(
                  (favorite) =>
                      Padding(
                        padding: EdgeInsets.fromLTRB(7.0, 7.0, 7.0, 0.0),
                        child: Card(
                          elevation: 4.0,
                          child: ListTile(
                            key: UniqueKey(),
                            title: Text(favorite.name,style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w500)),),
                            leading: Icon(Icons.fastfood),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  RecipePage(
                                    recipeName: favorite.name,
                                    id: favorite.id,
                                    recipeUrl: favorite.name,
                                  )
                              ));
                            },
                          ),
                        ),
                      )
          ).toList(),
        ),
      ):
      Container(
        child: Center(
          child: Text('You do not have any favourites',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black38,fontSize: 22.0)),),
        ),
      ),
    );
  }
}