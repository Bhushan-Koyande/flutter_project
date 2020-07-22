import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signinflutter/models/favourite.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:slugify/slugify.dart';

class RecipePage extends StatefulWidget {

  final String recipeUrl;
  final int id;
  final String recipeName;

  RecipePage({@required this.recipeUrl,@required this.id,@required this.recipeName});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

  final _key = UniqueKey();
  final Completer<WebViewController> _completer = Completer<WebViewController>();

  String webUrl = 'https://spoonacular.com/';

  FavouriteService favouriteService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formatUrl();
  }

  void addToFavourites() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    favouriteService = FavouriteService(username: user.email);
    Favourite favourite = Favourite(id: widget.id,name: widget.recipeName,url:  webUrl);
    await favouriteService.addFavourites(favourite);
  }

  void formatUrl(){
    webUrl = webUrl + Slugify(widget.recipeName + ' ' + widget.id.toString());
    print(webUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeName,style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.favorite),
              onPressed: (){
                addToFavourites();
                Flushbar(
                  message:  "Added to favorites !",
                  duration:  Duration(seconds: 3),
                )..show(context);
              }
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: WebView(
          key: _key,
          initialUrl: webUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            _completer.complete(webViewController);
          },
        ),
      )
    );
  }
}
