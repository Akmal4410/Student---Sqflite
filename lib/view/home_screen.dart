import 'package:flutter/material.dart';
import 'package:student_mannagement_sqflite/controller/db_functions.dart';
import 'package:student_mannagement_sqflite/model/student.dart';
import 'package:student_mannagement_sqflite/view/edit_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DBFunction.getAllStudent();
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQFLITE Sample'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                hintText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final age = ageController.text.trim();
                if (name.isEmpty || age.isEmpty) return;
                final student = Student(name: name, age: int.parse(age));
                DBFunction.addStudent(student);
                nameController.clear();
                ageController.clear();
              },
              child: const Text('Add Student'),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: studentListNotifier,
                  builder: (BuildContext context, List<Student> studentList,
                      Widget? child) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final student = studentList[index];
                        return ListTile(
                          title: Text(student.name),
                          subtitle: Text(student.age.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return EditScreen(student: student);
                                    },
                                  ));
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  DBFunction.deleteStudent(student: student);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
                      itemCount: studentList.length,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
