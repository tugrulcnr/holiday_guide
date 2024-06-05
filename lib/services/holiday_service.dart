import 'dart:convert';
import 'package:holiday_guide/utils/strings.dart';
import 'package:flutter/services.dart';
import '../models/holiday_model.dart';

class HolidayService {
  Future<List<Holiday>> fetchHolidays() async {
    final String response = await rootBundle.loadString(Strings.assetPath);
    final data = await json.decode(response);
    return (data['holidays'] as List).map((e) => Holiday.fromJson({'date': e})).toList();
  }

  Future<Map<String, List<String>>> fetchActivities() async {
    final String response = await rootBundle.loadString(Strings.assetPath);
    final data = await json.decode(response);
    
    final activities = data['activities'] as Map<String, dynamic>;
    return activities.map((key, value) => MapEntry(key, List<String>.from(value)));
  }
}
