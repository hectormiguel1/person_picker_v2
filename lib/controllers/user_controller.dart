import 'dart:collection';

import 'package:get/get.dart';
import 'package:person_picker_v2/controllers/app_controller.dart';
import 'package:person_picker_v2/controllers/class_controller.dart';
import 'package:person_picker_v2/controllers/store_controller.dart';
import 'package:person_picker_v2/models/class.dart';
import 'package:person_picker_v2/models/participant.dart';
import 'package:person_picker_v2/models/user.dart';

class UserController extends GetxController {
  late final Rx<User> _user;

  UserController(User user) {
    _user = Rx<User>(user);
  }

  static UserController get to => Get.find<UserController>();

  ///Adds a new class to the current user.
  void addClass(Class newClass) {
    _user.update((user) => user?.classes.add(newClass));
  }

  ///Returns the list of classes for the current user in an inmodifiable list view.
  UnmodifiableListView<Class> get classes =>
      UnmodifiableListView(_user.value.classes);

  ///Method will check if the ClassController has already been registered with Get,
  ///If it has, inform the controller to observe the new selected class,
  ///Otherwise, register the controller with GetX with the selected class.
  void selectClass(String classUid) {
    Get.isRegistered<ClassController>()
        ? ClassController.to.changeSelectedClass(_user.value.classes
            .firstWhere((element) => element.uid == classUid))
        : Get.put<ClassController>(ClassController(_user.value.classes
            .firstWhere((element) => element.uid == classUid)));
    AppController.to.dispatchAppRefresh();
    refresh();
  }

  @override
  void refresh() {
    StoreController.to.storage.save();
  }
}
