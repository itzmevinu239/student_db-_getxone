import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String age;

  @HiveField(2)
  String phone;
  

  StudentModel({
    required this.name,
    required this.age,
    required this.phone,
   
  });
}
