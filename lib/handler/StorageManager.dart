import 'package:shared_preferences/shared_preferences.dart';

const PREMIUM_KEY = 'premiumKey';

class StorageManager {

  late SharedPreferences prefs;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> getPremium() async {
    await initPrefs();
    bool isPremium = prefs.getBool(PREMIUM_KEY) ?? false;
    return isPremium;
  }

  void setPremium() async {
    await initPrefs();
    await prefs.setBool(PREMIUM_KEY, true);
  }
}
