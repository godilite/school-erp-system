import 'dart:convert';
import 'dart:io';

import 'package:fsm/models/my_classes_model.dart';
import 'package:fsm/models/student_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

String url = "http://localhost:8000/api";
final Box userBox = Hive.box('userBox');
var token = userBox.get('token');

Future<http.Response> loginUser(user) async {
  final response = await http.post('$url/login', headers: {
    HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    HttpHeaders.acceptHeader: 'application/json',
    // HttpHeaders.authorizationHeader : ''
  }, body: {
    'password': user['password'],
    'email': user['email'],
    'device_name': 'desktop'
  });
  return response;
}

Future<List<MyClasses>> getClasses() async {
  final response = await http.get(
    '$url/classes',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );
  var data = json.decode(response.body);
  List<dynamic> classesJson = data['my_classes'];
  List<MyClasses> classes = [];
  classesJson.forEach(
    (json) => classes.add(
      MyClasses.fromJson(json),
    ),
  );
  return classes;
}

Future<List<Students>> getStudents(int classId, int secId) async {
  final response = await http.get(
    '$url/students/list/$classId/$secId',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
  );
  var data = json.decode(response.body);
  List<dynamic> studentsJson = data['students'];
  List<Students> students = [];
  studentsJson.forEach(
    (json) => students.add(
      Students.fromJson(json),
    ),
  );
  return students;
}

Future createStudent(Students student) async {
  final response = await http.post(
    '$url/create/student',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
    body: student.toJson(),
  );
  var message = json.decode(response.body);

  return message;
}
