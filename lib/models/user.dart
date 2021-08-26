import 'package:person_picker_v2/models/class.dart';
import 'package:person_picker_v2/models/serializable.dart';
import 'package:uuid/uuid.dart';

class User extends Serializable {
  late List<Class> classes;

  User({this.classes = const []}) : super(uid: const Uuid().v4());

  User.fromJson(Map<String, dynamic> json) : super(uid: json['uid']) {
    classes = (json['classes'] as List<dynamic>)
        .map((element) => Class.fromJson(json))
        .toList();
  }

  @override
  Map<String, dynamic> get json =>
      {'uid': uid, 'classes': classes.map((element) => element.json).toList()};
}
