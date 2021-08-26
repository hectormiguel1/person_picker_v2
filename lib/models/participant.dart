import 'package:person_picker_v2/models/serializable.dart';
import 'package:uuid/uuid.dart';

class Participant extends Serializable {
  late String name;
  late int points;

  Participant({required this.name, this.points = 0})
      : super(uid: const Uuid().v4());

  //Deserialize
  Participant.fromJson(Map<String, dynamic> json) : super(uid: json['uid']) {
    name = json['name'];
    points = json['points'];
  }

  //Creates a carbon copy of the object.
  Participant clone() {
    return Participant(name: name, points: points);
  }

  ReadOnlyParticipant toReadOnly() => ReadOnlyParticipant(name, points);

  //Serialize
  @override
  Map<String, dynamic> get json => {'uid': uid, 'name': name, 'points': points};

  @override
  Type get type => Participant;
}

class ReadOnlyParticipant {
  final String _name;
  final int _points;

  ReadOnlyParticipant(this._name, this._points);

  String get name => _name;
  int get points => _points;
}
