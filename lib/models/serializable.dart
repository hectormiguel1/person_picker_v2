import 'package:person_picker_v2/constants/logger.dart';
import 'package:person_picker_v2/models/class.dart';
import 'package:person_picker_v2/models/group.dart';
import 'package:person_picker_v2/models/participant.dart';
import 'package:person_picker_v2/models/user.dart';

abstract class Serializable {
  late String uid;
  Map<String, dynamic> get json;

  Type get type => runtimeType;

  Serializable({required this.uid});

  //Used to serialize objects.
  static Type getType<T>() => T;

  //Used to deserialize objects from json
  static dynamic fromJson<T extends Serializable>(Map<String, dynamic> json) {
    switch (getType<T>()) {
      case Participant:
        return Participant.fromJson(json);
      case Class:
        return Class.fromJson(json);
      case User:
        return User.fromJson(json);
      case Group:
        return Group.fromJson(json);
      default:
        logger.e('Type ${getType<T>()} deserialization not implemented');
    }
  }
}
