import 'dart:io';

import 'package:flutter/material.dart';
import 'package:person_picker_v2/constants/logger.dart';

///Manages storing files locally to a json file. This class will be used to dump the current state of the app to json.
class LocalStore {
  final File _stateFile = File('appState.json');

  LocalStore() {
    checkFileExists();
  }

  void checkFileExists() => _stateFile.exists().then((response) => response
      ? {
          logger.i('${_stateFile.absolute} Found Loading Previous app state'),
        }
      : {
          logger.i(
              '${_stateFile.absolute} not Found, Creating new App State File'),
          _stateFile.writeAsString('').then((result) => logger.i(result))
        });
}
