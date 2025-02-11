import 'package:flutter/material.dart';
import 'package:foody_guy/pages/favourite_recipe_page.dart';
import 'package:foody_guy/pages/home_page.dart';

class MainBottomBar extends StatefulWidget{
  const MainBottomBar({super.key});

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {

  int _index =0;
  late List<Widget> pages;

  @override
  void initState() {
    pages = [
      const HomePage(),
      const FavourteRecipePage(),
      _navbarPage(Icons.calendar_month_rounded),
      _navbarPage(Icons.settings_rounded)
      ]
      ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value){
          setState(() {
          _index = value;
            
          });
          },
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 28,
        selectedItemColor: Colors.blue,
        unselectedItemColor:Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        items:   [
          BottomNavigationBarItem(
            icon: _index == 0 ? const Icon(Icons.home) : const Icon(Icons.home_outlined),
            label: "Home"
            ),
          BottomNavigationBarItem(
            icon: _index == 1 ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
            label: "Favorites",
            ),
          BottomNavigationBarItem(
            icon: _index == 2 ? const Icon(Icons.calendar_month) : const Icon(Icons.calendar_month_outlined),
            label: "Meal Plan",
            ),
          BottomNavigationBarItem(
            icon:_index == 3 ? const Icon(Icons.settings) : const Icon(Icons.settings_outlined),
            label: "Settings",
            )
            ],
      ),
      body: pages[_index],
    );
  }

  _navbarPage(iconName){
    return Center(
      child: Icon(iconName, size: 100,)
    );
  }
}