import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/mealProvider.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  bool useWhiteForeground(Color backgroundColor, {double bias = 0.0}) {
    // Old:
    // return 1.05 / (color.computeLuminance() + 0.05) > 4.5;

    // New:
    int v = sqrt(pow(backgroundColor.red, 2) * 0.299 +
            pow(backgroundColor.green, 2) * 0.587 +
            pow(backgroundColor.blue, 2) * 0.114)
        .round();
    return v < 130 + bias ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscap =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var accentColor = Theme.of(context).accentColor;
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Hero(
                tag: mealId,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            if(isLandscap)Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Column(children: [
                buildSectionTitle(context, 'Ingredients'),
                buildContainer(
                  ListView.builder(
                    itemBuilder: (ctx, index) => Card(
                      color: accentColor,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Text(
                            selectedMeal.ingredients[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: useWhiteForeground(accentColor)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )),
                    ),
                    itemCount: selectedMeal.ingredients.length,
                  ),
                ),
              ],),
              Column(children: [
                buildSectionTitle(context, 'Steps'),
                buildContainer(
                  ListView.builder(
                    itemBuilder: (ctx, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${(index + 1)}'),
                          ),
                          title: Text(
                            selectedMeal.steps[index],
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        Divider()
                      ],
                    ),
                    itemCount: selectedMeal.steps.length,
                  ),
                ),
              ],),
            ],),

            if(!isLandscap)buildSectionTitle(context, 'Ingredients'),
            if(!isLandscap)buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: accentColor,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        selectedMeal.ingredients[index],
                        style: TextStyle(
                          fontSize: 15,
                          color: useWhiteForeground(accentColor)
                              ? Colors.white
                              : Colors.black,
                        ),
                      )),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            if(!isLandscap)buildSectionTitle(context, 'Steps'),
            if(!isLandscap)buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Divider()
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Provider.of<MealProvider>(context, listen: true)
                  .isMealFavorite(mealId)
              ? Icons.star
              : Icons.star_border,
        ),
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorite(mealId),
      ),
    );
  }
}
