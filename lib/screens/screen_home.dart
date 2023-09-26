// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_db/db/functions/db_functions.dart';
import 'package:student_db/db/model/data_model.dart';
import 'package:student_db/screens/add_student.dart';
import 'package:student_db/screens/edit_screen.dart';
import 'package:student_db/screens/profile_screen.dart';
import 'package:student_db/screens/search_screen.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
  StudentController myStudent = Get.put(
    StudentController(),
  );
  ScreenHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.off(
                () => ScreenSearch(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Obx(
        () {
          final studentList = myStudent.studentList;
          return ListView.builder(
            itemBuilder: ((context, index) {
              final data = studentList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(101, 158, 158, 158),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.to(
                        ScreenProfile(
                          name: data.name,
                          age: data.age,
                          phone: data.phone,
                        ),
                      );
                    },
                    leading: const CircleAvatar(),
                    title: Text(data.name),
                    subtitle: Text(data.age),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(
                                () => ScreenEdit(
                                  name: data.name,
                                  age: data.age,
                                  phone: data.phone,
                                  id: data.key,
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, data);
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            itemCount: myStudent.studentList.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(ScreenAddStudent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, StudentModel data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: Text('Are you sure you want to delete ${data.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                myStudent.deleteStudent(data.key);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
