import 'class_type.dart';
import 'my_classes_model.dart';

class Classes {
  List<MyClasses> myClasses;
  List<ClassType> classTypes;

  Classes({this.myClasses, this.classTypes});

  Classes.fromJson(Map<String, dynamic> json) {
    if (json['my_classes'] != null) {
      myClasses = List<MyClasses>();
      json['my_classes'].forEach((v) {
        myClasses.add(MyClasses.fromJson(v));
      });
    }
    if (json['class_types'] != null) {
      classTypes = List<ClassType>();
      json['class_types'].forEach((v) {
        classTypes.add(ClassType.fromJson(v));
      });
    }
  }
}
