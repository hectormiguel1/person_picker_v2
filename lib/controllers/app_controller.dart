import 'package:get/get.dart';
import 'package:person_picker_v2/backend/local_storage.dart';
import 'package:person_picker_v2/constants/logger.dart';
import 'package:person_picker_v2/controllers/store_controller.dart';
import 'package:person_picker_v2/controllers/user_controller.dart';

class AppController extends GetxController {
  final _refreshCounter = 0.obs;

  int get count => _refreshCounter.value;

  AppController() {
    Get.put<StoreController>(StoreController(LocalStore()));
    bool state = StoreController.to.active;
    if (StoreController.to.storage.active) {
      //Method to load the User Object from json and start creating.
      _loadDataFromStore();
    } else {
      logger.e('No Active Connection to Persitance DB Detected. ');
    }
  }

  void _loadDataFromStore() {
    StoreController.to.storage.load().then((user) {
      Get.put<UserController>(UserController(user));
      _refreshCounter.value++;
    });
  }

  static AppController get to => Get.find<AppController>();

  void dispatchAppRefresh() => _refreshCounter.value++;
}
