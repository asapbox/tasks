class Task {
  String title;
  DateTime dueOn; // deadLine
  String status;
  DateTime? startTime;
  DateTime? endTime;
  String? reminding;
  String? repeating;
  bool isCompleted;
  bool isFavorite;

  Task({
    required this.title,
    required this.dueOn,
    required this.status,
    this.startTime,
    this.endTime,
    this.reminding,
    this.repeating,
    this.isCompleted = false,
    this.isFavorite = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'] as String,
        dueOn: DateTime.parse(json['due_on'] as String),
        status: json['status'] as String,
        startTime: DateTime.parse(json['startTime'] as String),
        endTime: DateTime.parse(json['endTime'] as String),
        reminding: json['reminding'] as String,
        repeating: json['repeating'] as String,
        isCompleted: json['isCompleted'] as bool,
        isFavorite: json['isFavorite'] as bool,
      );

  factory Task.fromApiJson(Map<String, dynamic> json) {
    final bool? isCompleted;

    if (json['status'] == 'completed') {
      isCompleted = true;
    } else {
      isCompleted = false;
    }

    return Task(
      title: json['title'] as String,
      dueOn: DateTime.parse(json['due_on'] as String),
      status: json['status'] as String,
      isCompleted: isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }


  @override
  String toString() => 'Task(title: $title, dueOn: $dueOn, status: $status, '
      'startTime: $startTime, endTime: $endTime, reminding: $reminding, '
      'repeating: $repeating, isCompleted: $isCompleted, '
      'isFavorite: $isFavorite)';
}
