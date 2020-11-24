import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsm/editable/editable.dart';
import 'package:fsm/models/my_classes_model.dart';
import 'package:fsm/models/section_model.dart';
import 'package:fsm/models/student_model.dart';
import 'package:fsm/services/api_service.dart';
import 'package:fsm/theme.dart';

class StudentView extends StatefulWidget {
  @override
  _StudentViewState createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  final classDrop = GlobalKey<EditableState>();
  GlobalKey _sectionDrop = GlobalKey<FormFieldState>();

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  Future<List<MyClasses>> _classes() async {
    return await getClasses();

    //  await getClasses();
  }

  Students newstudent;
  MyClasses selectedClass;
  String classId;
  String sectionId;
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
    {"title": 'Student Name', 'widthFactor': 0.1, 'key': 'name'},
    {"title": 'Admission Number', 'widthFactor': 0.1, 'key': 'adm_no'},
    {"title": 'Year Admitted', 'widthFactor': 0.1, 'key': 'year_admitted'},
    {"title": 'Email', 'widthFactor': 0.1, 'key': 'email'},
    {"title": 'DOB', 'widthFactor': 0.1, 'key': 'dob'},
    {"title": 'Gender', 'widthFactor': 0.1, 'key': 'gender'},
    {"title": 'Phone', 'key': 'phone'}
  ];

  _getStudentsByClass(classId, secId, item) async {
    _item = item;
    var student;
    var records = await getStudents(classId, secId);

    records.forEach((item) {
      student = {
        'name': item.user.name,
        'adm_no': item.admNo,
        'year_admitted': item.yearAdmitted,
        'email': item.user.email,
        'dob': item.user.dob,
        'gender': item.user.gender,
        'phone': item.user.phone
      };
      rows.add(student);
    });
    if (student == null) {
      rows.clear();

      setState(() {
        rows = [];
      });
    }
    setState(() {});
  }

  Section _item;
  List<DropdownMenuItem> list = [];
  var _selectedItem = 0;
  var selectedItemName;
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
              child: DropdownButtonHideUnderline(
                child: FutureBuilder<List<MyClasses>>(
                  future: _classes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container();
                    } else if (snapshot.hasData) {
                      list.clear();
                      //listItemNames.clear();
                      var dropDownItemsMap = new Map();

                      snapshot.data.forEach((item) {
                        //listItemNames.add(branchItem.itemName);
                        int index = snapshot.data.indexOf(item);
                        dropDownItemsMap[index] = item;

                        list.add(DropdownMenuItem(
                            child: Text(item.name), value: index));
                      });
                      selectedItemName = dropDownItemsMap[_selectedItem].name;
                      _item = dropDownItemsMap[_selectedItem].section[0];
                      return DropdownButton(
                        items: list,
                        onChanged: (selected) {
                          _selectedItem = selected;
                          setState(() {
                            selectedSections.clear();
                            selectedSections =
                                dropDownItemsMap[_selectedItem].section;
                            _item = selectedSections[0];
                            selectedItemName =
                                dropDownItemsMap[_selectedItem].name;
                          });
                        },
                        hint: Text(
                          selectedItemName,
                          style: TextStyle(color: Colors.blue),
                        ),
                      );
                    } else {
                      return Text('loading...');
                    }
                  },
                ),
              ),
            ),
            Container(
              width: 150,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: drawbackgroundColor,
                  borderRadius: BorderRadius.circular(15)),
              child: _item != null
                  ? DropdownButton<Section>(
                      hint: Text(_item != null ? _item.name : 'selected'),
                      value: _item != null ? _item : null,
                      onChanged: (Section value) {
                        print(value);
                      },
                      items: selectedSections.map((Section item) {
                        return DropdownMenuItem<Section>(
                          value: item != null ? item : null,
                          child: Text(item != null ? item.name : ''),
                          onTap: () {
                            _getStudentsByClass(item.myClassId, item.id, item);
                          },
                        );
                      }).toList(),
                    )
                  : Text(''),
            ),
            TextButton(
                onPressed: () {
                  classDrop.currentState.createRow();
                  setState(() {});
                },
                child: Text('create new row'))
          ]),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: drawbackgroundColor,
              ),
              child: Editable(
                key: classDrop,
                onRowSaved: (value) {
                  newstudent = Students.fromJson(value);
                  print(newstudent);
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
