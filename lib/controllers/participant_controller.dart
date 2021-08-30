import 'package:get/get.dart';
import 'package:person_picker_v2/controllers/store_controller.dart';
import 'package:person_picker_v2/models/participant.dart';

class ParticipantController extends GetxController {
  late Rx<Participant> _participant;

  ///Returnns the current participant in a read only carbon clone object.
  ReadOnlyParticipant get participant => _participant.value.toReadOnly();

  ParticipantController(Participant selectedParticipant) {
    _participant = Rx<Participant>(selectedParticipant);
  }

  static ParticipantController get to => Get.find<ParticipantController>();

  // Get the name of the participant
  String get name => _participant.value.name;

  /// Get the points of the current participant.
  int get points => _participant.value.points;

  /// Incremenets the current points of the participant by 1
  void increment() {
    _participant.update((participant) => participant!.points++);
    refresh();
  }

  /// Lowers the current points of the participant by 1.
  void decrement() {
    _participant.update((val) => val!.points--);
    refresh();
  }

  ///Resets the current participants points.
  void reset() {
    _participant.update((val) => val!.points = 0);
    refresh();
  }

  ///Updates the current participants name.
  void updateName(String newName) =>
      _participant.update((participant) => participant!.name = newName);
  //Change the patticipant the controller is watching, notifies listeners.
  void changeParticipant(Participant newParticipant) {
    _participant = Rx<Participant>(newParticipant);
    refresh();
  }

  @override
  void refresh() {
    StoreController.to.storage.save();
    super.refresh();
  }
}
