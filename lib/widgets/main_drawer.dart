import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/ThemeProvider.dart';
import 'package:flutter_complete_guide/providers/language_provider.dart';
import 'package:flutter_complete_guide/screens/ThemeScreen.dart';
import 'package:provider/provider.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler,
      BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme
            .of(ctx)
            .buttonColor,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: lan.isEn ? Alignment.centerLeft :
              Alignment.centerRight,
              color: Theme
                  .of(context)
                  .accentColor,
              child: Text(
                lan.getTexts("drawer_name"),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Theme
                        .of(context)
                        .primaryColor),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile('Meals', Icons.restaurant, () {
              Navigator.of(context).pushReplacementNamed('/');
            }, context),
            buildListTile('Filters', Icons.settings, () {
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            }, context),
            buildListTile('Themes', Icons.color_lens, () {
              Navigator.of(context).pushReplacementNamed(ThemeScreen.routeName);
            }, context),
            Divider(
              height: 10,
              color: Colors.black54,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 20, right: 22),
              child: Text(
                lan.getTexts('drawer_switch_title'),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: (lan.isEn ? 0 : 20),
                left: (lan.isEn ? 20 : 0),
              ),
              child: Row(children: [
                Text(lan.getTexts('drawer_switch_item2'),
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,),
                Switch(value: lan.isEn, onChanged: (value) {
                  Provider.of<LanguageProvider>(context, listen: false).changeLan(
                      value);
                  //Navigator.of(context).pop();
                },
                  /*inactiveTrackColor: Provider
                      .of<ThemeProvider>(context)
                      .tm==,*/),
                Text(lan.getTexts('drawer_switch_item1'),
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,),

              ],),
            ),
            Divider(
              height: 10,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
