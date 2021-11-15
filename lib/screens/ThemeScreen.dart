import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_complete_guide/providers/ThemeProvider.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';

class ThemeScreen extends StatelessWidget {
  static const routeName = '/theme';

  final bool fromOnBoarding;

  const ThemeScreen({this.fromOnBoarding = false});

  Widget buildRadioListTile(
    ThemeMode themeMode,
    String txt,
    IconData icon,
    BuildContext ctx,
  ) {
    return RadioListTile(
      value: themeMode,
      secondary: Icon(
        icon,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        txt,
        style: Theme.of(ctx).textTheme.bodyText1,
      ),
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
      onChanged: (value) =>
          Provider.of<ThemeProvider>(ctx, listen: false).themeModeChane(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fromOnBoarding
          ? AppBar(
              backgroundColor: Theme.of(context).canvasColor,
              elevation: 0,
            )
          : AppBar(
              title: Text('Your Theme'),
            ),
      drawer: fromOnBoarding ? null : MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your themes selection.",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Choose your Theme Mode",
                    style: Theme.of(context).textTheme.headline6,
                  )),
              buildRadioListTile(
                  ThemeMode.system, "System efault Theme", null, context),
              buildRadioListTile(ThemeMode.light, "Light Theme",
                  Icons.wb_sunny_outlined, context),
              buildRadioListTile(ThemeMode.dark, "Dark Theme",
                  Icons.nights_stay_outlined, context),
              buildListTile(context, "primary"),
              buildListTile(context, "accent"),
            ],
          ))
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, String s) {
    var primaryColor = Provider.of<ThemeProvider>(context).primColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    return ListTile(
      title: Text(
        "choose your $s color",
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: s == "primary" ? primaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              elevation: 4,
              titlePadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: s == "primary"
                      ? Provider.of<ThemeProvider>(ctx, listen: true).primColor
                      : Provider.of<ThemeProvider>(ctx, listen: true)
                          .accentColor,
                  onColorChanged: (newColor) =>
                      Provider.of<ThemeProvider>(ctx, listen: false)
                          .onChange(newColor, s == "primary" ? 1 : 2),
                  colorPickerWidth: 300,
                  pickerAreaHeightPercent: 0.7,
                  displayThumbColor: true,
                  enableAlpha: false,
                  labelTypes: [],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
