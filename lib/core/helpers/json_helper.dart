import 'dart:convert';

import 'package:flutter/services.dart';

class JsonHelper {
  static getJson({required String path}) async {
    final String response = await rootBundle.loadString(path);
    final data = jsonDecode(response);
    return data;
  }
}
