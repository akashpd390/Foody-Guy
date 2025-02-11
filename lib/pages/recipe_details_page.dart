import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foody_guy/components/icon_button.dart';
import 'package:foody_guy/models/recipe.dart';
import 'package:foody_guy/models/recipe_extended.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailsPage extends StatefulWidget {
  Recipe recipe;

  RecipeDetailsPage({super.key, required this.recipe});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  late RecipeExtended _recipeExtended;
  bool isLoading = true;

  @override
  void initState() {
    

    super.initState();
    getExtendedRecipe();
  }

  void getExtendedRecipe() async {
    _recipeExtended = await fetchExtendedRecipeDetails(widget.recipe.id);
  }

  Future<RecipeExtended> fetchExtendedRecipeDetails(int id) async {
    String? apiUrl = dotenv.env["API_URL"];
    String? apiKey = dotenv.env["API_KEY"];
    final url = "$apiUrl/$id/information?apiKey=$apiKey";
    // print(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        isLoading = false;
      });
      return RecipeExtended.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to load recipe details");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.recipe.image,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.recipe.image),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 10,
                    right: 10,
                    child: Row(
                      children: [
                        MyIconButton(
                            iconData: Icons.arrow_back,
                            callback: () {
                              Navigator.pop(context);
                            }),
                        const Spacer(),
                        MyIconButton(
                            iconData: Icons.notifications, callback: () {})
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: MediaQuery.of(context).size.width,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: 40,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.title,
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.dinner_dining,
                                    size: 24,
                                    color: Colors.grey,
                                  ),
                                  const Text(
                                    " . ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    " ${_recipeExtended.servings}",
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  _recipeExtended.vegetarian!
                                      ? Text(
                                          "Vegetarian",
                                          style: TextStyle(
                                              color: Colors.green.shade600,
                                              fontSize: 20),
                                        )
                                      : Text(
                                          "Non - Vegetarian",
                                          style: TextStyle(
                                              color: Colors.red.shade600,
                                              fontSize: 20),
                                        ),
                                  const Text(
                                    " . ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.grey),
                                  ),
                                  const Icon(
                                    Icons.timer,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${_recipeExtended.readyInMinutes!} min",
                                    style: const TextStyle(),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_border_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "Score : ${_recipeExtended.spoonacularScore!.toInt()}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Align(
                                alignment: Alignment
                                    .centerLeft, // Ensures the text is aligned to the left
                                child: Text(
                                  "Instructions",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "${_recipeExtended.instructions}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700),
                              ),

                              // Ingredients Section
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Ingredients",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _recipeExtended
                                        .extendedIngredients?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  final ingredient = _recipeExtended
                                      .extendedIngredients![index];
                                  final amount = ingredient.amount ?? 0.0;
                                  final unit = ingredient.unit ?? '';
                                  final name = ingredient.name ?? '';

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "$amount $unit $name",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade700),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _launchURL,
          child: const Icon(Icons.youtube_searched_for),
        ),
      ),
    );
  }

  void _launchURL() async {
  try {
    // Fetch the base URL from the environment variable
    String? baseUrl =  dotenv.env["YT_URL"];
    // String baseUrl = "https://www.youtube.com/results?search_query=";
    // print(baseUrl);
    
    // Ensure the base URL is not null
    if (baseUrl != null && baseUrl.isNotEmpty) {
      String url = "$baseUrl${_recipeExtended.title}";  // Concatenate the recipe title to the URL
      
      // Check if the URL can be launched
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));  // Launch the URL
      } else {
        throw 'Could not launch $url';  // Handle invalid URL error
      }
    } else {
      throw 'Base URL is missing or invalid';
    }
  } catch (e) {
    // Catch any errors and display them in the console for debugging
    // print("Error launching URL: $e");
  }
}

}
