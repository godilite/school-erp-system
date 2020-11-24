import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String code;
  String username;
  String userType;
  String dob;
  String gender;
  String photo;
  String phone;
  Null phone2;
  int bgId;
  int stateId;
  int lgaId;
  int nalId;
  String address;
  Null emailVerifiedAt;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.code,
      this.username,
      this.userType,
      this.dob,
      this.gender,
      this.photo,
      this.phone,
      this.phone2,
      this.bgId,
      this.stateId,
      this.lgaId,
      this.nalId,
      this.address,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    code = json['code'];
    username = json['username'];
    userType = json['user_type'];
    dob = json['dob'];
    gender = json['gender'];
    photo = json['photo'];
    phone = json['phone'];
    phone2 = json['phone2'];
    bgId = json['bg_id'];
    stateId = json['state_id'];
    lgaId = json['lga_id'];
    nalId = json['nal_id'];
    address = json['address'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['code'] = this.code;
    data['username'] = this.username;
    data['user_type'] = this.userType;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['photo'] = this.photo;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    data['bg_id'] = this.bgId;
    data['state_id'] = this.stateId;
    data['lga_id'] = this.lgaId;
    data['nal_id'] = this.nalId;
    data['address'] = this.address;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

List<User> allUsersFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<User>.from(jsonData.map((x) => User.fromJson(x)));
}
