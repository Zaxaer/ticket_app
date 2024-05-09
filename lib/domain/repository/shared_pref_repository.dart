import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedDateBase {
  Future<T> get<T>(String key, T defaultValue);

  Future<void> set<T>(String key, T value);
}

class SharedPrefferences implements SharedDateBase {
  static final SharedPrefferences shared = SharedPrefferences._();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPrefferences._();

  @override
  Future set<T>(String key, T value) async {
    final SharedPreferences prefs = await _prefs;
    if (sameTypes<T, bool>()) {
      return prefs.setBool(key, value as bool);
    }

    if (sameTypes<T, int>()) {
      return prefs.setInt(key, value as int);
    }

    if (sameTypes<T, double>()) {
      return prefs.setDouble(key, value as double);
    }

    if (sameTypes<T, String>()) {
      return prefs.setString(key, value as String);
    }

    if (sameTypes<T, List<String>>()) {
      return prefs.setStringList(key, value as List<String>);
    }

    if (value is Enum) {
      return prefs.setInt(key, value.index);
    }

    throw Exception('Wrong type for saving to database');
  }

  @override
  Future<T> get<T>(String key, T defaultValue) async {
    final SharedPreferences prefs = await _prefs;
    Object? value;
    try {
      if (sameTypes<T, List<String>>()) {
        value = prefs.getStringList(key);
      } else {
        value = prefs.get(key);
      }

      // значения ещё нет в бд
      if (value == null) {
        return defaultValue;
      }

      return value as T;
    } catch (e) {
      return defaultValue;
    }
  }

  Future<void> remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(key);
  }

  bool sameTypes<S, V>() {
    void func<X extends S>() {}
    return func is void Function<X extends V>();
  }
}
