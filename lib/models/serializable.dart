import 'package:person_picker_v2/constants/logger.dart';
import 'package:person_picker_v2/models/participant.dart';

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
      default:
        logger.e('Type ${getType<T>()} deserialization not implemented');
    }
  }
}
