import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'message.g.dart';

@HiveType(typeId: 0)
class Message {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final DateTime timeStamp;

  Message({required this.message, required this.timeStamp, required this.id});
}
