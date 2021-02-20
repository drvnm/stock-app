import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static storeSymbol(String symbol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> preSymbols = prefs.getStringList('Watch');
    if (preSymbols == null) {
      prefs.setStringList("Watch", [symbol]);
    } else if (!preSymbols.contains(symbol)) {
      preSymbols.add(symbol);
      prefs.setStringList("Watch", preSymbols);
      print(preSymbols);
    } else{
      print("Already in shared prefs");
    }
  }

  static Future<List<String>> getSymbols(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(name);
  }
}
