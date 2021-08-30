import 'package:get/get.dart';
import 'package:person_picker_v2/backend/store.dart';

class StoreController extends GetxController {
  late final Store storage;

  StoreController(this.storage);

  static StoreController get to => Get.find<StoreController>();

  bool get active => storage.active;
}
