// ignore_for_file: must_be_immutable
import 'package:holiday_guide/extension/holiday_type_extension.dart';
import 'package:flutter/material.dart';
import '../enums/holiday_type.dart';
import '../utils/strings.dart';
import '../utils/validators.dart';
import '../widgets/error_dialog.dart';
import 'result_view.dart';

class HomeView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController();
  final _leaveDaysController = TextEditingController();
  HolidayType? _holidayType;

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.appTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: Strings.year),
                keyboardType: TextInputType.number,
                validator: Validators.validateYear,
              ),
              TextFormField(
                controller: _leaveDaysController,
                decoration: const InputDecoration(labelText: Strings.numberofPermits),
                keyboardType: TextInputType.number,
                validator: Validators.validateLeaveDays,
              ),
              DropdownButtonFormField<HolidayType>(
                decoration: const InputDecoration(labelText: Strings.type),
                items: HolidayType.values.map((HolidayType value) {
                  return DropdownMenuItem<HolidayType>(
                    value: value,
                    child: Text(value.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  _holidayType = value;
                },
                validator: (value) {
                  if (value == null) {
                    return Strings.enterHolidayType;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultView(
                          year: int.parse(_yearController.text),
                          leaveDays: int.parse(_leaveDaysController.text),
                          holidayType: _holidayType!,
                        ),
                      ),
                    );
                  } else {
                    ErrorDialog.showErrorDialog(context, Strings.warning);
                  }
                },
                child: const Text(Strings.plan),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
