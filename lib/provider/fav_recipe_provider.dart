import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:foody_guy/models/recipe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class FavoriteRecipeProvider with ChangeNotifier {
  
  // late String category = "All";
  late Box _box;
  List<int> _favoriteRecipeIds = [];
  List<Recipe> _recipes = [];

  // void setCategory(String category) {
  //   category = category;
  //   getAllRecipes(category); // Fetch recipes for the selected category
  //   notifyListeners();
  // }

  FavoriteRecipeProvider() {
    _init();
  }

 Future<void> _init() async {
  _box = await Hive.openBox("my_box");

  // Safely cast the value to List<int>
  getAllRecipes("All");
  _favoriteRecipeIds = List<int>.from(_box.get("favourites", defaultValue: []));
  notifyListeners();
}

  List<int> get favoriteRecipeIds => _favoriteRecipeIds;

  List<Recipe> get recipes => _recipes;

  bool isFavorite(Recipe recipe) {
    return _favoriteRecipeIds.contains(recipe.id);
  }

  Future<void> addFavorite(Recipe recipe) async {
    _favoriteRecipeIds.add(recipe.id);
    await _box.put("favourites", _favoriteRecipeIds);
    notifyListeners();
  }

  Future<void> removeFavorite(Recipe recipe) async {
    _favoriteRecipeIds.remove(recipe.id);
    await _box.put("favourites", _favoriteRecipeIds);
    notifyListeners();
  }

  Future<void> getAllRecipes(String category) async {

    // setCategory(category);

    String? apiUrl = dotenv.env["API_URL"];
    String? apiKey = dotenv.env["API_KEY"];
    String url;

    if (apiUrl == null || apiKey == null) return;

    if (category == "All") {
      url = "$apiUrl/complexSearch?number=10&apiKey=$apiKey&cuisine=Indian";
    } else {
      url = "$apiUrl/complexSearch?type=$category&apiKey=$apiKey&number=10&cuisine=Indian";
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final result = jsonResponse["results"] as List;
        _recipes = result.map((e) => Recipe.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      // print("Error: $e");
    }
  }

  Future<Recipe> fetchRecipeDetails(int id) async {
    String? apiUrl = dotenv.env["API_URL"];
    String? apiKey = dotenv.env["API_KEY"];
    final url = "$apiUrl/$id/information?apiKey=$apiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Recipe.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to load recipe details");
    }
  }
  
}
