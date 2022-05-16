import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString username = "".obs;
  RxString password = "".obs;
  int validate() {
    if (username.value.isNotEmpty && password.value.isNotEmpty)
      return 1;
    else if (username.value.isEmpty)
      return 0;
    else if (password.value.isEmpty)
      return -1;
    else
      return -2;
  }
}
