import 'package:person_picker_v2/models/participant.dart';
import 'package:person_picker_v2/models/serializable.dart';
import 'package:uuid/uuid.dart';

class Class extends Serializable {
  late List<Participant> classParticipants;
  late String className;

  Class({required this.className, this.classParticipants = const []})
      : super(uid: const Uuid().v4());

  Class.fromJson(Map<String, dynamic> json) : super(uid: json['uid']) {
    className = json['className'];
    classParticipants = (json['classParticipants'] as List<dynamic>)
        .map((element) => Participant.fromJson(element))
        .toList();
  }

  @override
  Map<String, dynamic> get json => {
        'uid': uid,
        'className': className,
        'classParticipants':
            classParticipants.map((element) => element.json).toList()
      };
}
