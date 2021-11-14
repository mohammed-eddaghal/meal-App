import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  MaterialColor primColor= Colors.pink;
  MaterialColor accentColor= Colors.amber;
  ThemeMode tm=ThemeMode.system;
  String themeString ="s";

  themeModeChane(value) async {
    tm=value;
    _getThemeText(tm);
    notifyListeners();
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("themeString", themeString);
  }

  getThemeMode() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    themeString=prefs.getString("themeString")??"s";

    if(themeString=="s") tm=ThemeMode.system;
    else if(themeString=="l") tm=ThemeMode.light;
    else if(themeString=="d") tm=ThemeMode.dark;

    notifyListeners();
  }

  _getThemeText(ThemeMode tm){
    if(tm==ThemeMode.dark) themeString="d";
    else if(tm ==ThemeMode.light) themeString="l";
    else themeString="s";
  }

  onChange(newColor, int i) async{
    i==11? primColor=_setMaterialColor(newColor.value):
        accentColor=_setMaterialColor(newColor.value);
    notifyListeners();

    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt("primColor", primColor.value);
    prefs.setInt("accColor", accentColor.value);
  }

  getThemeColor()async{
    print("${primColor.hashCode} , ${primColor.value} , 0xFFE91E63\n");
    print("${accentColor.hashCode} , ${accentColor.value} , 0xFFFFC107\n");
    SharedPreferences prefs=await SharedPreferences.getInstance();
    //prefs.clear();
    print(prefs.getInt("primColor"));
    print(Colors.pink.value);
    print("//");
    print(prefs.getInt("accColor"));
    print(Colors.amber.value);
    print("//");
    //primaryColor=_setMaterialColor(prefs.getInt("primColor")?? Colors.pink.value);//Colors.pink 0xFFE91E63
    accentColor=_setMaterialColor(prefs.getInt("accColor")?? Colors.amber.value);

    notifyListeners();
  }

  MaterialColor _setMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        500: Color(colorVal),
      },
    );
  }

}

