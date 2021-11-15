import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/category.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  List<String> prefsMealId = [];
  List<Category> availableCategories= DUMMY_CATEGORIES;

  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan'] && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac=[];
    availableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if(cat.id==catId && !ac.any((catMeal) => catMeal.id==catId))ac.add(cat);
        });
      });
    });
    availableCategories=ac;

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("gluten", filters['gluten']);
    prefs.setBool("lactose", filters['lactose']);
    prefs.setBool("vegan", filters['vegan']);
    prefs.setBool("vegetarian", filters['vegetarian']);
  }

  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool("gluten") ?? false;
    filters['lactose'] = prefs.getBool("lactose") ?? false;
    filters['vegan'] = prefs.getBool("vegan") ?? false;
    filters['vegetarian'] = prefs.getBool("vegetarian") ?? false;
    prefsMealId = prefs.getStringList("prefsMealId");
    for (var mealId in prefsMealId) {
      final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0)
      favoriteMeals.add(
        DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
      );
    }

    List<Meal> fm=[];
    favoriteMeals.forEach((favMeal) {
      availableMeals.forEach((avMeal) {
        if(favMeal.id==avMeal.id)fm.add(favMeal);
      });
    });
    favoriteMeals=fm;
    
    notifyListeners();
  }

  void toggleFavorite(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefsMealId = [];
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(
        DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
      );
      prefsMealId.add(mealId);
    }
    prefs.setStringList("prefsMealId", prefsMealId);
    notifyListeners();
  }


  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }
}
