import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesServices {

static final Future<SharedPreferences> _preferences =  SharedPreferences.getInstance();

 static setStringLocalStorage(String dados, String chave) async{
 SharedPreferences preferences = await _preferences;
 preferences.setString(chave, dados);
 return preferences.getString(chave);
 }

static Future<String?> getStringlocalStorage(String chave) async {
  SharedPreferences preferences = await _preferences;
  return preferences.getString(chave);
 }
}
