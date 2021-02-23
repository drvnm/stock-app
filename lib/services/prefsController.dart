import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefs {

  static storeSymbol(String symbol, String table) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> preSymbols = prefs.getStringList(table);
    if (preSymbols == null) {
      prefs.setStringList(table, [symbol.toLowerCase()]);
    } else if (!preSymbols.contains(symbol)) {
      preSymbols.add(symbol.toLowerCase());
      prefs.setStringList(table, preSymbols);
      print(preSymbols);
    } else{
      print("Already in shared prefs");
    }
  }
  static deleteWatch(String symbol, String table) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> preSymbols = prefs.getStringList(table);
    print(preSymbols);
    preSymbols.remove(symbol); 
    print(preSymbols);
    prefs.setStringList(table, preSymbols);
    
  }

  static Future<List<String>> getSymbols(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(name);
  }

  static Future<bool> getWatches(String symbol, String table) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var watchList = prefs.getStringList(table);
     if(watchList == null){
       return false;
     }
     return watchList.contains(symbol);
  }

  static Future<List<String>> getValues(String table) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var watchList = prefs.getStringList(table);
     if(watchList == null){
       return [];
     }
     return watchList;
  }

  static deletePref(String symbol) async {

  }

  static deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
    print("Data cleared"); 
  }
}
