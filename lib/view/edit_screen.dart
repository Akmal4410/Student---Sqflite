import 'package:flutter/material.dart';
import 'package:student_mannagement_sqflite/controller/db_functions.dart';
import 'package:student_mannagement_sqflite/model/student.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key, required this.student});
  final Student student;
  late final TextEditingController nameController;
  late final TextEditingController ageController;

  getControllerValues() {
    nameController = TextEditingController(text: student.name);
    ageController = TextEditingController(text: student.age.toString());
  }

  @override
  Widget build(BuildContext context) {
    getControllerValues();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
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
              onPressed: () async {
                final name = nameController.text.trim();
                final age = ageController.text.trim();
                if (name.isEmpty || age.isEmpty) return;
                final newStudent = Student(name: name, age: int.parse(age));
                await DBFunction.editStudent(
                    student: newStudent, oldName: student.name);

                Navigator.pop(context);
                nameController.clear();
                ageController.clear();
              },
              child: const Text('Edit Student'),
            ),
          ],
        ),
      ),
    );
  }
}
