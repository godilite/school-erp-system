import 'package:fsm/models/class_type.dart';
import 'package:fsm/models/section_model.dart';

class MyClasses {
  int id;
  String name;
  int classTypeId;
  Null createdAt;
  Null updatedAt;
  ClassType classType;
  List<Section> section;

  MyClasses(
      {this.id,
      this.name,
      this.classTypeId,
      this.createdAt,
      this.updatedAt,
      this.classType,
      this.section});

  MyClasses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    classTypeId = json['class_type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    classType = json['class_type'] != null
        ? new ClassType.fromJson(json['class_type'])
        : null;
    if (json['section'] != null) {
      section = new List<Section>();
      json['section'].forEach((v) {
        section.add(new Section.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['class_type_id'] = this.classTypeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.classType != null) {
      data['class_type'] = this.classType.toJson();
    }
    if (this.section != null) {
      data['section'] = this.section.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
