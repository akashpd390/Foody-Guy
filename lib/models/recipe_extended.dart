


class RecipeExtended {
  int? id;
  String? title;
  String? image;
  int? servings;
  int? readyInMinutes;
  double? spoonacularScore;
  bool? vegetarian;
  List<String>? dishTypes;
  List<ExtendedIngredients>? extendedIngredients;
  String? instructions;

  RecipeExtended(
      {this.id,
      this.title,
      this.image,
      this.servings,
      this.readyInMinutes,
      this.spoonacularScore,
      this.vegetarian,
      this.dishTypes,
      this.extendedIngredients,
      this.instructions});

  RecipeExtended.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    servings = json['servings'];
    readyInMinutes = json['readyInMinutes'];
    spoonacularScore = json['spoonacularScore'];
    vegetarian = json['vegetarian'];
    dishTypes = json['dishTypes'].cast<String>();
    if (json['extendedIngredients'] != null) {
      extendedIngredients = <ExtendedIngredients>[];
      json['extendedIngredients'].forEach((v) {
        extendedIngredients!.add(ExtendedIngredients.fromJson(v));
      });
    }
    instructions = json['instructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['servings'] = this.servings;
    data['readyInMinutes'] = this.readyInMinutes;
    data['spoonacularScore'] = this.spoonacularScore;
    data['vegetarian'] = this.vegetarian;
    data['dishTypes'] = this.dishTypes;
    if (this.extendedIngredients != null) {
      data['extendedIngredients'] =
          this.extendedIngredients!.map((v) => v.toJson()).toList();
    }
    data["instructions"] = this.instructions;
    return data;
  }
}

class ExtendedIngredients {
  String? aisle;
  double? amount;
  String? consistency;
  int? id;
  String? image;
  Measures? measures;
  List<String>? meta;
  String? name;
  String? original;
  String? originalName;
  String? unit;

  ExtendedIngredients(
      {this.aisle,
      this.amount,
      this.consistency,
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
    consistency = json['consistency'];
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
    data['consistency'] = this.consistency;
    data['id'] = this.id;
    data['image'] = this.image;
    if (this.measures != null) {
      data['measures'] = this.measures!.toJson();
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
  Metric? metric;
  Metric? us;

  Measures({this.metric, this.us});

  Measures.fromJson(Map<String, dynamic> json) {
    metric =
        json['metric'] != null ? new Metric.fromJson(json['metric']) : null;
    us = json['us'] != null ? new Metric.fromJson(json['us']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metric != null) {
      data['metric'] = this.metric!.toJson();
    }
    if (this.us != null) {
      data['us'] = this.us!.toJson();
    }
    return data;
  }
}

class Metric {
  double? amount;
  String? unitLong;
  String? unitShort;

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