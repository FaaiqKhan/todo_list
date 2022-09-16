import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_item_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class TodoItemModel {
  @HiveField(0)
  int? userId;
  @HiveField(1)
  int? id;
  @HiveField(2)
  String title;
  @HiveField(3)
  bool completed;

  TodoItemModel({
    this.id,
    this.userId,
    required this.title,
    this.completed = false,
  });

  factory TodoItemModel.fromJson(Map<String, dynamic> json) =>
      _$TodoItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemModelToJson(this);
}
