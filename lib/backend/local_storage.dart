import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:person_picker_v2/backend/store.dart';
import 'package:person_picker_v2/constants/logger.dart';
import 'package:person_picker_v2/controllers/user_controller.dart';
import 'package:person_picker_v2/models/user.dart';

///Class will be used to store current user information to local store ('db.json');
class LocalStore extends Store {
  final File _stateFile = File('db.json');
  late final _active;

  LocalStore() {
    checkFileExists();
  }

  @override
  bool get active => _active;

  //Method will store the current app state into the state file
  @override
  Future<bool> save() async {
    return _stateFile
        .writeAsString(json.encode(
            UserController.to.classes.map((object) => object.json).toList()))
        .then((response) => true)
        .onError((error, stackTrace) {
      logger.e(error);
      return false;
    });
  }

  ///Method will read the db.json file and parse a user object from the read json. s
  @override
  Future<User> load() async => _stateFile.readAsString().then((readBits) {
        List<dynamic> parsedJson = json.decode(readBits);
        return User.fromJson(parsedJson.first);
      });

  ///Utility function checks weather the state file exits.
  void checkFileExists() => _stateFile.exists().then((response) => response
      ? {
          logger.i('${_stateFile.absolute} Found Loading Previous app state'),
          _active = true
        }
      : {
          logger.i(
              '${_stateFile.absolute} not Found, Creating new App State File'),
          _stateFile.writeAsString('').then((result) => logger.i(result)),
          _active = true
        });
}
