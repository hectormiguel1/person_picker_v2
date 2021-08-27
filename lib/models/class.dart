import 'dart:math';

import 'package:person_picker_v2/constants/logger.dart';
import 'package:person_picker_v2/models/group.dart';
import 'package:person_picker_v2/models/participant.dart';
import 'package:person_picker_v2/models/serializable.dart';
import 'package:uuid/uuid.dart';

class Class extends Serializable {
  late List<Participant> classParticipants;
  late String className;
  late List<Group> groups;

  Class(
      {required this.className,
      this.classParticipants = const [],
      this.groups = const []})
      : super(uid: const Uuid().v4());

  Class.fromJson(Map<String, dynamic> json) : super(uid: json['uid']) {
    className = json['className'];
    classParticipants = (json['classParticipants'] as List<dynamic>)
        .map((element) => Participant.fromJson(element))
        .toList();
    groups = (json['groups'] as List<dynamic>)
        .map((element) => Group.fromJson(element))
        .toList();
  }

  void assignToGroupsRandom(int numOfMembers) {
    List<Participant> participants = classParticipants;

    if (numOfMembers > participants.length ||
        numOfMembers > participants.length / 2) {
      logger
          .w('Attempting to create $numOfMembers with ${participants.length}');
    }
    Random rng = Random.secure();
    int count = 0;
    while (participants.isNotEmpty) {
      Group newGroup = Group(name: count.toString(), number: count++);
      for (int i = 0; i < numOfMembers; i++) {
        int pickedParticipant = rng.nextInt(participants.length);
        newGroup.addMember(participants[pickedParticipant]);
        participants.removeAt(pickedParticipant);
        if (participants.isEmpty) break;
      }
      groups.add(newGroup);
    }
  }

  @override
  Map<String, dynamic> get json => {
        'uid': uid,
        'className': className,
        'classParticipants':
            classParticipants.map((element) => element.json).toList(),
        'groups': groups.map((element) => element.json).toList()
      };
}
