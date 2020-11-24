import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsm/editable/editable.dart';
import 'package:fsm/models/my_classes_model.dart';
import 'package:fsm/models/section_model.dart';
import 'package:fsm/services/api_service.dart';
import 'package:fsm/theme.dart';

class ResultView extends StatefulWidget {
  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  _classes() async {
    return this._memoizer.runOnce(() async {
      return await getClasses();
    });
    //  await getClasses();
  }

  MyClasses selectedClass;
  List<Section> selectedSections = [];
  //   List<Project> _projects = [];
  @override
  void initState() {
    super.initState();
    _classes();
    //   _getProjectsFromAllCategories().then((value){
    //     setState(() {
    //       _projects = value;
    //     });
    //   });
  }

  //  _getProjectsFromAllCategories()async{
  //      return await getProjects('', 'false');
  // }
  List rows = [];
  List cols = [
    {"title": 'Student Name', 'index': 1, 'key': 'name'},
    {"title": 'Admission Number', 'index': 2, 'key': 'adm_no'},
    {"title": 'Year Admitted', 'index': 3, 'key': 'year_admitted'},
    {"title": 'Email', 'index': 4, 'key': 'email'},
    {"title": 'DOB', 'index': 5, 'key': 'dob'},
    {"title": 'Gender', 'index': 6, 'key': 'gender'},
    {"title": 'Phone', 'index': 7, 'key': 'phone'}
  ];

  _getStudentsByClass(classId, secId) async {
    var records = await getStudents(classId, secId);
    records.forEach((item) {
      var student = {
        'name': item.user.name,
        'adm_no': item.admNo,
        'year_admitted': item.yearAdmitted,
        'email': item.user.email,
        'dob': item.user.dob,
        'gender': item.user.gender,
        'phone': item.user.phone
      };

      rows.add(student);
      print(rows);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(children: [
            Container(
              width: 150,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: drawbackgroundColor,
                  borderRadius: BorderRadius.circular(15)),
              child: FutureBuilder<dynamic>(
                  future: _classes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      selectedClass = snapshot.data[0];
                      selectedSections = snapshot.data[0].section;
                      return DropdownButtonFormField(
                          hint: Text(selectedClass.name),
                          decoration: InputDecoration(border: InputBorder.none),
                          items: snapshot.data
                              .map<DropdownMenuItem<dynamic>>((item) {
                            MyClasses _item = item;

                            return DropdownMenuItem(
                              value: _item.name,
                              child: Text(_item.name),
                              onTap: () {
                                selectedSections = _item.section;
                                setState(() {});
                              },
                            );
                          }).toList(),
                          onChanged: (open) {
                            print(open);
                          });
                    } else {
                      return Text('Loading...');
                    }
                  }),
            ),
            Container(
              width: 150,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: drawbackgroundColor,
                  borderRadius: BorderRadius.circular(15)),
              child: selectedSections.isNotEmpty
                  ? DropdownButtonFormField(
                      hint: Text(selectedSections[0].name),
                      decoration: InputDecoration(border: InputBorder.none),
                      items: selectedSections
                          .map<DropdownMenuItem<dynamic>>((item) {
                        Section _item = item;
                        print(item.name);
                        return DropdownMenuItem(
                          value: _item.id,
                          child: Text(_item.name),
                          onTap: () {
                            _getStudentsByClass(selectedClass.id, item.id);
                            //  setState(() {
                            //    _projects = _item.projects;
                            //  });
                          },
                        );
                      }).toList(),
                      onChanged: (open) {
                        // print(open);
                      })
                  : Text('Loading...'),
            )
          ]),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: drawbackgroundColor,
              ),
              child: Editable(
                onRowSaved: (value) {
                  print(value);
                },
                onSubmitted: (value) {
                  print(value);
                },
                columns: cols,
                rows: rows,
                showCreateButton: true,
                showSaveIcon: true,
              ),
            ),
          ),
        ],
      );
    });
  }
}
