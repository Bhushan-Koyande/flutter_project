import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Favourite{

  final int id;
  final String name;
  final String url;

  Favourite({this.id, this.name, this.url});

  Map<String, String> toMap() {
    return {
      'favouriteName': name,
      'favouriteId': id.toString(),
      'favouriteUrl': url
    };
  }

  Favourite.fromMap(Map<dynamic, dynamic> map):id = int.parse(map['favouriteId']), name = map['favouriteName'], url = map['favouriteUrl'];

}

class FavouriteService{

  final databaseReference = Firestore.instance;

  List<Favourite> favouritesList = List();
  final String username;

  FavouriteService({this.username});

  Future<void> fetchFavourites() async {
    try{
      var response = await databaseReference.collection("users").document(username).get();
      if(response.data.containsKey("favourites")){
         favouritesList = response["favourites"].map<Favourite>((fav) {
          return Favourite.fromMap(fav);
        }).toList();
      }
    }catch (e){
      print(e);
    }
  }

  Future<void> addFavourites(Favourite favourite) async {
    favouritesList.add(favourite);
    List<Map> data = convertCustomStepsToMap(fav: favouritesList);
    try{
      await databaseReference.collection("users").document(username).updateData({ "favourites" : FieldValue.arrayUnion(data) });
    }catch (e){
      print(e);
    }
  }

  List<Map> convertCustomStepsToMap({List<Favourite> fav}) {
    List<Map> steps = [];
    fav.forEach((Favourite f) {
      Map step = f.toMap();
      steps.add(step);
    });
    return steps;
  }

}