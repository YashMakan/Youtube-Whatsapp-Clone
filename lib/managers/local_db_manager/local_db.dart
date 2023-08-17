import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsapp_redesign/models/user.dart';
import 'local_db_routes.dart';

class LocalDB {
  static void initialize() async {
    await Hive.initFlutter();
    await Future.wait(LocalDBRoutes.routes.map((e) => Hive.openBox(e)));
  }

  static bool get isUserLoggedIn =>
      Hive.box(LocalDBRoutes.userRoute).get(User.uuidKey) != null;

  static User get user =>
      User.fromJson(Hive.box(LocalDBRoutes.userRoute).toMap());

  static Future<void> setUser(User? user) async => user == null
      ? await Hive.box(LocalDBRoutes.userRoute).clear()
      : await Hive.box(LocalDBRoutes.userRoute).putAll(user.toJson());
}
