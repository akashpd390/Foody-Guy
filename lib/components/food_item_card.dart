import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:foody_guy/models/recipe.dart';
import 'package:foody_guy/pages/recipe_details_page.dart';
import 'package:foody_guy/provider/fav_recipe_provider.dart';
import 'package:provider/provider.dart';

class FoodItemsDisplay extends StatelessWidget {
  final Recipe recipe;

  const FoodItemsDisplay({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailsPage(recipe: recipe,)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        width: 230,
        child: Stack(
          children: [
            Column(
              children: [
                Hero(
                  tag: recipe.image,
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(recipe.image),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  recipe.title.padRight(30),
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: InkWell(
                  onTap: () {
                    if (context.read<FavoriteRecipeProvider>().isFavorite(recipe)) {
                      context.read<FavoriteRecipeProvider>().removeFavorite(recipe);
                    } else {
                      context.read<FavoriteRecipeProvider>().addFavorite(recipe);
                    }
                  },
                  child: Icon(
                    Icons.favorite,
                    color: context.read<FavoriteRecipeProvider>().isFavorite(recipe) ? Colors.red : Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
