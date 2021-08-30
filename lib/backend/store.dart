import 'package:person_picker_v2/models/user.dart';

abstract class Store {
  Future<User> load();
  Future<bool> save();

  bool get active;
}
