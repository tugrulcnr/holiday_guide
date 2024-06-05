class Holiday {
  DateTime date;

  Holiday({required this.date});

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(date: DateTime.parse(json['date']));
  }
}
