import 'package:hive/hive.dart';
import 'package:my_postviewer/models/user.dart';

part 'user_adapter.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  User({required this.id, required this.name, required this.email});
}
