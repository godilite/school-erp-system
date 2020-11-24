import 'package:fsm/models/my_classes_model.dart';
import 'package:fsm/models/user_model.dart';

class Students {
  int id;
  int userId;
  int myClassId;
  int sectionId;
  String admNo;
  int myParentId;
  int dormId;
  Null dormRoomNo;
  String session;
  Null house;
  Null age;
  String yearAdmitted;
  int grad;
  Null gradDate;
  String createdAt;
  String updatedAt;
  MyClasses myClass;
  User user;

  Students(
      {this.id,
      this.userId,
      this.myClassId,
      this.sectionId,
      this.admNo,
      this.myParentId,
      this.dormId,
      this.dormRoomNo,
      this.session,
      this.house,
      this.age,
      this.yearAdmitted,
      this.grad,
      this.gradDate,
      this.createdAt,
      this.updatedAt,
      this.myClass,
      this.user});

  Students.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    myClassId = json['my_class_id'];
    sectionId = json['section_id'];
    admNo = json['adm_no'];
    myParentId = json['my_parent_id'];
    dormId = json['dorm_id'];
    dormRoomNo = json['dorm_room_no'];
    session = json['session'];
    house = json['house'];
    age = json['age'];
    yearAdmitted = json['year_admitted'];
    grad = json['grad'];
    gradDate = json['grad_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    myClass = json['my_class'] != null
        ? new MyClasses.fromJson(json['my_class'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['my_class_id'] = this.myClassId;
    data['section_id'] = this.sectionId;
    data['adm_no'] = this.admNo;
    data['my_parent_id'] = this.myParentId;
    data['dorm_id'] = this.dormId;
    data['dorm_room_no'] = this.dormRoomNo;
    data['session'] = this.session;
    data['house'] = this.house;
    data['age'] = this.age;
    data['year_admitted'] = this.yearAdmitted;
    data['grad'] = this.grad;
    data['grad_date'] = this.gradDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.myClass != null) {
      data['my_class'] = this.myClass.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
