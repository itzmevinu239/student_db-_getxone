import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_db/db/functions/db_functions.dart';
import 'package:student_db/db/model/data_model.dart';

// ignore: must_be_immutable
class ScreenEdit extends StatefulWidget {
  ScreenEdit({
    super.key,
    required this.name,
    required this.age,
    required this.phone,
    required this.id,
  });
  final int id;
  String name;
  String age;
  String phone;

  @override
  State<ScreenEdit> createState() => _ScreenEditState();
}

class _ScreenEditState extends State<ScreenEdit> {
  final myStudent = Get.put(StudentController());
  File? selectedimage;
  // ignore: non_constant_identifier_names
  final student_nameEdit = TextEditingController();
  // ignore: non_constant_identifier_names
  final student_ageEdit = TextEditingController();
  // ignore: non_constant_identifier_names
  final student_phoneEdit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    student_nameEdit.text = widget.name;
    student_ageEdit.text = widget.age;
    student_phoneEdit.text = widget.phone;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: CircleAvatar(
                radius: 70,
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(40),
                  child: ClipOval(
                    child: selectedimage != null
                        ? Image.file(
                            selectedimage!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/1.jpg'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: student_nameEdit,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: student_ageEdit,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Age'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: student_phoneEdit,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Phone Number'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                final data = StudentModel(
                    name: student_nameEdit.text,
                    age: student_ageEdit.text,
                    phone: student_phoneEdit.text);
                myStudent.updateNew(data, widget.id);
                Get.back();
              },
              child: const Text('Update'),
            ),
          ],
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
    setState(
      () {
        selectedimage = imageTemporary;
      },
    );
  }
}
