import 'package:get/get.dart';

class AppController extends GetxController {
  final _refreshCounter = 0.obs;

  int get count => _refreshCounter.value;

  static AppController get to => Get.find<AppController>();

  void dispatchAppRefresh() => _refreshCounter.value++;
}
