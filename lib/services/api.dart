import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:signinflutter/models/mealplan.dart';
import 'package:signinflutter/models/meal.dart';

class Service{

  final String apiKey = '21d9d8424b744793bbab60410bb079e8';
  String initialURL = 'https://api.spoonacular.com/mealplanner/generate';
  String searchURL = 'https://api.spoonacular.com/recipes/search';

  MealPlan mealPlan;
  RecipeItem recipeItem;

  //    Generate meal plan function
  Future<void> generateMealPlan(String diet, int targetCalories) async {
    var response = await http.get(initialURL+'?apiKey=$apiKey&timeFrame=day&targetCalories=$targetCalories&diet=$diet');
    var decodedMealPlan = jsonDecode(response.body);
    mealPlan = MealPlan.fromJson(decodedMealPlan);
  }

  //    Get recipes in meal plan function
  Future<List<Recipe>> getRecipes() async {
    List<Meals> mealsList = mealPlan.meals;

    return Future.wait<Recipe>(mealsList.map((meal) =>
        http
            .get('https://api.spoonacular.com/recipes/'+meal.id.toString()+'/information?apiKey=$apiKey&includeNutrition=false')
            .then((response)
        {
          var decodedRecipe = jsonDecode(response.body);
          Recipe recipe = Recipe.fromJson(decodedRecipe);
          return recipe;
        })
    ));
  }

  //    Get searched results function
  Future<void> getSearchedRecipes(String queryString) async {
    var response = await http.get(searchURL+'?apiKey=$apiKey&query=$queryString');
    var decodedRecipeList = jsonDecode(response.body);
    recipeItem = RecipeItem.fromJson(decodedRecipeList);
  }

  //    Get searched recipes function
  Future<List<Recipe>> getSearchedRecipesInfo() async {
    List<Results> recipeList = recipeItem.results;

    return Future.wait<Recipe>(recipeList.map((meal) =>
        http
            .get('https://api.spoonacular.com/recipes/'+meal.id.toString()+'/information?apiKey=$apiKey&includeNutrition=false')
            .then((response)
        {
          var decodedRecipe = jsonDecode(response.body);
          Recipe recipe = Recipe.fromJson(decodedRecipe);
          return recipe;
        })
    ));
  }

}