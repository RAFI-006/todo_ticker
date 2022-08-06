// To parse this JSON data, do
//
//     final tasksModel = tasksModelFromMap(jsonString);

import 'dart:convert';

class TasksModel {
  TasksModel({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.status,
  });

  int? id;
  String? title;
  String? description;
  int? duration;
  String? status;

  factory TasksModel.fromJson(String str) => TasksModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TasksModel.fromMap(Map<String, dynamic> json) => TasksModel(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    duration: json["duration"] == null ? null : json["duration"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "duration": duration == null ? null : duration,
    "status": status == null ? null : status,
  };
}
