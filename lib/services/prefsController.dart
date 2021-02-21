import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefs {

  static storeSymbol(String symbol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> preSymbols = prefs.getStringList('Watch');
    if (preSymbols == null) {
      prefs.setStringList("Watch", [symbol.toLowerCase()]);
    } else if (!preSymbols.contains(symbol)) {
      preSymbols.add(symbol.toLowerCase());
      prefs.setStringList("Watch", preSymbols);
      print(preSymbols);
    } else{
      print("Already in shared prefs");
    }
  }
  static deleteWatch(String symbol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> preSymbols = prefs.getStringList('Watch');
    print(preSymbols);
    preSymbols.remove(symbol); 
    print(preSymbols);
    prefs.setStringList("Watch", preSymbols);
    
  }

  static Future<List<String>> getSymbols(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(name);
  }

  static Future<bool> getWatches(String symbol) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var watchList = prefs.getStringList('Watch');
     if(watchList == null){
       return false;
     }
     return watchList.contains(symbol);
  }

  static deletePref(String symbol) async {

  }
}
