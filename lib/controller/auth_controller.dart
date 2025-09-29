import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_pump/model/user_model.dart';
import 'package:water_pump/presentation/screens/dashboard_screen.dart';
import 'package:water_pump/presentation/screens/signin_screen.dart';

class AuthController extends GetxController {
  //register user list
  var users = <User>[].obs;
  //logged user
  var loggedUser = Rxn<User>();

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    if (box.read('loggedUserEmail') != null) {
      final email = box.read('loggedUserEmail');
      loggedUser.value = users.firstWhereOrNull((u) => u.email == email);
    }
  }

  //Signup function
  void signUp(String email, String password) {
    if (users.any((user) => user.email == email)) {
      Get.snackbar(
        "Error",
        "Email already registered",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    users.add(User(, email: email, password: password));
    Get.snackbar(
      "Success",
      "User Registered Successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //  SignIN function
  void signIN(String email, String password) {
    final user = users.firstWhereOrNull(
      (user) => user.email == email && user.password == password,
    );

    if (user != null) {
      loggedUser.value = user;
      Get.offAll(DashboardScreen());
    } else {
      Get.snackbar(
        "Error",
        "Invalid email or password",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() {
    loggedUser.value = null;
    box.remove('loggedUserEmail');
    Get.off(SignInScreen());
  }
}
