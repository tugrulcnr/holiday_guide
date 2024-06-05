import 'package:holiday_guide/extension/string_extensions.dart';
import 'package:holiday_guide/utils/strings.dart';

class Validators {
  static String? validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.enterYear;
    } else if (!value.isNumeric) {
      return Strings.errorYear;
    }
    return null;
  }

  static String? validateLeaveDays(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.enterPermits;
    } else if (!value.isNumeric) {
      return Strings.errorPermits;
    }
    return null;
  }

  static String? validateHolidayType(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.enterHolidayType;
    }
    return null;
  }
}
