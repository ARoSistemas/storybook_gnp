import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:storybook_gnp/core/services/storage/istorage.dart';
import 'package:storybook_gnp/core/services/storage/storage_property.dart';
import 'package:storybook_gnp/src/modules/login/login_model.dart';

class UserStorage extends IStorage {
  @override
  final String boxName = 'userBox';

  @override
  final GetStorage box = GetStorage('userBox');

  @override
  final Set<StorageProperty> properties = {
    StorageProperty<String>(
      key: 'user',
      defaultValue: '',
      value: '',
    ),
  };

  StorageProperty<String> get user =>
      properties.firstWhere((p) => p.key == 'user') as StorageProperty<String>;

  void saveUser(LoginModel userMdl) {
    save(user, jsonEncode(userMdl.toJson()));
  }

  LoginModel? getUser() {
    final String value = user.value;
    if (user.value.isEmpty) {
      return null;
    }
    return LoginModel.fromMap(json.decode(value));
  }
}
