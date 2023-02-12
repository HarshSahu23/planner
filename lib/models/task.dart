class Task {
  int? id;
  int? color;
  int? remind;
  int? isCompleted;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  String? repeat;
  Task(
      {this.id,
      this.color,
      this.remind,
      this.isCompleted,
      this.title,
      this.note,
      this.date,
      this.startTime,
      this.endTime,
      this.repeat});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    remind = json['remind'];
    isCompleted = json['isCompleted'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    repeat = json['repeat'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color'] = this.color;
    data['remind'] = this.remind;
    data['isCompleted'] = this.isCompleted;
    data['title'] = this.title;
    data['note'] = this.note;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['repeat'] = this.repeat;
    return data;
  }
}
