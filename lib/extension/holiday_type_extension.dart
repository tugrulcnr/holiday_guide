import '../enums/holiday_type.dart';

extension HolidayTypeExtension on HolidayType {
  String get displayName {
    switch (this) {
      case HolidayType.fun:
        return 'Fun';
      case HolidayType.sea:
        return 'Sea';
      default:
        return '';
    }
  }
}