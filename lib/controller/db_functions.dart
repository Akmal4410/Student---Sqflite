import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_mannagement_sqflite/model/student.dart';

ValueNotifier<List<Student>> studentListNotifier = ValueNotifier([]);
late Database database;

class DBFunction {
  static Future<void> openMyDatabase() async {
    database = await openDatabase(
      'Student.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Student (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
      },
    );
  }

  static Future<void> getAllStudent() async {
    final studentDbList = await database.rawQuery('SELECT * FROM Student');
    print(studentDbList);
    studentListNotifier.value.clear();
    studentDbList.forEach((map) {
      final student = Student.fromMap(map);
      studentListNotifier.value.add(student);
    });

    studentListNotifier.notifyListeners();
    log('Sucessfull');
  }

  static Future<void> addStudent(Student student) async {
    await database.rawInsert(
      'INSERT INTO Student(name, age) VALUES(?, ?)',
      [student.name, student.age],
    );
    getAllStudent();
  }

  static Future<void> deleteStudent({required Student student}) async {
    await database
        .rawDelete('DELETE FROM Student WHERE name = ?', [student.name]);
    await getAllStudent();
  }

  static Future<void> editStudent(
      {required Student student, required String oldName}) async {
    await database.rawUpdate(
      'UPDATE Student SET name = ?, age = ? WHERE name = ?',
      [student.name, student.age, oldName],
    );
    await getAllStudent();
  }
}
