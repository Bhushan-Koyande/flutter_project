class Recipe {
  int id;
  String title;
  String image;
  String imageType;
  int servings;
  int readyInMinutes;
  String license;
  String sourceName;
  String sourceUrl;
  String spoonacularSourceUrl;
  String summary;

  Recipe(
      {this.id,
        this.title,
        this.image,
        this.imageType,
        this.servings,
        this.readyInMinutes,
        this.license,
        this.sourceName,
        this.sourceUrl,
        this.spoonacularSourceUrl,
        this.summary,});

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    imageType = json['imageType'];
    servings = json['servings'];
    readyInMinutes = json['readyInMinutes'];
    license = json['license'];
    sourceName = json['sourceName'];
    sourceUrl = json['sourceUrl'];
    spoonacularSourceUrl = json['spoonacularSourceUrl'];

    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['imageType'] = this.imageType;
    data['servings'] = this.servings;
    data['readyInMinutes'] = this.readyInMinutes;
    data['license'] = this.license;
    data['sourceName'] = this.sourceName;
    data['sourceUrl'] = this.sourceUrl;
    data['spoonacularSourceUrl'] = this.spoonacularSourceUrl;
    return data;
    }

}

class ExtendedIngredients {
  String aisle;
  double amount;
  String consitency;
  int id;
  String image;
  Measures measures;
  List<String> meta;
  String name;
  String original;
  String originalName;
  String unit;

  ExtendedIngredients(
      {this.aisle,
        this.amount,
        this.consitency,
        this.id,
        this.image,
        this.measures,
        this.meta,
        this.name,
        this.original,
        this.originalName,
        this.unit});

  ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    aisle = json['aisle'];
    amount = json['amount'];
    consitency = json['consitency'];
    id = json['id'];
    image = json['image'];
    measures = json['measures'] != null
        ? new Measures.fromJson(json['measures'])
        : null;
    meta = json['meta'].cast<String>();
    name = json['name'];
    original = json['original'];
    originalName = json['originalName'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aisle'] = this.aisle;
    data['amount'] = this.amount;
    data['consitency'] = this.consitency;
    data['id'] = this.id;
    data['image'] = this.image;
    if (this.measures != null) {
      data['measures'] = this.measures.toJson();
    }
    data['meta'] = this.meta;
    data['name'] = this.name;
    data['original'] = this.original;
    data['originalName'] = this.originalName;
    data['unit'] = this.unit;
    return data;
  }
}

class Measures {
  Metric metric;
  Metric us;

  Measures({this.metric, this.us});

  Measures.fromJson(Map<String, dynamic> json) {
    metric =
    json['metric'] != null ? new Metric.fromJson(json['metric']) : null;
    us = json['us'] != null ? new Metric.fromJson(json['us']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metric != null) {
      data['metric'] = this.metric.toJson();
    }
    if (this.us != null) {
      data['us'] = this.us.toJson();
    }
    return data;
  }
}

class Metric {
  double amount;
  String unitLong;
  String unitShort;

  Metric({this.amount, this.unitLong, this.unitShort});

  Metric.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    unitLong = json['unitLong'];
    unitShort = json['unitShort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['unitLong'] = this.unitLong;
    data['unitShort'] = this.unitShort;
    return data;
  }
}


class ProductMatches {
  int id;
  String title;
  String description;
  String price;
  String imageUrl;
  double averageRating;
  int ratingCount;
  double score;
  String link;

  ProductMatches(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.imageUrl,
        this.averageRating,
        this.ratingCount,
        this.score,
        this.link});

  ProductMatches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    averageRating = json['averageRating'];
    ratingCount = json['ratingCount'];
    score = json['score'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    data['averageRating'] = this.averageRating;
    data['ratingCount'] = this.ratingCount;
    data['score'] = this.score;
    data['link'] = this.link;
    return data;
  }
}

class RecipeItem {
  int offset;
  int number;
  List<Results> results;
  int totalResults;

  RecipeItem({this.offset, this.number, this.results, this.totalResults});

  RecipeItem.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    number = json['number'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['number'] = this.number;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['totalResults'] = this.totalResults;
    return data;
  }
}

class Results {
  int id;
  String image;
  int readyInMinutes;
  int servings;
  String title;

  Results(
      {this.id,
        this.image,
        this.readyInMinutes,
        this.servings,
        this.title});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['readyInMinutes'] = this.readyInMinutes;
    data['servings'] = this.servings;
    data['title'] = this.title;
    return data;
  }
}