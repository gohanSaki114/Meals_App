import 'package:flutter/material.dart';

import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/providers/favourites_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _tabScreenState();
}

class _tabScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favouriteMeal = [];

  // void _toggleMealFavouriteStatus(Meal meal) {
  //   final isExisting = _favouriteMeal.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favouriteMeal.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no  longer favorite');
  //   } else {
  //     setState(() {
  //       _favouriteMeal.add(meal);
  //     });
  //     _showInfoMessage('Meal is added to favorite');
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => FiltersScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen();
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final _favouriteMeal = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(meals: _favouriteMeal);
      activePageTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites')
        ],
      ),
    );
  }
}
