import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_db/db/functions/db_functions.dart';
import 'package:student_db/db/model/data_model.dart';
import 'package:student_db/screens/screen_home.dart';

// ignore: must_be_immutable
class ScreenAddStudent extends StatelessWidget {
  ScreenAddStudent({super.key});
  File? selectedimage;
  // ignore: non_constant_identifier_names
  TextEditingController student_name = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController student_age = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController student_num = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentController = Get.put(StudentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student Details'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(ScreenHome());
            },
            icon: const Icon(Icons.list),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<StudentController>(
            builder: (controller) => Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: getImage,
                      child: CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: selectedimage != null
                              ? Image.file(
                                  selectedimage!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/1.jpg',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: student_name,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This needs to be filled';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: student_age,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Age'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This needs to be filled';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: student_num,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Phone Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This needs to be filled';
                        } else if (value.length < 10 || value.length > 10) {
                          return 'Invalid entry';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // ignore: unnecessary_null_comparison
                          if (student_name.text != null &&
                              // ignore: unnecessary_null_comparison
                              student_age.text != null &&
                              // ignore: unnecessary_null_comparison
                              student_num.text != null) {
                            StudentController().addStudent(
                              StudentModel(
                                name: student_name.text,
                                age: student_age.text,
                                phone: student_num.text,
                              ),
                            );
                          }
                          studentController.getAllStudents();
                          Get.back();
                        } else {}
                      },
                      child: const Text('Add Student'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    XFile? image;
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageTemporary = File(image.path);

    selectedimage = imageTemporary;
  }
}
