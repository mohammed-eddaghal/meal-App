import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/mealProvider.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<MealProvider>(
      create: (context) => MealProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        primarySwatch: Colors.pink,
        //colorScheme.secondary:,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(31, 30, 30, 1.0),
        fontFamily: 'Raleway',
        buttonColor: Colors.white,
        //cardColor: Color.fromRGBO(20, 51, 51, 1.0),
        shadowColor: Colors.white60,
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color:Colors.white60,
              //Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Colors.white60,
            ),
            headline6: TextStyle(
              color: Colors.white60,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        //colorScheme.secondary:,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(231, 198, 198, 1.0),
        fontFamily: 'Raleway',
        buttonColor: Colors.black54,
        cardColor: Colors.white,
        //cardColor: Color.fromRGBO(20, 51, 51, 1.0),
        shadowColor: Colors.black45,
        textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText1: TextStyle(
              color:Colors.black,
              //Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Colors.black,
            ),
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if (settings.name == '/meal-detail') {
        //   return ...;
        // } else if (settings.name == '/something-else') {
        //   return ...;
        // }
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
