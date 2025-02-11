import 'package:flutter/material.dart';
import 'package:foody_guy/components/banner.dart';
import 'package:foody_guy/components/food_item_card.dart';
import 'package:foody_guy/components/icon_button.dart';
// import 'package:foody_guy/pages/veiw_all_page.dart';
// import 'package:foody_guy/pages/favourite_recipe_page.dart';
import 'package:foody_guy/provider/fav_recipe_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _on_category = "All";  // Initialize the selected category

  final List<String> _categorize = [
    "All", "Main Course", "Salad", "Breakfast", "Snack", "Drink"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 230, 230),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header(),
                    searcch_button(),
                    const MyBanner(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Categories",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    foodTags(context),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quick & Easy",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => VeiwAllPage()));
   
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    _buildRecipeList(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView foodTags(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          _categorize.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _on_category = _categorize[index];  // Update the selected category
              });
              context.read<FavoriteRecipeProvider>().getAllRecipes(_on_category); // Fetch recipes on category change
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: _categorize[index] == _on_category ? Colors.blue : Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.only(right: 20),
              child: Text(
                _categorize[index],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: _categorize[index] == _on_category ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeList(BuildContext context) {
    return Consumer<FavoriteRecipeProvider>(
      builder: (context, provider, _) {
        final recipes = provider.recipes; // Access recipes from the provider
        return Padding(
          padding: const EdgeInsets.only(top: 5, left: 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: recipes.map((recipe) => FoodItemsDisplay(recipe: recipe)).toList(),
            ),
          ),
        );
      },
    );
  }

  Padding searcch_button() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(Icons.search_outlined, size: 35),
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: "Search any recipes",
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Row header() {
    return Row(
      children: [
        const Text(
          "What are you \ncooking today",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1),
        ),
        const Spacer(),
        MyIconButton(iconData: Icons.notifications_outlined, callback: () {}),
      ],
    );
  }
}

