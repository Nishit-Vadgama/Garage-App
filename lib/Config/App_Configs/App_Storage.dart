import 'package:get_storage/get_storage.dart';

class AppStorage {
  static final AppStorage _instance = AppStorage._internal();
  AppStorage._internal();
  factory AppStorage() => _instance;

  static final GetStorage App_Storage = GetStorage();

  static read(String key) => App_Storage.read(key);

  static write(String key, dynamic value) => App_Storage.write(key, value);
}
