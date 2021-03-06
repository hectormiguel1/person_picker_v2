import 'dart:collection';

import 'package:get/get.dart';
import 'package:person_picker_v2/controllers/app_controller.dart';
import 'package:person_picker_v2/controllers/participant_controller.dart';
import 'package:person_picker_v2/controllers/store_controller.dart';
import 'package:person_picker_v2/models/class.dart';
import 'package:person_picker_v2/models/participant.dart';

class ClassController extends GetxController {
  late Rx<Class> _selectedClass;

  ClassController(Class selectedClass) {
    _selectedClass = Rx<Class>(selectedClass);
  }

  ///Chenged the controller to observe a new class object, notifies listeners.
  void changeSelectedClass(Class newSelectedClass) {
    _selectedClass = Rx<Class>(newSelectedClass);
    refresh();
  }

  static ClassController get to => Get.find<ClassController>();

  ///Get the list of participants in the selected class.
  UnmodifiableListView<Participant> get participants =>
      UnmodifiableListView(_selectedClass.value.classParticipants);

  String get className => _selectedClass.value.className.trim();

  ///Adds the new participant to the class, notifies listeners.
  void addParticipant(Participant newParticipant) => _selectedClass
      .update((val) => val!.classParticipants.add(newParticipant));

  ///Method will check if the ParticipantController has been registered with GetX
  /// If it was, inform the controller to observe the newly selected user
  /// Othweise, register the controller with the selected user.
  void selectParticipant(String participantUid) {
    Get.isRegistered<ParticipantController>()
        ? ParticipantController.to.changeParticipant(_selectedClass
            .value.classParticipants
            .firstWhere((participant) => participant.uid == participantUid))
        : Get.put<ParticipantController>(ParticipantController(_selectedClass
            .value.classParticipants
            .firstWhere((participant) => participant.uid == participantUid)));
    AppController.to.dispatchAppRefresh();

    refresh();
  }

  ///Called to assigns participants to groups at random. Notifies listeners.
  void assignGroupsAtRandom(int numOfMembers) {
    _selectedClass.update((value) => value?.assignToGroupsRandom(numOfMembers));
    AppController.to.dispatchAppRefresh();
    refresh();
  }

  ///Removes a participant from the provided group. Notified Listeners.
  void removeGroupMember(int groupNumber, String participantUID) {
    _selectedClass.update((value) => value!.groups[groupNumber].members
        .removeWhere((member) => member.uid == participantUID));
    AppController.to.dispatchAppRefresh();
    refresh();
  }

  ///Adds a participant to the provided {groupNumber}. Notifies listeners.
  void addGroupMember(int groupNumber, Participant newParticipant) {
    _selectedClass.update(
        (value) => value!.groups[groupNumber].addMember(newParticipant));
    AppController.to.dispatchAppRefresh();
    refresh();
  }

  @override
  void refresh() {
    StoreController.to.storage.save();
    super.refresh();
  }
}
