class Vacation {
  int id; //
  String userId; //
  String name;
  String department; //
  String employeeJob;
  String vacationType; //
  String submissionDate;
  String duration; //
  String startDate;
  String endDate;
  String backToWorkDate;
  String status;

  Vacation(this.name, this.employeeJob,this.vacationType,this.department,this.startDate,this.endDate,this.backToWorkDate,this.duration,this.id,this.status,this.submissionDate,this.userId);

  Vacation.fromJson(Map<String, dynamic> json)
      : id = json.containsKey('id') ? json['id'] : null,
        userId = json.containsKey('user_id') ? json['user_id'] : null,
        name = json.containsKey('name') ? json['name'] : null,
        department = json.containsKey('dept') ? json['dept'] : null,
        employeeJob = json.containsKey('job') ? json['job'] : null,
        vacationType = json.containsKey('type') ? json['type'] : null,
        submissionDate = json.containsKey('request_date') ? json['request_date'] : null,
        duration = json.containsKey('duration') ? json['duration'] : null,
        startDate = json.containsKey('start_in') ? json['start_in'] : null,
        endDate = json.containsKey('end_in') ? json['end_in'] : null,
        status = json.containsKey('status') ? json['status'] : null,
      backToWorkDate = json.containsKey('back_to_work_date') ? json['back_to_work_date'] : null;


}
