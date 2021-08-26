import 'package:person_picker_v2/constants/logger.dart';
import 'package:person_picker_v2/models/participant.dart';
import 'package:person_picker_v2/models/serializable.dart';
import 'package:uuid/uuid.dart';

class Group extends Serializable {
  late List<Participant> members;
  int number;
  late String name;
  late String description;

  Group(
      {this.members = const [],
      this.number = 0,
      required this.name,
      this.description = ''})
      : super(uid: const Uuid().v4());

  @override
  Type get type => Group;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        name: json['name'],
        description: json['description'],
        number: json['number'],
        members: (json['members'] as List<dynamic>)
            .map((element) => Participant.fromJson(element))
            .toList(),
      );

  @override
  Map<String, dynamic> get json => {
        'uid': uid,
        'mambers': members,
        'number': number,
        'name': name,
        'description': description
      };

  void removeMember(String memberUID) =>
      members.removeWhere((element) => element.uid == memberUID);

  void addMember(Participant newMember) => members.contains(newMember)
      ? logger.w("Attemting to add member which is already in group!")
      : members.add(newMember);
}
