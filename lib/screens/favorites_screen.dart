import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/mealProvider.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool isLandscap =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw= MediaQuery.of(context).size.width;
    //var lan= MediaQuery.of(context).size.height;

    final List<Meal> favoriteMeals= Provider.of<MealProvider>(context).favoriteMeals;
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw<=400?400:500,
          childAspectRatio: isLandscap? dw/(dw*0.71):dw/(dw*0.715),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
