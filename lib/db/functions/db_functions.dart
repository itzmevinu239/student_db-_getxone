import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/data_model.dart';

class StudentController extends GetxController {
  RxList<StudentModel> studentList = <StudentModel>[].obs;
  RxList<StudentModel> searchStudentList = <StudentModel>[].obs;

  @override
  void onInit() {
    getAllStudents();
    super.onInit();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentList.clear();
    studentList.addAll(studentDB.values);
    studentList.refresh();
  }

  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.add(value);
    await getAllStudents();
  }

  Future<void> deleteStudent(int id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.delete(id);
    await getAllStudents();
    update();
  }

  Future<void> updateNew(StudentModel value, int id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.put(id, value);
    update();
    await getAllStudents();
  }

  setSearchList() {
    searchStudentList = studentList;
  }

  search(String text) {
    List<StudentModel> tempList = [];
    tempList = searchStudentList
        .where(
          (element) => element.name.toLowerCase().contains(
                text.toLowerCase(),
              ),
        )
        .toList();
    searchStudentList.value = tempList;
  }
}
