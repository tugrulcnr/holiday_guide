import 'dart:math';
import '../models/plan_model.dart';
import 'holiday_service.dart';

class PlanService {
  final HolidayService _holidayService = HolidayService();

  Future<List<Plan>> generatePlan(int year, int leaveDays, String holidayType) async {
    final holidays = await _holidayService.fetchHolidays();
    final activities = await _holidayService.fetchActivities();
    final random = Random();

    holidays.removeWhere((holiday) => holiday.date.year != year);
    holidays.sort((a, b) => a.date.compareTo(b.date));

    List<Plan> plan = [];
    int usedLeaveDays = 0;

    for (var holiday in holidays) {
      if (usedLeaveDays >= leaveDays) break;

      final prevDay = holiday.date.subtract(const Duration(days: 1));
      final nextDay = holiday.date.add(const Duration(days: 1));

      if (!holidays.any((h) => h.date == prevDay) && usedLeaveDays < leaveDays) {
        plan.add(Plan(date: prevDay, description: "Leave day before holiday"));
        usedLeaveDays++;
      }
      plan.add(Plan(date: holiday.date, description: activities[holidayType]![random.nextInt(activities[holidayType]!.length)]));

      if (!holidays.any((h) => h.date == nextDay) && usedLeaveDays < leaveDays) {
        plan.add(Plan(date: nextDay, description: "Leave day after holiday"));
        usedLeaveDays++;
      }
    }

    return plan;
  }


}
