import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/mealProvider.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';




  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;



  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters= Provider.of<MealProvider>(context, listen: false).filters;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  currentFilters['gluten'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['gluten'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  currentFilters['lactose'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['lactose'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  currentFilters['vegetarian'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['vegetarian'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals.',
                  currentFilters['vegan'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['vegan'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
