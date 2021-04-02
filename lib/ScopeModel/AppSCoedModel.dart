import 'dart:ui';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppModel extends Model {
  Locale _appLocale = Locale('ar');
  Locale get appLocal => _appLocale;
  SharedPreferences sharedPreferences;

  void changeDirectionToArabic() async{
     _appLocale = Locale("ar");
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('lang', 'ar');
    notifyListeners();
  }
  void changeDirectionToEn() async{
     _appLocale = Locale("en");
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('lang', 'en');
    notifyListeners();
  }
}