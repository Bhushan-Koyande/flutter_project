class MealPlan {
  List<Meals> meals;
  Nutrients nutrients;

  MealPlan({this.meals, this.nutrients});

  MealPlan.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = new List<Meals>();
      json['meals'].forEach((v) {
        meals.add(new Meals.fromJson(v));
      });
    }
    nutrients = json['nutrients'] != null
        ? new Nutrients.fromJson(json['nutrients'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meals != null) {
      data['meals'] = this.meals.map((v) => v.toJson()).toList();
    }
    if (this.nutrients != null) {
      data['nutrients'] = this.nutrients.toJson();
    }
    return data;
  }
}

class Meals {
  int id;
  String title;
  String imageType;
  int readyInMinutes;
  int servings;
  String sourceUrl;

  Meals(
      {this.id,
        this.title,
        this.imageType,
        this.readyInMinutes,
        this.servings,
        this.sourceUrl});

  Meals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageType = json['imageType'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    sourceUrl = json['sourceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['imageType'] = this.imageType;
    data['readyInMinutes'] = this.readyInMinutes;
    data['servings'] = this.servings;
    data['sourceUrl'] = this.sourceUrl;
    return data;
  }
}

class Nutrients {
  double calories;
  double carbohydrates;
  double fat;
  double protein;

  Nutrients({this.calories, this.carbohydrates, this.fat, this.protein});

  Nutrients.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    carbohydrates = json['carbohydrates'];
    fat = json['fat'];
    protein = json['protein'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calories'] = this.calories;
    data['carbohydrates'] = this.carbohydrates;
    data['fat'] = this.fat;
    data['protein'] = this.protein;
    return data;
  }
}