import 'package:flutter/material.dart';
import 'package:foody_guy/models/recipe.dart';
import 'package:foody_guy/provider/fav_recipe_provider.dart';
import 'package:provider/provider.dart';

class FavourteRecipePage extends StatelessWidget {
  const FavourteRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: SafeArea(
        child: Consumer<FavoriteRecipeProvider>(
          builder: (context, provider, _) {
            final favoriteRecipeIds = provider.favoriteRecipeIds;
            if (favoriteRecipeIds.isEmpty) {
              return const Center(child: Text('No favorite recipes yet'));
            }
            return ListView.builder(
              itemCount: favoriteRecipeIds.length,
              itemBuilder: (context, index) {
                final recipeId = favoriteRecipeIds[index];
                return FutureBuilder<Recipe>(
                  future: provider.fetchRecipeDetails(recipeId), // Fetch details here
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ListTile(title: Text('Loading...'));
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const ListTile(title: Text('Error loading recipe'));
                    }

                    final recipe = snapshot.data!;  // Recipe data fetched
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(recipe.image),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recipe.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.removeFavorite(recipe);  // Remove from favorites
                              },
                              child: const Icon(Icons.favorite, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
