import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_db/db/functions/db_functions.dart';
import 'package:student_db/screens/profile_screen.dart';
import 'package:student_db/screens/screen_home.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});

  final myStudent = Get.put(
    StudentController(),
  );

  @override
  Widget build(BuildContext context) {
    myStudent.setSearchList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.offAll(ScreenHome());
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          CupertinoSearchTextField(
            onChanged: (value) {
              myStudent.search(value);
            },
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                  itemCount: myStudent.searchStudentList.length,
                  itemBuilder: (context, index) {
                    final data = myStudent.searchStudentList[index];
                    return ListTile(
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
                    );
                  });
            }),
          ),
        ],
      )),
    );
  }
}
