class Section {
  int id;
  String name;
  int myClassId;
  Null teacherId;
  int active;
  Null createdAt;
  Null updatedAt;

  Section(
      {this.id,
      this.name,
      this.myClassId,
      this.teacherId,
      this.active,
      this.createdAt,
      this.updatedAt});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    myClassId = json['my_class_id'];
    teacherId = json['teacher_id'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['my_class_id'] = this.myClassId;
    data['teacher_id'] = this.teacherId;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
