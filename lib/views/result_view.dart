import 'package:holiday_guide/extension/holiday_type_extension.dart';
import 'package:flutter/material.dart';
import '../models/plan_model.dart';
import '../services/plan_service.dart';
import '../enums/holiday_type.dart';
import '../utils/strings.dart';

class ResultView extends StatelessWidget {
  final int year;
  final int leaveDays;
  final HolidayType holidayType;

  ResultView({super.key, required this.year, required this.leaveDays, required this.holidayType});

  final PlanService _planService = PlanService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.planHoliday)),
      body: FutureBuilder<List<Plan>>(
        future: _planService.generatePlan(year, leaveDays, holidayType.displayName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text(Strings.notFoundPlan));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final plan = snapshot.data![index];
                return ListTile(
                  title: Text(plan.description),
                  subtitle: Text(plan.date.toLocal().toString().split(' ')[0]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
