import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesService {
  static const String _lastPageKey = 'last_page_index';
  static const String _showIndexOnStartupKey = 'show_index_on_startup';
  static const String _fontSizeKey = 'font_size';
  static const String _backgroundColorKey = 'background_color';
  static const String _textColorKey = 'text_color';
  
  static SharedPreferences? _prefs;
  
  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print('Warning: Failed to initialize SharedPreferences: $e');
      _prefs = null;
    }
  }
  
  static Future<SharedPreferences?> get _preferences async {
    if (_prefs == null) {
      try {
        _prefs = await SharedPreferences.getInstance();
      } catch (e) {
        print('Warning: Failed to get SharedPreferences instance: $e');
        return null;
      }
    }
    return _prefs;
  }
  
  
  static Future<void> saveLastPageIndex(int pageIndex) async {
    try {
      final prefs = await _preferences;
      if (prefs != null) {
        await prefs.setInt(_lastPageKey, pageIndex);
      }
    } catch (e) {
      print('Warning: Failed to save last page index: $e');
    }
  }
  
  static Future<int> getLastPageIndex() async {
    try {
      final prefs = await _preferences;
      return prefs?.getInt(_lastPageKey) ?? 0;
    } catch (e) {
      print('Warning: Failed to get last page index: $e');
      return 0;
    }
  }
  
  static Future<void> clearLastPageIndex() async {
    try {
      final prefs = await _preferences;
      if (prefs != null) {
        await prefs.remove(_lastPageKey);
      }
    } catch (e) {
      print('Warning: Failed to clear last page index: $e');
    }
  }
  
  
  static Future<void> setShowIndexOnStartup(bool showIndex) async {
    try {
      final prefs = await _preferences;
      if (prefs != null) {
        await prefs.setBool(_showIndexOnStartupKey, showIndex);
      }
    } catch (e) {
      print('Warning: Failed to save show index on startup: $e');
    }
  }
  
  static Future<bool> getShowIndexOnStartup() async {
    try {
      final prefs = await _preferences;
      return prefs?.getBool(_showIndexOnStartupKey) ?? true;
    } catch (e) {
      print('Warning: Failed to get show index on startup: $e');
      return true;
    }
  }
  
  
  static Future<void> saveFontSize(double fontSize) async {
    try {
      final prefs = await _preferences;
      if (prefs != null) {
        await prefs.setDouble(_fontSizeKey, fontSize);
      }
    } catch (e) {
      print('Warning: Failed to save font size: $e');
    }
  }
  
  static Future<double> getFontSize() async {
    try {
      final prefs = await _preferences;
      return prefs?.getDouble(_fontSizeKey) ?? 22.0;
    } catch (e) {
      print('Warning: Failed to get font size: $e');
      return 22.0;
    }
  }
  
  
  static Future<void> saveBackgroundColor(int colorValue) async {
    try {
      final prefs = await _preferences;
      if (prefs != null) {
        await prefs.setInt(_backgroundColorKey, colorValue);
      }
    } catch (e) {
      print('Warning: Failed to save background color: $e');
    }
  }
  
  static Future<int> getBackgroundColor() async {
    try {
      final prefs = await _preferences;
      return prefs?.getInt(_backgroundColorKey) ?? 0xFFFFFFF8;
    } catch (e) {
      print('Warning: Failed to get background color: $e');
      return 0xFFFFFFF8;
    }
  }
  
  static Future<void> saveTextColor(int colorValue) async {
    try {
      final prefs = await _preferences;
      if (prefs != null) {
        await prefs.setInt(_textColorKey, colorValue);
      }
    } catch (e) {
      print('Warning: Failed to save text color: $e');
    }
  }
  
  static Future<int> getTextColor() async {
    try {
      final prefs = await _preferences;
      return prefs?.getInt(_textColorKey) ?? 0xFF2F4F4F;
    } catch (e) {
      print('Warning: Failed to get text color: $e');
      return 0xFF2F4F4F;
    }
  }
  
  
  static Future<void> clearAllPreferences() async {
    try {
      final prefs = await _preferences;
      if (prefs != null) {
        await prefs.clear();
      }
    } catch (e) {
      print('Warning: Failed to clear all preferences: $e');
    }
  }
  
  static Future<bool> isFirstRun() async {
    try {
      final prefs = await _preferences;
      return prefs?.containsKey(_lastPageKey) != true;
    } catch (e) {
      print('Warning: Failed to check if first run: $e');
      return true;
    }
  }
  
  static Future<Map<String, dynamic>> getAllPreferences() async {
    try {
      final prefs = await _preferences;
      if (prefs == null) return {};
      
      final keys = prefs.getKeys();
      final Map<String, dynamic> prefsMap = {};
      
      for (String key in keys) {
        final value = prefs.get(key);
        prefsMap[key] = value;
      }
      
      return prefsMap;
    } catch (e) {
      print('Warning: Failed to get all preferences: $e');
      return {};
    }
  }
}