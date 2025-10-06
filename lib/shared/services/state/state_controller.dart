import 'package:get/get.dart';
import 'package:storybook_gnp/src/modules/login/login_model.dart';

class StateController extends GetxController {
  // Datos principales
  final Rx<UserModel> user = UserModel.empty().obs;
  // final Rx<ProfileMdl> profile = ProfileMdl.empty().obs;

  // Setters
  void setUser(UserModel newUser) => user.value = newUser;
  // void setProfile(ProfileMdl newProfile) => profile.value = newProfile;

  // Accesos rápidos
  bool get isLoggedIn => user.value.nombreCompleto.isNotEmpty;

  // Reset general (por ejemplo, al cerrar sesión)
  void reset() {
    user.value = UserModel.empty();
    // profile.value = ProfileMdl.empty();
  }
}
